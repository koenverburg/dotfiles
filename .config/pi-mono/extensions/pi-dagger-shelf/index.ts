/**
 * pi-dagger-shelf — a minimal top bar inspired by dagger's clean aesthetic
 *
 * Displays:
 *  Left:    folder  branch  provider/model  
 *  Middle:  tok/s  cost  duration  tool calls
 *  Right:   context usage  mode
 */

import type { AssistantMessage } from "@mariozechner/pi-coding-agent";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@mariozechner/pi-tui";
import { basename } from "node:path";

export default function (pi: ExtensionAPI) {
	// ── tracked state ────────

	let sessionStart = Date.now();
	let totalToolCalls = 0;

	// For tok/s: output tokens in the most-recently-completed turn
	let turnStartMs = 0;
	let lastTurnOutputTokens = 0;
	let lastTurnDurationMs = 0;

	// ── branch tracking ─────

	let branchName = "";

	pi.on("branch_change", async (_event, ctx) => {
		// Branch will be handled differently when available
		// For now, pass empty string
	});

	pi.on("session_start", async (event, ctx) => {
		sessionStart = Date.now();
		totalToolCalls = 0;
		lastTurnOutputTokens = 0;
		lastTurnDurationMs = 0;

		ctx.ui.setHeader((tui, theme, _headerData) => {
			// No branch subscription needed for header

			return {
				dispose: () => {},
				invalidate() {},

				render(width: number): string[] {
					// ── helpers ──

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

					// ── left ── folder  branch  provider/model

					const folder = basename(ctx.cwd) || ctx.cwd;
					const branch = branchName; // Already tracked from branch_change
					const model = ctx.model;
					const modelName = model?.id ?? "no-model";
					const provider = model?.provider ?? "";

					const folderSeg = theme.fg("dim", ` ${folder} `);
					const branchSeg = branch ? theme.fg("accent", ` [${branch}] `) : "";
					const modelSeg = theme.fg("dim", ` ${provider}/${modelName} `);

					// ── middle ── tok/s  cost  duration  tool calls

					const toksPerSec = lastTurnDurationMs > 0
						? `${(lastTurnOutputTokens / (lastTurnDurationMs / 1000)).toFixed(1)} tok/s`
						: theme.fg("dim", "  —   ");

					const cost = sessionCost();
					const costSeg = theme.fg("dim", ` $${cost.toFixed(3)} `);
					const duration = fmtDuration(Date.now() - sessionStart);
					const durationSeg = theme.fg("dim", ` ${duration} `);
					const toolsSeg = theme.fg("dim", ` ${totalToolCalls} tools `);

					// ── right ── context usage  mode

					const usage = ctx.getContextUsage();

					// Determine thinking mode
					const thinkingLevel = pi.getThinkingLevel();
					const thinkingDisplay =
						thinkingLevel === 0 ? theme.fg("dim", "fast") :
						thinkingLevel === 1 ? theme.fg("accent", "think") :
						theme.fg("dim", "deep");

					const usageSeg = usage
						? `${theme.fg("dim", ` ${usage.percent?.toFixed(1) || "?"}%`)} `
						: theme.fg("dim", "   ");

					// ── compose ── minimal spacing, clean look

					const left = folderSeg + branchSeg + modelSeg;
					const mid = toksPerSec + costSeg + durationSeg + toolsSeg;
					const right = usageSeg + thinkingDisplay;

					const leftW = visibleWidth(left);
					const midW = visibleWidth(mid);
					const rightW = visibleWidth(right);

					const totalUsed = leftW + midW + rightW;
					const spare = width - totalUsed;

					// Single gap on left for minimal look
					const gapL = Math.max(1, spare);
					const line = " ".repeat(gapL) + left + mid + right;
					return [truncateToWidth(line, width)];
				},
			};
		});
	});

	// ── event listeners ──

	pi.on("turn_start", async (_event, _ctx) => {
		turnStartMs = Date.now();
	});

	pi.on("turn_end", async (_event, headerCtx) => {
		const elapsed = Date.now() - turnStartMs;
		if (elapsed > 0 && headerCtx.message?.role === "assistant" && headerCtx.usage) {
			const msg = headerCtx.message as AssistantMessage;
			lastTurnOutputTokens = msg.usage.output;
			lastTurnDurationMs = elapsed;
		}
	});

	pi.on("tool_execution_end", async (_event, _ctx) => {
		totalToolCalls++;
	});
}
