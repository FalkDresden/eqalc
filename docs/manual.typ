#import "@preview/tidy:0.4.1"
#import "@preview/codly:1.2.0": *
#set raw(lang: "typ")
#let primary = rgb("#239DAD")
#show link: set text(primary)
#show: codly-init.with()
#codly(display-name: false, number-format: none, zebra-fill: none)

#set page(
  header: [
    #h(1fr) #datetime.today().display()
  ],
  numbering: "1.",
)

#let warning(content) = {

  block(
  fill: rgb("#FDF1E5"),
  inset: 1em, 
  radius: 0.5em,
  width: 100%,
  {
    heading(level: 3, text(rgb("#EC7500"))[Warning])
    content
  }
)}

#[
  #set align(center)
  #let prop = toml("../typst.toml").package
  #text(2em, weight: "bold", primary)[Eqalc]\
  #let subtitle = text(1.5em, prop.description)
  #subtitle

  #context {
    box(width: measure(subtitle).width)[v#prop.version
      #h(1fr)
      #prop.authors.join(
        ", ",
        last: " & ",
      )#h(1fr)#prop.license]
  }]

= About
I created this package, because I thought it was very annoying to have to write
down the equation in both math notation and code. This package allows you to
write down the equation in math notation and convert it to a function.

= Usage
You can use this package in two ways:
- You can set the equation equal to a variable, and then use it in one of
  the functions like this:
  ```typ
  #let eq = $ y = 2x + 3 $
  #eq // To show the equation
  #math-to-table(eq)
  ```
- You can use a label to access the equation like this:
  ```typ
  $ y = 2x + 3 $ <eq>
  #context math-to-table(<eq>)
  ```
  #warning[Beware the you must use a unique label for each equation. And that you use a
  `#context` block to use a label.]


#let docs = tidy.parse-module(read("../lib.typ"))
#tidy.show-module(docs, style: tidy.styles.default)

== Utility functions
#let docs = tidy.parse-module(read("../util.typ"))
#tidy.show-module(docs, style: tidy.styles.default)
