describe "Star Grammar", ->
  grammar = null
  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("star-language")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.star")

  it "parses the grammar", ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe "source.star"

  it "tokenizes strings", ->
    {tokens} = grammar.tokenizeLine '"alpha\\(beta+4)gamma"'

    expect(tokens[0]).toEqual value: '"', scopes: ["source.star","string.quoted.double.star",'punctuation.definition.string.begin.star']
    expect(tokens[1]).toEqual value: "alpha", scopes: ["source.star","string.quoted.double.star"]
    expect(tokens[2]).toEqual value: "\\(", scopes: ["source.star","string.quoted.double.star",'embedded.line.star','punctuation.section.embedded.begin.star']
    expect(tokens[3]).toEqual value: "beta", scopes: ["source.star","string.quoted.double.star",'embedded.line.star',"source.star",'variable.language.star']
    expect(tokens[4]).toEqual value: "+", scopes: ["source.star","string.quoted.double.star",'embedded.line.star',"source.star",'support.operator.star']
    expect(tokens[5]).toEqual value: "4", scopes: ["source.star","string.quoted.double.star",'embedded.line.star',"source.star",'constant.numeric.star']
    expect(tokens[6]).toEqual value: ")", scopes: ["source.star","string.quoted.double.star",'embedded.line.star','punctuation.section.embedded.end.star']
    expect(tokens[7]).toEqual value: "gamma", scopes: ["source.star","string.quoted.double.star"]
    expect(tokens[8]).toEqual value: '"', scopes: ["source.star","string.quoted.double.star",'punctuation.definition.string.end.star']
    expect(tokens.length).toEqual 9
