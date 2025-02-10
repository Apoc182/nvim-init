return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
        -- Add any specific options here
    },
    build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- Adjust as needed for your OS or environment
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
            "hrsh7th/nvim-cmp", -- Optional: Autocompletion
            lazy = true,
        },
        {
            "nvim-tree/nvim-web-devicons", -- Optional: Icons
            lazy = true,
        },
        {
            "zbirenbaum/copilot.lua", -- Optional: Support for Copilot
            lazy = true,
        },
        {
            -- Image pasting support
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    use_absolute_path = true, -- Required for Windows users
                },
            },
        },
        {
            -- Markdown rendering support
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}

