importScripts("worker-base.js");

// load nodejs compatible require
var ace_require = require;
require = undefined;
var Honey = { 'requirePath': ['..'] }; // walk up to js folder, see Honey docs
importScripts("require.js");
var antlr4_require = require;
require = ace_require;

// load antlr4 and myLanguage
var antlr4, mylanguage;
try {
    require = antlr4_require;
    antlr4 = require('js/antlr4/index');
    var CPP14Lexer = require('js/cpp/CPP14Lexer');
    var CPP14Parser = require('js/cpp/CPP14Parser');
    var CPP14Listener = require('js/cpp/CPP14Listener');
    var CPP14Visitor = require('js/cpp/CPP14Visitor');
} finally {
    require = ace_require;
}

// class for gathering errors and posting them to ACE editor
var AnnotatingErrorListener = function(annotations) {
    antlr4.error.ErrorListener.call(this);
    this.annotations = annotations;
    return this;
};

AnnotatingErrorListener.prototype = Object.create(antlr4.error.ErrorListener.prototype);
AnnotatingErrorListener.prototype.constructor = AnnotatingErrorListener;

AnnotatingErrorListener.prototype.syntaxError = function(recognizer, offendingSymbol, line, column, msg, e) {
    this.annotations.push({
        row: line - 1,
        column: column,
        text: msg,
        type: "error"
    });
};

var GetRegex = function(sfor) {
    var request = new XMLHttpRequest();
    request.open('GET', "http://10.151.44.20/elearning/public/convention/getregex/" + sfor, false);  // `false` makes the request synchronous
    request.send(null);

    if (request.status === 200) {
        response = JSON.parse(request.responseText);
        if(response.length == 0) {
            return null;
        } else {
            regex = response[0].regex;
            return regex;
        }
    } else {
        return null;
    }
}

var GetConventionMessage = function(sfor) {
    var request = new XMLHttpRequest();
    request.open('GET', "http://10.151.44.20/elearning/public/convention/getconvmessage/" + sfor, false);  // `false` makes the request synchronous
    request.send(null);

    if (request.status === 200) {
        response = JSON.parse(request.responseText);
        if(response.length == 0) {
            return null;
        } else {
            deskripsi = response[0].deskripsi;
            return deskripsi;
        }
    } else {
        return null;
    }
}

var GetMinLength = function(sfor, text, ctx, annotations) {
    var request = new XMLHttpRequest();
    request.open('GET', "http://10.151.44.20/elearning/public/convention/getconvmin/" + sfor, false);  // `false` makes the request synchronous
    request.send(null);

    if (request.status === 200) {
        response = JSON.parse(request.responseText);
        if(response.length > 0) {
            min = response[0].min;
            if(text.length < min) {
                annotations.push({
                    row: ctx.start.line - 1,
                    column: ctx.start.column,
                    text: response[0].pesanmin + ", minimal " + min + " karakter",
                    type: "warning"
                });
            }
        }
    }
}

var ConventionCheck = function(sfor, ctx, annotations, textspecial) {
    var retext = GetRegex(sfor);
    if(retext != null) {
        var re = new RegExp(retext, 'g');
        if(textspecial) {
            var text = textspecial;
        } else {
            var text = ctx.getText();
        }
        GetMinLength(sfor, text, ctx, annotations);
        var stringexec = re.exec(text);
        if(stringexec == null || text != stringexec[0]) {
            var convmessage = GetConventionMessage(sfor);
            if(convmessage == null) {
                convmessage = "{deskripsi aturan tidak ditemukan}"
            }
            var suggest = SuggestionText(sfor, retext, text, stringexec);
            annotations.push({
                row: ctx.start.line - 1,
                column: ctx.start.column,
                text: "'" + text + "' seharusnya ditulis secara " + convmessage + ". Contoh : '" + suggest + "'",
                type: "warning"
            });
        }
    }
}

var UpperCamelCase = function(text, retext) {
    var re = new RegExp(retext, 'g');
    var ar_right_part = re.exec(text);
    if(ar_right_part == null) {
        var right_part = '';
        if(text.length < 2) {
            var added_wrong_part = text + 'a';
        } else {
            var added_wrong_part = text;
        }
        var lower = added_wrong_part.toLowerCase();
        var capitalize = lower.charAt(0).toUpperCase() + lower.substr(1);
        var final = added_wrong_part.replace(added_wrong_part, capitalize);
        return final;
    } else {
        var arrfinal = [];
        var right_part = ar_right_part[0];
        var arr_wrong_part = text.split(right_part);
        arr_wrong_part.forEach(function(wrong_part) {
            if(wrong_part.length < 2) {
                arrfinal.push('');
            } else {
                var lower = wrong_part.toLowerCase();
                var capitalize = lower.charAt(0).toUpperCase() + lower.substr(1);
                arrfinal.push(capitalize);
            }
        });
        var final = arrfinal[0] + right_part + arrfinal[1];
        return final;
    }
}

var SuggestionText = function(sfor, retext, text, stringexec) {
    var re = new RegExp(retext, 'g');
    if(sfor == 'commonvariable' || sfor == 'structdatamember') {
        var striped = text.replace(/_+/gi, '_');
        var lower = striped.toLowerCase();
        var suggest = re.exec(lower);
        return suggest[0];
    } else if(sfor == 'classdatamember') {
        var added = text + '_';
        var striped = added.replace(/_+/gi, '_');
        var lower = striped.toLowerCase();
        var suggest = re.exec(lower);
        return suggest[0];
    } else if(sfor == 'namespace') {
        var striped = text.replace(/_+/gi, '');
        var suggest = striped.toLowerCase();
        return suggest;
    } else if(sfor == 'enumerator') {
        var striped = text.replace(/_+/gi, '_');
        var upper = striped.toUpperCase();
        var suggest = re.exec(upper);
        return suggest[0];
    } else if(sfor == 'globalvariable') {
        var striped = text.replace(/_+/gi, '_');
        var lower = striped.toLowerCase();
        var final = re.exec(lower);
        if(final == null) {
            var suggest = 'g_' + final[0];
        } else {
            var suggest = final[0];
        }
        return suggest;
    } else if(sfor == 'classandstruct' || sfor == 'typedef' || sfor == 'alias' || sfor == 'enum' || sfor == 'function' || sfor == 'constant') {
        console.log(text);
        console.log(sfor);
        var suggest = '';
        if(text.indexOf('_') > -1) {
            var striped = text.replace(/_+/gi, '_');
            var arrsplit = striped.split('_');
            arrsplit.forEach(function(splited) {
                suggest += UpperCamelCase(splited, retext);
            });
        } else {
            suggest = UpperCamelCase(text, retext);
        }

        if(sfor == 'constant') {
            return 'k' + suggest;
        } else {
            return suggest;
        }
    }
}

StatementPrinter = function(annotations) {
    CPP14Listener.CPP14Listener.call(this);
    this.annotations = annotations;
    return this;
};

StatementPrinter.prototype = Object.create(CPP14Listener.CPP14Listener.prototype);
StatementPrinter.prototype.constructor = StatementPrinter;

var typedefpotential = false;
var constpotensial = false;
StatementPrinter.prototype.enterDeclspecifier = function (ctx) {
    console.log('enterDeclspecifier');
    console.log(ctx.getText());
    if(ctx.getText() == 'typedef') {
        typedefpotential = true;
    } else if(ctx.getText() == 'const') {
        constpotensial = true;
    }
}

// wrong output
StatementPrinter.prototype.enterConstantexpression = function (ctx) {
    console.log('enterConstantexpression');
    console.log(ctx.getText());
}

StatementPrinter.prototype.enterNamespacedefinition = function (ctx) {
    var sfor = 'namespace';
    var text = ctx.getText();
    var deletednamespace = text.replace('namespace', '');
    var namespacename = deletednamespace.split('{');
    ConventionCheck(sfor, ctx, this.annotations, namespacename[0]);
}

StatementPrinter.prototype.enterNamespacename = function (ctx) {
    var sfor = 'namespace';
    ConventionCheck(sfor, ctx, this.annotations);
}

var variablepotential = false;
var initialchar = '';
StatementPrinter.prototype.enterSimpledeclaration = function (ctx) {
    var text = ctx.getText();
    console.log('enterSimpledeclaration');
    console.log(ctx.getText()); 
    variablepotential = true;
    initialchar = text.substr(0, 1);
}

StatementPrinter.prototype.exitSimpledeclaration = function (ctx) {
    console.log('exitSimpledeclaration');
    console.log(ctx.getText());
    variablepotential = false;
    typedefpotential = false;
    initialchar = '';
}

StatementPrinter.prototype.enterMemberdeclarator = function (ctx) {
    variablepotential = false;
    console.log('enterMemberdeclarator');
    console.log(ctx.getText());
    console.log(initialchar);
    if(initialchar == 'c') {
        var sfor = 'classdatamember';
    } else if(initialchar == 's') {
        var sfor = 'structdatamember';
    }
    ConventionCheck(sfor, ctx, this.annotations);
}

StatementPrinter.prototype.enterEnumhead = function (ctx) {
    var sfor = 'enum';
    var text = ctx.getText();
    var enumname = text.replace('enum', '');
    ConventionCheck(sfor, ctx, this.annotations, enumname);
}

StatementPrinter.prototype.enterEnumerator = function (ctx) {
    var sfor = 'enumerator';
    ConventionCheck(sfor, ctx, this.annotations);
}

StatementPrinter.prototype.enterAliasdeclaration = function (ctx) {
    var sfor = 'alias';
    var text = ctx.getText();
    var usingdeleted = text.replace('using', '');
    var aliasname = usingdeleted.split('=');
    ConventionCheck(sfor, ctx, this.annotations, aliasname[0]);
}

StatementPrinter.prototype.enterClassname = function (ctx) {
    var sfor = 'classandstruct';
    if(ctx.getText() != 'string') {
        ConventionCheck(sfor, ctx, this.annotations);
    }
};

StatementPrinter.prototype.enterDeclarator = function (ctx) {
    console.log('enterDeclarator');
    console.log(ctx.getText());
    var text = ctx.getText();
    if(text.indexOf('main(') < 0) {
        if(text.indexOf(')') > -1) {
            var splitedfunction = text.split("(");
            var functionname = splitedfunction[0];
            var sfor = 'function';
            ConventionCheck(sfor, ctx, this.annotations, functionname);
        } else {
            if(typedefpotential == false && constpotensial == false) {
                if(variablepotential == true) {
                    var sfor = 'commonvariable';
                    ConventionCheck(sfor, ctx, this.annotations);
                }
            } else if(typedefpotential == true) {
                var sfor = 'typedef';
                ConventionCheck(sfor, ctx, this.annotations);
            } else if(constpotensial == true) {
                var sfor = 'constant';
                ConventionCheck(sfor, ctx, this.annotations);
            }
        }
    }
};

StatementPrinter.prototype.exitDeclarator = function (ctx) {
    var text = ctx.getText();
    if(text.indexOf('main(') < 0) {
        if(text.indexOf(')') > -1) {
            islocal = false;
        }
    }
};

ace.define('ace/worker/my-worker',["require","exports","module","ace/lib/oop","ace/worker/mirror"], function(require, exports, module) {
    "use strict";

    var oop = require("ace/lib/oop");
    var Mirror = require("ace/worker/mirror").Mirror;

    var MyWorker = function(sender) {
        Mirror.call(this, sender);
        this.setTimeout(500);
        this.$dialect = null;
    };

    oop.inherits(MyWorker, Mirror);

    (function() {
        this.onUpdate = function() {
            var value = this.doc.getValue();
            var annotations = validate(value);
            this.sender.emit("annotate", annotations);
        };

    }).call(MyWorker.prototype);

    exports.MyWorker = MyWorker;
});

var validate = function(input) {
    var stream = new antlr4.InputStream(input);
    var lexer = new CPP14Lexer.CPP14Lexer(stream);
    var tokens = new antlr4.CommonTokenStream(lexer);
    var parser = new CPP14Parser.CPP14Parser(tokens);

    var annotations = [];
    var listener = new AnnotatingErrorListener(annotations)
    parser.removeErrorListeners();
    parser.addErrorListener(listener);
    var tree = parser.translationunit();
    parser.buildParseTrees = true;

    var printer = new StatementPrinter(annotations);
    antlr4.tree.ParseTreeWalker.DEFAULT.walk(printer, tree);

    return annotations;
};