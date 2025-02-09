#import "@preview/tidy:0.4.1"
#set raw(lang: "typ")
#let primary = rgb("#239DAD")
#show link: set text(primary)

#set page(
  header: [
    #h(1fr) #datetime.today().display()
  ],
  numbering: "1."
)

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
#let docs = tidy.parse-module(read("../lib.typ"))
#tidy.show-module(docs, style: tidy.styles.default)

== Utility functions
#let docs = tidy.parse-module(read("../util.typ"))
#tidy.show-module(docs, style: tidy.styles.default)
