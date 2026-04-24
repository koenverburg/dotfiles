/**
 * pi-statusline — a custom single-line footer showing:
 *
 *  Left:   folder  branch  $cost  ctx%/ctxWindow (auto)
 *  Middle: tok/s  duration  tool calls
 *  Right:  provider/model (thinking)
 */

import type { AssistantMessage } from "@mariozechner/pi-coding-agent";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@mariozechner/pi-tui";
import { basename } from "node:path";

export default function (pi: ExtensionAPI) {
	// ── tracked state ────────────────────────────────────────────────────────

	let sessionStart = Date.now();
	let totalToolCalls = 0;

	// For tok/s: track output tokens and elapsed time across completed turns
	let turnStartMs = 0;
	let lastTurnOutputTokens = 0; // output tokens in the most-recently-completed turn
	let lastTurnDurationMs = 0;   // wall time of the most-recently-completed turn

	pi.on("session_start", async (event, ctx) => {
		sessionStart = Date.now();
		totalToolCalls = 0;
		lastTurnOutputTokens = 0;
		lastTurnDurationMs = 0;

		ctx.ui.setFooter((tui, theme, footerData) => {
			const unsub = footerData.onBranchChange(() => tui.requestRender());

			return {
				dispose: unsub,
				invalidate() {},

				render(width: number): string[] {
					// ── helpers ──────────────────────────────────────────────

					function fmtWindow(n: number): string {
						if (n >= 1_000_000) return `${(n / 1_000_000).toFixed(1)}M`;
						if (n >= 1_000) return `${(n / 1_000).toFixed(0)}k`;
						return `${n}`;
					}

					function fmtDuration(ms: number): string {
						const s = Math.floor(ms / 1000);
						if (s < 60) return `${s}s`;
						const m = Math.floor(s / 60);
						const rem = s % 60;
						if (m < 60) return `${m}m${rem.toString().padStart(2, "0")}s`;
						const h = Math.floor(m / 60);
						return `${h}h${(m % 60).toString().padStart(2, "0")}m`;
					}

					function sessionCost(): number {
						let cost = 0;
						for (const e of ctx.sessionManager.getBranch()) {
							if (e.type === "message" && e.message.role === "assistant") {
								cost += (e.message as AssistantMessage).usage.cost.total;
							}
						}
						return cost;
					}

					// ── left ─────────────────────────────────────────────────

					const folder = basename(ctx.cwd) || ctx.cwd;
					const branch = footerData.getGitBranch();
					const cost = sessionCost();
					const usage = ctx.getContextUsage();

					const folderSeg = theme.fg("accent", ` ${folder} `);
					const branchSeg = branch ? theme.fg("dim", ` ${branch} `) : "";
					const duration = fmtDuration(Date.now() - sessionStart);
					const costSeg = theme.fg("dim", ` $${cost.toFixed(3)} `);
					const durationSeg = theme.fg("dim", ` ${duration} `);

					let usageSeg = "";
					if (usage) {
						const pct = usage.percent !== null ? `${usage.percent.toFixed(1)}%` : "?%";
						usageSeg = theme.fg("dim", ` ${pct}/${fmtWindow(usage.contextWindow)} (auto) `);
					}

					// ── middle ───────────────────────────────────────────────

					const toksPerSec =
						lastTurnDurationMs > 0
							? (lastTurnOutputTokens / (lastTurnDurationMs / 1000)).toFixed(1)
							: "—";

					const midSeg = theme.fg("dim",
						` ${toksPerSec} tok/s  ${totalToolCalls} tools `,
					);

					// ── right ────────────────────────────────────────────────

					const model = ctx.model;
					const modelName = model?.id ?? "no-model";
					const provider = model?.provider ?? "";
					const thinking = pi.getThinkingLevel();

					const rightSeg = theme.fg("dim", `${provider}/${modelName} (${thinking}) `);

					// ── compose ──────────────────────────────────────────────

					const left = folderSeg + branchSeg + costSeg + durationSeg + usageSeg;
					const mid = midSeg;
					const right = rightSeg;

					const leftW = visibleWidth(left);
					const midW = visibleWidth(mid);
					const rightW = visibleWidth(right);

					const totalUsed = leftW + midW + rightW;
					const spare = width - totalUsed;

					// Distribute spare space: half before mid, half after
					const gapL = Math.max(1, Math.floor(spare / 2));
					const gapR = Math.max(1, spare - gapL);

					const line = left + " ".repeat(gapL) + mid + " ".repeat(gapR) + right;
					return [truncateToWidth(line, width)];
				},
			};
		});
	});

	// ── event listeners to keep state fresh ─────────────────────────────────

	pi.on("turn_start", async (_event, _ctx) => {
		turnStartMs = Date.now();
	});

	pi.on("turn_end", async (event, _ctx) => {
		const elapsed = Date.now() - turnStartMs;
		if (elapsed > 0 && event.message.role === "assistant") {
			const msg = event.message as AssistantMessage;
			lastTurnOutputTokens = msg.usage.output;
			lastTurnDurationMs = elapsed;
		}
	});

	pi.on("tool_execution_end", async (_event, _ctx) => {
		totalToolCalls++;
	});
}
