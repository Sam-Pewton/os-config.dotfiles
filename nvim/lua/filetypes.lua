-- Extra filetype definitions for the LSP
vim.filetype.add {
    filename = {
	["Dockerfile.*"] = "dockerfile",
    },
    extension = {
	jinja = "jinja",
	jinja2 = "jinja",
	j2 = "jinja",
    },
}
