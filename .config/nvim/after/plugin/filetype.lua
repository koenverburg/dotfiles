require("filetype").setup {
  overrides = {
    complex= {
      ["/(jenkinsFile)/i"]= "groovy",
    },
  },
}