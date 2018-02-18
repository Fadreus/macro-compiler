defmodule MacroCompiler.Parser.ArrayAssignmentCommand do
  use Combine
  use Combine.Helpers

  alias MacroCompiler.Parser.ArrayAssignmentCommand
  alias MacroCompiler.Parser.ArrayVariable
  alias MacroCompiler.Parser.TextValue

  @enforce_keys [:array_variable, :texts]
  defstruct [:array_variable, :texts]

  def parser() do
    map(
      sequence([
        ArrayVariable.parser(),

        skip(spaces()),
        ignore(string("=")),
        skip(spaces()),

        ignore(char("(")),

        sep_by(
          TextValue.parser(),
          sequence([
            char(","),
            skip(spaces())
          ])
        ),

        ignore(char(")")),

        skip(char(?\n))
      ]),
      fn [scalar_variable, texts] -> %ArrayAssignmentCommand{array_variable: scalar_variable, texts: texts} end
    )
  end
end