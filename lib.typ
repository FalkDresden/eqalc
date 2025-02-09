#import "util.typ": math-to-str, get-variable

/// Creates a function from a math expression.
/// -> math
#let math-to-func(
  /// The math expression.
  /// - content
  math,
) = {
  let string = math-to-str(math)
  let var = get-variable(string)
  x => eval("let " + var + "= " + str(x) + "; " + string)
}

/// Creates a table of function values.
/// -> content
#let math-to-table(
  /// The function to evaluate.
  /// - content
  eq,
  /// The minimum value of the domain.
  /// - number
  min: 0,
  /// The maximum value of the domain.
  /// - number
  max: 5,
  /// The step size.
  /// - number
  step: 1,
  /// The number of decimal places to round to.
  /// - number
  round: 2,
  /// The name of the function.
  /// - content
  name: none,
) = {
  assert(min < max, message: "min must be less than max")
  assert(step > 0, message: "step must be greater than 0")
  let var = get-variable(math-to-str(eq))
  let f = math-to-func(eq)
  let name = if name != none { name } else { $f(#var)$ }
  table(
    columns: calc.ceil((max - min) / step) + 2,
    [$#var$], ..range(min, max + step, step: step).map(x => [$#x$]),
    name, ..range(
      min,
      max + step,
      step: step,
    ).map(x => [#calc.round(f(x), digits: round)]),
  )
}

/// Converts a math expression to code.
/// -> content
#let math-to-code(
  /// The math expression.
  /// - equation
  math,
) = {
  let f = math-to-str(math)
  raw(lang: "typst", f)
}

#let f = $2y dot sqrt(e^y)+ln(y)+2pi$
#f\
#repr(f)

#math-to-str(f)
#math-to-table(f, min: 1, max: 5, step: 1)
