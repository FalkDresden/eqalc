#import "@preview/mantys:1.0.0": *
#set raw(lang: "typ")

#show: mantys(
  name: "eqalc",
  version: "0.1.0",
  authors: (
    "Tijme",
  ),
  license: "MIT",
  description: "Convert math equations to functions.",
  repository: "https://github.com/7ijme/eqalc",

  /// Uncomment one of the following lines to load the above
  /// package information directly from the typst.toml file
  // ..toml("typst.toml"),

  title: "Eqalc",
  // subtitle: "Tagline",
  date: datetime.today(),
)

= About
I created this package, because I thought it was very annoting to have to write
down the equation in both math notation and code. This package allows you to
write down the equation in math notation and convert it to a function.

= Usage
#command(
  "math-to-func",
  arg("math", "equation"),
  [
    This function converts a math equation to a function.

    #example[`#math-to-func($x^2 + 2x + 1$)`][
      #frame[
        $-->$ `#{calc.pow(x^2) + 2*x + 1}`
      ]
    ]
  ],
)

#command(
  "math-to-code",
  arg("math", "equation"),

  [
    This function converts a math equation to a code block.

    #example[`#math-to-func($x^2 + 2x + 1$)`][
      #frame[
        $-->$ `#raw(lang: "typ")[calc.pow(x^2) + 2*x + 1]`
      ]
    ]
  ],
)

#command(
  "func-to-table",
  arg("f", "function"),
  arg("min", "number: 0"),
  arg("max", "number: 5"),
  arg("step", "number: 1"),
  arg("round", "number: 2"),
  [
    This function converts a function to a table.

    #example[`#func-to-table(x => calc.pow(x, 2))`][
      #frame[
        #table(columns: 6, [$x$], ..range(0, 5).map(x => [#x]), $f(x)$, ..range(
            0,
            5,
          ).map(x => [#calc.pow(x, 2)]))
      ]
    ]
  ],
)

