return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_markers = { 'package.json', '.git' },
  settings = {
    html = {
      format = {
        enable = false,
      },
    },
  },
}
