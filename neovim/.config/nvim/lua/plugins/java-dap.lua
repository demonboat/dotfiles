-- stylua: ignore

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require('dap')
    dap.configurations.java = {
      {
        type = 'java',
        name = 'Spring Boot',
        request = 'launch',
        preLaunchTask = 'gradle: bootRun',
        mainClass = 'dev.dreameh.preLaunchTaskting_new.TestingNewApplication',
        projectName = 'testing_new',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal'
      },
    }
  end,
}
