local ls = require("luasnip")
local f = ls.function_node
local i = ls.insert_node
local t = ls.text_node
local s = ls.snippet

local function filename()
  return vim.fn.expand("%:t:r")
end

local function package_name()
  local path = vim.fn.expand("%:p:h")
  local src_idx = path:find("/src/")
  if src_idx then
    path = path:sub(src_idx + 5)
    path = path:gsub("^main/java/", "")
    path = path:gsub("^test/java/", "")
  end
  local pkg = path:gsub("/", ".")
  return pkg ~= "" and "package " .. pkg .. ";" or ""
end

return {
  -- Java class snippet
  s("javaclass", {
    f(package_name, {}),
    t({ "", "" }),
    t({ "/**", " * " }),
    i(1, "Class description"),
    t({ "", " */" }),
    t({ "", "public class " }),
    f(filename, {}),
    t({ " {", "    " }),
    i(0),
    t({ "", "}" }),
  }),
  -- Java interface snippet
  s("javainterface", {
    f(package_name, {}),
    t({ "", "" }),
    t({ "/**", " * " }),
    i(1, "Interface description"),
    t({ "", " */" }),
    t({ "", "public interface " }),
    f(filename, {}),
    t({ " {", "    " }),
    i(0),
    t({ "", "}" }),
  }),
  -- Java enum snippet
  s("javaenum", {
    f(package_name, {}),
    t({ "", "" }),
    t({ "/**", " * " }),
    i(1, "Enum description"),
    t({ "", " */" }),
    t({ "", "public enum " }),
    f(filename, {}),
    t({ " {", "    " }),
    i(0),
    t({ "", "}" }),
  }),
  -- Java method with smart Javadoc
  s("javamethod", {
    t({ "/**", " * " }),
    i(1, "Description"),
    t({ "" }),
    ls.function_node(function(args)
      local params = args[1][1] or ""
      local result = {}
      for _, name in params:gmatch("([%w_]+)%s+([%w_]+)") do
        table.insert(result, " * @param " .. name)
      end
      return result
    end, { 4 }),
    t({ "", " */" }),
    t({ "", "public " }),
    i(2, "void"),
    t(" "),
    i(3, "methodName"),
    t("("),
    i(4, "int foo, String bar"),
    t(") {"),
    t({ "", "    " }),
    i(0),
    t({ "", "}" }),
  }),
  -- Javadoc for methods
  s("javadocmethod", {
    t({ "/**", " * " }),
    i(1, "Method description"),
    t({ "", " * @param " }),
    i(2, "param"),
    t({ "", " * @return " }),
    i(3, "return description"),
    t({ "", " */" }),
    t({ "", "" }),
    i(0),
  }),
  -- Javadoc for constructors
  s("javadocctor", {
    t({ "/**", " * " }),
    i(1, "Constructor description"),
    t({ "", " */" }),
    t({ "", "public " }),
    f(filename, {}),
    t("("),
    i(2, "params"),
    t(") {"),
    t({ "", "    " }),
    i(0),
    t({ "", "}" }),
  }),
  -- Javadoc for fields
  s("javadocfield", {
    t({ "/**", " * " }),
    i(1, "Field description"),
    t({ "", " */" }),
    t({ "", "" }),
    i(0),
  }),
  -- Javadoc for enum fields
  s("javadocenumfield", {
    t({ "/**", " * " }),
    i(1, "Enum constant description"),
    t({ "", " */" }),
    t({ "", "" }),
    i(0),
  }),
}
