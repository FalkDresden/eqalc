/// Converts math equations to strings.
/// -> string
#let math-to-str(
  /// The math expression.
  /// - equation
  eq,
  depth: 0,
) = {
  let map-math(n) = {
    // Operators like sin, cos, etc.
    if n.func() == math.op {
      "calc." + n.fields().text.text
      // Parentheses
    } else if n.func() == math.lr {
      math-to-str(n.body, depth: depth + 1)
      // Powers
    } else if n.has("base") and n.has("t") {
      "calc.pow(" + math-to-str(n.base) + ", " + math-to-str(n.t) + ")"
      // Roots
    } else if n.func() == math.root {
      (
        "calc.root("
          + math-to-str(n.radicand, depth: depth + 1)
          + ", "
          + n.at("index", default: "2")
          + ")"
      )
      // Fractions
    } else if n.func() == math.frac {
      (
        "("
          + math-to-str(n.num, depth: depth + 1)
          + ")/("
          + math-to-str(n.denom, depth: depth + 1)
          + ")"
      )
      // Default case
    } else if n == [ ] { } else if n.has("text") {
      if n.text == "e" {
        "calc.e"
      } else if n.text == $pi$.body.text {
        "calc.pi"
      } else if n.text == $tau$.body.text {
        "calc.tau"
      } else {
        n.text
      }
      // This is still a sequence.
    } else {
      math-to-str(n, depth: depth + 1)
    }
  }

  if not type(eq) == "string" and eq.has("body") {
    eq = eq.body
  }
  // Adding `[]` to make it a sequence if it isn't already.
  let nodes = (eq + []).fields().children
  nodes
    .map(map-math)
    .join()
    .replace(
      regex("(\d)\s*(x|calc|\()"),
      ((captures,)) => captures.first() + "*" + captures.last(),
    )
    .replace(math.dot, "*")
}


