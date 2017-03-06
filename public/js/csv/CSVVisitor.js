// Generated from CSV.g4 by ANTLR 4.5.2
// jshint ignore: start
var antlr4 = require('./../antlr4/index');

// This class defines a complete generic visitor for a parse tree produced by CSVParser.

function CSVVisitor() {
	antlr4.tree.ParseTreeVisitor.call(this);
	return this;
}

CSVVisitor.prototype = Object.create(antlr4.tree.ParseTreeVisitor.prototype);
CSVVisitor.prototype.constructor = CSVVisitor;

// Visit a parse tree produced by CSVParser#file.
CSVVisitor.prototype.visitFile = function(ctx) {
};


// Visit a parse tree produced by CSVParser#hdr.
CSVVisitor.prototype.visitHdr = function(ctx) {
};


// Visit a parse tree produced by CSVParser#row.
CSVVisitor.prototype.visitRow = function(ctx) {
};


// Visit a parse tree produced by CSVParser#field.
CSVVisitor.prototype.visitField = function(ctx) {
};



exports.CSVVisitor = CSVVisitor;