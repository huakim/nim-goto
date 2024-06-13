import std/macros

macro label*(labelName, body: untyped): untyped =
  expectKind(labelName, nnkIdent)
  let name = "NIMROD_GOTO_LABEL_" & repr(labelName)
  result = quote do:
    {.emit: `name` & ":".}
    `body`

macro label*(labelName: untyped): untyped =
  expectKind(labelName, nnkIdent)
  let name = "NIMROD_GOTO_LABEL_" & repr(labelName)
  result = quote do:
    {.emit: `name` & ":".}

macro goto*(labelName: untyped): untyped =
  expectKind(labelName, nnkIdent)
  let name = "NIMROD_GOTO_LABEL_" & repr(labelName)
  result = quote do:
    {.emit: "goto " & `name` & ";".}

template jmp*(labelName: untyped): untyped =
  goto labelName

macro until*(condition, body: untyped): untyped =
  result = quote do:
    `body`
    while `condition`:
      `body`

