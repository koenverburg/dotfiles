local is_enabled = require("core.config")

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
    },
    lazy = false,
    enabled = true,
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "./node_modules/.bin/jest",
            jestConfigFile = "./frontend/chk/jest.config.ts",
            env = {
              CI = true,
              TZ = "Europe/Amsterdam",
            },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  },
  {
    "aaronhallaert/continuous-testing.nvim",
    lazy = false,
    enabled = true,
    config = function()
      -- %file will be replace with the test file
      require("continuous-testing").setup({
        notify = true,              -- The default is false
        run_tests_on_setup = false, -- The default is true, run test on attach
        framework_setup = {
          javascript = {
            -- test_tool = "jest", -- cwd of the executing test will be at package.json
            test_cmd = "dum jest --config=frontend/chk/jest.config.ts %file",
            -- root_pattern = "tsconfig.json", -- used to populate the root option of vitest
          },
          typescriptreact = {
            test_tool = "jest", -- cwd of the executing test will be at package.json
            test_cmd = "dum jest --config=frontend/jest.frontend.json %file",
            -- root_pattern = "tsconfig.json", -- used to populate the root option of vitest
          },
        },
        project_override = {
          -- ["/Users/name/Developer/ruby-project"] = {
          --   ruby = {
          --     test_tool = "rspec",
          --     test_cmd = "docker exec -it name -- bundle exec rspec %file",
          --   },
          -- },
        },
      })
    end,
  },
}
