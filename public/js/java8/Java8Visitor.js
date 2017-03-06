// Generated from Java8.g4 by ANTLR 4.5.2
// jshint ignore: start
var antlr4 = require('antlr4/index');

// This class defines a complete generic visitor for a parse tree produced by Java8Parser.

function Java8Visitor() {
	antlr4.tree.ParseTreeVisitor.call(this);
	return this;
}

Java8Visitor.prototype = Object.create(antlr4.tree.ParseTreeVisitor.prototype);
Java8Visitor.prototype.constructor = Java8Visitor;

// Visit a parse tree produced by Java8Parser#literal.
Java8Visitor.prototype.visitLiteral = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#type.
Java8Visitor.prototype.visitType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primitiveType.
Java8Visitor.prototype.visitPrimitiveType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#numericType.
Java8Visitor.prototype.visitNumericType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#integralType.
Java8Visitor.prototype.visitIntegralType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#floatingPointType.
Java8Visitor.prototype.visitFloatingPointType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#referenceType.
Java8Visitor.prototype.visitReferenceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classOrInterfaceType.
Java8Visitor.prototype.visitClassOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classType.
Java8Visitor.prototype.visitClassType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classType_lf_classOrInterfaceType.
Java8Visitor.prototype.visitClassType_lf_classOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classType_lfno_classOrInterfaceType.
Java8Visitor.prototype.visitClassType_lfno_classOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceType.
Java8Visitor.prototype.visitInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceType_lf_classOrInterfaceType.
Java8Visitor.prototype.visitInterfaceType_lf_classOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceType_lfno_classOrInterfaceType.
Java8Visitor.prototype.visitInterfaceType_lfno_classOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeVariable.
Java8Visitor.prototype.visitTypeVariable = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#arrayType.
Java8Visitor.prototype.visitArrayType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#dims.
Java8Visitor.prototype.visitDims = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeParameter.
Java8Visitor.prototype.visitTypeParameter = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeParameterModifier.
Java8Visitor.prototype.visitTypeParameterModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeBound.
Java8Visitor.prototype.visitTypeBound = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#additionalBound.
Java8Visitor.prototype.visitAdditionalBound = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeArguments.
Java8Visitor.prototype.visitTypeArguments = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeArgumentList.
Java8Visitor.prototype.visitTypeArgumentList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeArgument.
Java8Visitor.prototype.visitTypeArgument = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#wildcard.
Java8Visitor.prototype.visitWildcard = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#wildcardBounds.
Java8Visitor.prototype.visitWildcardBounds = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#packageName.
Java8Visitor.prototype.visitPackageName = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeName.
Java8Visitor.prototype.visitTypeName = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#packageOrTypeName.
Java8Visitor.prototype.visitPackageOrTypeName = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#expressionName.
Java8Visitor.prototype.visitExpressionName = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodName.
Java8Visitor.prototype.visitMethodName = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#ambiguousName.
Java8Visitor.prototype.visitAmbiguousName = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#compilationUnit.
Java8Visitor.prototype.visitCompilationUnit = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#packageDeclaration.
Java8Visitor.prototype.visitPackageDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#packageModifier.
Java8Visitor.prototype.visitPackageModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#importDeclaration.
Java8Visitor.prototype.visitImportDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#singleTypeImportDeclaration.
Java8Visitor.prototype.visitSingleTypeImportDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeImportOnDemandDeclaration.
Java8Visitor.prototype.visitTypeImportOnDemandDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#singleStaticImportDeclaration.
Java8Visitor.prototype.visitSingleStaticImportDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#staticImportOnDemandDeclaration.
Java8Visitor.prototype.visitStaticImportOnDemandDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeDeclaration.
Java8Visitor.prototype.visitTypeDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classDeclaration.
Java8Visitor.prototype.visitClassDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#normalClassDeclaration.
Java8Visitor.prototype.visitNormalClassDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classModifier.
Java8Visitor.prototype.visitClassModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeParameters.
Java8Visitor.prototype.visitTypeParameters = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeParameterList.
Java8Visitor.prototype.visitTypeParameterList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#superclass.
Java8Visitor.prototype.visitSuperclass = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#superinterfaces.
Java8Visitor.prototype.visitSuperinterfaces = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceTypeList.
Java8Visitor.prototype.visitInterfaceTypeList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classBody.
Java8Visitor.prototype.visitClassBody = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classBodyDeclaration.
Java8Visitor.prototype.visitClassBodyDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classMemberDeclaration.
Java8Visitor.prototype.visitClassMemberDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#fieldDeclaration.
Java8Visitor.prototype.visitFieldDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#fieldModifier.
Java8Visitor.prototype.visitFieldModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#variableDeclaratorList.
Java8Visitor.prototype.visitVariableDeclaratorList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#variableDeclarator.
Java8Visitor.prototype.visitVariableDeclarator = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#variableDeclaratorId.
Java8Visitor.prototype.visitVariableDeclaratorId = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#variableInitializer.
Java8Visitor.prototype.visitVariableInitializer = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannType.
Java8Visitor.prototype.visitUnannType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannPrimitiveType.
Java8Visitor.prototype.visitUnannPrimitiveType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannReferenceType.
Java8Visitor.prototype.visitUnannReferenceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannClassOrInterfaceType.
Java8Visitor.prototype.visitUnannClassOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannClassType.
Java8Visitor.prototype.visitUnannClassType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannClassType_lf_unannClassOrInterfaceType.
Java8Visitor.prototype.visitUnannClassType_lf_unannClassOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannClassType_lfno_unannClassOrInterfaceType.
Java8Visitor.prototype.visitUnannClassType_lfno_unannClassOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannInterfaceType.
Java8Visitor.prototype.visitUnannInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannInterfaceType_lf_unannClassOrInterfaceType.
Java8Visitor.prototype.visitUnannInterfaceType_lf_unannClassOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannInterfaceType_lfno_unannClassOrInterfaceType.
Java8Visitor.prototype.visitUnannInterfaceType_lfno_unannClassOrInterfaceType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannTypeVariable.
Java8Visitor.prototype.visitUnannTypeVariable = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unannArrayType.
Java8Visitor.prototype.visitUnannArrayType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodDeclaration.
Java8Visitor.prototype.visitMethodDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodModifier.
Java8Visitor.prototype.visitMethodModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodHeader.
Java8Visitor.prototype.visitMethodHeader = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#result.
Java8Visitor.prototype.visitResult = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodDeclarator.
Java8Visitor.prototype.visitMethodDeclarator = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#formalParameterList.
Java8Visitor.prototype.visitFormalParameterList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#formalParameters.
Java8Visitor.prototype.visitFormalParameters = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#formalParameter.
Java8Visitor.prototype.visitFormalParameter = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#variableModifier.
Java8Visitor.prototype.visitVariableModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#lastFormalParameter.
Java8Visitor.prototype.visitLastFormalParameter = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#receiverParameter.
Java8Visitor.prototype.visitReceiverParameter = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#throws_.
Java8Visitor.prototype.visitThrows_ = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#exceptionTypeList.
Java8Visitor.prototype.visitExceptionTypeList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#exceptionType.
Java8Visitor.prototype.visitExceptionType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodBody.
Java8Visitor.prototype.visitMethodBody = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#instanceInitializer.
Java8Visitor.prototype.visitInstanceInitializer = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#staticInitializer.
Java8Visitor.prototype.visitStaticInitializer = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#constructorDeclaration.
Java8Visitor.prototype.visitConstructorDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#constructorModifier.
Java8Visitor.prototype.visitConstructorModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#constructorDeclarator.
Java8Visitor.prototype.visitConstructorDeclarator = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#simpleTypeName.
Java8Visitor.prototype.visitSimpleTypeName = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#constructorBody.
Java8Visitor.prototype.visitConstructorBody = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#explicitConstructorInvocation.
Java8Visitor.prototype.visitExplicitConstructorInvocation = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#enumDeclaration.
Java8Visitor.prototype.visitEnumDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#enumBody.
Java8Visitor.prototype.visitEnumBody = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#enumConstantList.
Java8Visitor.prototype.visitEnumConstantList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#enumConstant.
Java8Visitor.prototype.visitEnumConstant = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#enumConstantModifier.
Java8Visitor.prototype.visitEnumConstantModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#enumBodyDeclarations.
Java8Visitor.prototype.visitEnumBodyDeclarations = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceDeclaration.
Java8Visitor.prototype.visitInterfaceDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#normalInterfaceDeclaration.
Java8Visitor.prototype.visitNormalInterfaceDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceModifier.
Java8Visitor.prototype.visitInterfaceModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#extendsInterfaces.
Java8Visitor.prototype.visitExtendsInterfaces = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceBody.
Java8Visitor.prototype.visitInterfaceBody = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceMemberDeclaration.
Java8Visitor.prototype.visitInterfaceMemberDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#constantDeclaration.
Java8Visitor.prototype.visitConstantDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#constantModifier.
Java8Visitor.prototype.visitConstantModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceMethodDeclaration.
Java8Visitor.prototype.visitInterfaceMethodDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#interfaceMethodModifier.
Java8Visitor.prototype.visitInterfaceMethodModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#annotationTypeDeclaration.
Java8Visitor.prototype.visitAnnotationTypeDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#annotationTypeBody.
Java8Visitor.prototype.visitAnnotationTypeBody = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#annotationTypeMemberDeclaration.
Java8Visitor.prototype.visitAnnotationTypeMemberDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#annotationTypeElementDeclaration.
Java8Visitor.prototype.visitAnnotationTypeElementDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#annotationTypeElementModifier.
Java8Visitor.prototype.visitAnnotationTypeElementModifier = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#defaultValue.
Java8Visitor.prototype.visitDefaultValue = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#annotation.
Java8Visitor.prototype.visitAnnotation = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#normalAnnotation.
Java8Visitor.prototype.visitNormalAnnotation = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#elementValuePairList.
Java8Visitor.prototype.visitElementValuePairList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#elementValuePair.
Java8Visitor.prototype.visitElementValuePair = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#elementValue.
Java8Visitor.prototype.visitElementValue = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#elementValueArrayInitializer.
Java8Visitor.prototype.visitElementValueArrayInitializer = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#elementValueList.
Java8Visitor.prototype.visitElementValueList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#markerAnnotation.
Java8Visitor.prototype.visitMarkerAnnotation = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#singleElementAnnotation.
Java8Visitor.prototype.visitSingleElementAnnotation = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#arrayInitializer.
Java8Visitor.prototype.visitArrayInitializer = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#variableInitializerList.
Java8Visitor.prototype.visitVariableInitializerList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#block.
Java8Visitor.prototype.visitBlock = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#blockStatements.
Java8Visitor.prototype.visitBlockStatements = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#blockStatement.
Java8Visitor.prototype.visitBlockStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#localVariableDeclarationStatement.
Java8Visitor.prototype.visitLocalVariableDeclarationStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#localVariableDeclaration.
Java8Visitor.prototype.visitLocalVariableDeclaration = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#statement.
Java8Visitor.prototype.visitStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#statementNoShortIf.
Java8Visitor.prototype.visitStatementNoShortIf = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#statementWithoutTrailingSubstatement.
Java8Visitor.prototype.visitStatementWithoutTrailingSubstatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#emptyStatement.
Java8Visitor.prototype.visitEmptyStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#labeledStatement.
Java8Visitor.prototype.visitLabeledStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#labeledStatementNoShortIf.
Java8Visitor.prototype.visitLabeledStatementNoShortIf = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#expressionStatement.
Java8Visitor.prototype.visitExpressionStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#statementExpression.
Java8Visitor.prototype.visitStatementExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#ifThenStatement.
Java8Visitor.prototype.visitIfThenStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#ifThenElseStatement.
Java8Visitor.prototype.visitIfThenElseStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#ifThenElseStatementNoShortIf.
Java8Visitor.prototype.visitIfThenElseStatementNoShortIf = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#assertStatement.
Java8Visitor.prototype.visitAssertStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#switchStatement.
Java8Visitor.prototype.visitSwitchStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#switchBlock.
Java8Visitor.prototype.visitSwitchBlock = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#switchBlockStatementGroup.
Java8Visitor.prototype.visitSwitchBlockStatementGroup = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#switchLabels.
Java8Visitor.prototype.visitSwitchLabels = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#switchLabel.
Java8Visitor.prototype.visitSwitchLabel = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#enumConstantName.
Java8Visitor.prototype.visitEnumConstantName = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#whileStatement.
Java8Visitor.prototype.visitWhileStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#whileStatementNoShortIf.
Java8Visitor.prototype.visitWhileStatementNoShortIf = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#doStatement.
Java8Visitor.prototype.visitDoStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#forStatement.
Java8Visitor.prototype.visitForStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#forStatementNoShortIf.
Java8Visitor.prototype.visitForStatementNoShortIf = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#basicForStatement.
Java8Visitor.prototype.visitBasicForStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#basicForStatementNoShortIf.
Java8Visitor.prototype.visitBasicForStatementNoShortIf = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#forInit.
Java8Visitor.prototype.visitForInit = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#forUpdate.
Java8Visitor.prototype.visitForUpdate = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#statementExpressionList.
Java8Visitor.prototype.visitStatementExpressionList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#enhancedForStatement.
Java8Visitor.prototype.visitEnhancedForStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#enhancedForStatementNoShortIf.
Java8Visitor.prototype.visitEnhancedForStatementNoShortIf = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#breakStatement.
Java8Visitor.prototype.visitBreakStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#continueStatement.
Java8Visitor.prototype.visitContinueStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#returnStatement.
Java8Visitor.prototype.visitReturnStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#throwStatement.
Java8Visitor.prototype.visitThrowStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#synchronizedStatement.
Java8Visitor.prototype.visitSynchronizedStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#tryStatement.
Java8Visitor.prototype.visitTryStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#catches.
Java8Visitor.prototype.visitCatches = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#catchClause.
Java8Visitor.prototype.visitCatchClause = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#catchFormalParameter.
Java8Visitor.prototype.visitCatchFormalParameter = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#catchType.
Java8Visitor.prototype.visitCatchType = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#finally_.
Java8Visitor.prototype.visitFinally_ = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#tryWithResourcesStatement.
Java8Visitor.prototype.visitTryWithResourcesStatement = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#resourceSpecification.
Java8Visitor.prototype.visitResourceSpecification = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#resourceList.
Java8Visitor.prototype.visitResourceList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#resource.
Java8Visitor.prototype.visitResource = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primary.
Java8Visitor.prototype.visitPrimary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primaryNoNewArray.
Java8Visitor.prototype.visitPrimaryNoNewArray = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primaryNoNewArray_lf_arrayAccess.
Java8Visitor.prototype.visitPrimaryNoNewArray_lf_arrayAccess = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primaryNoNewArray_lfno_arrayAccess.
Java8Visitor.prototype.visitPrimaryNoNewArray_lfno_arrayAccess = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primaryNoNewArray_lf_primary.
Java8Visitor.prototype.visitPrimaryNoNewArray_lf_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primaryNoNewArray_lf_primary_lf_arrayAccess_lf_primary.
Java8Visitor.prototype.visitPrimaryNoNewArray_lf_primary_lf_arrayAccess_lf_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primaryNoNewArray_lf_primary_lfno_arrayAccess_lf_primary.
Java8Visitor.prototype.visitPrimaryNoNewArray_lf_primary_lfno_arrayAccess_lf_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primaryNoNewArray_lfno_primary.
Java8Visitor.prototype.visitPrimaryNoNewArray_lfno_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primaryNoNewArray_lfno_primary_lf_arrayAccess_lfno_primary.
Java8Visitor.prototype.visitPrimaryNoNewArray_lfno_primary_lf_arrayAccess_lfno_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#primaryNoNewArray_lfno_primary_lfno_arrayAccess_lfno_primary.
Java8Visitor.prototype.visitPrimaryNoNewArray_lfno_primary_lfno_arrayAccess_lfno_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classInstanceCreationExpression.
Java8Visitor.prototype.visitClassInstanceCreationExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classInstanceCreationExpression_lf_primary.
Java8Visitor.prototype.visitClassInstanceCreationExpression_lf_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#classInstanceCreationExpression_lfno_primary.
Java8Visitor.prototype.visitClassInstanceCreationExpression_lfno_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#typeArgumentsOrDiamond.
Java8Visitor.prototype.visitTypeArgumentsOrDiamond = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#fieldAccess.
Java8Visitor.prototype.visitFieldAccess = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#fieldAccess_lf_primary.
Java8Visitor.prototype.visitFieldAccess_lf_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#fieldAccess_lfno_primary.
Java8Visitor.prototype.visitFieldAccess_lfno_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#arrayAccess.
Java8Visitor.prototype.visitArrayAccess = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#arrayAccess_lf_primary.
Java8Visitor.prototype.visitArrayAccess_lf_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#arrayAccess_lfno_primary.
Java8Visitor.prototype.visitArrayAccess_lfno_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodInvocation.
Java8Visitor.prototype.visitMethodInvocation = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodInvocation_lf_primary.
Java8Visitor.prototype.visitMethodInvocation_lf_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodInvocation_lfno_primary.
Java8Visitor.prototype.visitMethodInvocation_lfno_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#argumentList.
Java8Visitor.prototype.visitArgumentList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodReference.
Java8Visitor.prototype.visitMethodReference = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodReference_lf_primary.
Java8Visitor.prototype.visitMethodReference_lf_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#methodReference_lfno_primary.
Java8Visitor.prototype.visitMethodReference_lfno_primary = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#arrayCreationExpression.
Java8Visitor.prototype.visitArrayCreationExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#dimExprs.
Java8Visitor.prototype.visitDimExprs = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#dimExpr.
Java8Visitor.prototype.visitDimExpr = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#constantExpression.
Java8Visitor.prototype.visitConstantExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#expression.
Java8Visitor.prototype.visitExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#lambdaExpression.
Java8Visitor.prototype.visitLambdaExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#lambdaParameters.
Java8Visitor.prototype.visitLambdaParameters = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#inferredFormalParameterList.
Java8Visitor.prototype.visitInferredFormalParameterList = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#lambdaBody.
Java8Visitor.prototype.visitLambdaBody = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#assignmentExpression.
Java8Visitor.prototype.visitAssignmentExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#assignment.
Java8Visitor.prototype.visitAssignment = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#leftHandSide.
Java8Visitor.prototype.visitLeftHandSide = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#assignmentOperator.
Java8Visitor.prototype.visitAssignmentOperator = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#conditionalExpression.
Java8Visitor.prototype.visitConditionalExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#conditionalOrExpression.
Java8Visitor.prototype.visitConditionalOrExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#conditionalAndExpression.
Java8Visitor.prototype.visitConditionalAndExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#inclusiveOrExpression.
Java8Visitor.prototype.visitInclusiveOrExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#exclusiveOrExpression.
Java8Visitor.prototype.visitExclusiveOrExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#andExpression.
Java8Visitor.prototype.visitAndExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#equalityExpression.
Java8Visitor.prototype.visitEqualityExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#relationalExpression.
Java8Visitor.prototype.visitRelationalExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#shiftExpression.
Java8Visitor.prototype.visitShiftExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#additiveExpression.
Java8Visitor.prototype.visitAdditiveExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#multiplicativeExpression.
Java8Visitor.prototype.visitMultiplicativeExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unaryExpression.
Java8Visitor.prototype.visitUnaryExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#preIncrementExpression.
Java8Visitor.prototype.visitPreIncrementExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#preDecrementExpression.
Java8Visitor.prototype.visitPreDecrementExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#unaryExpressionNotPlusMinus.
Java8Visitor.prototype.visitUnaryExpressionNotPlusMinus = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#postfixExpression.
Java8Visitor.prototype.visitPostfixExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#postIncrementExpression.
Java8Visitor.prototype.visitPostIncrementExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#postIncrementExpression_lf_postfixExpression.
Java8Visitor.prototype.visitPostIncrementExpression_lf_postfixExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#postDecrementExpression.
Java8Visitor.prototype.visitPostDecrementExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#postDecrementExpression_lf_postfixExpression.
Java8Visitor.prototype.visitPostDecrementExpression_lf_postfixExpression = function(ctx) {
};


// Visit a parse tree produced by Java8Parser#castExpression.
Java8Visitor.prototype.visitCastExpression = function(ctx) {
};



exports.Java8Visitor = Java8Visitor;