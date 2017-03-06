<?php

/**
 *
 * This section must be harcodedly writed
 * Make this section in synergy with the convention checker function
 * source: https://google.github.io/styleguide/cppguide.html
 * unhandled:
 *	1. globalvariable
 *	1. macro
 *	1. static variable
 *	2. pointer
 *	3. reference
 *	4. parameter
 */
return [
	'all' => [
		0 => 'classandstruct',
		1 => 'typedef',
		2 => 'alias',
		3 => 'enum',
		4 => 'commonvariable',
		5 => 'classdatamember',
		6 => 'structdatamember',
		7 => 'constant',
		8 => 'function',
		9 => 'enumerator',
		10 => 'namespace',
	],
	'classandstruct' => 'classandstruct',
	'typedef' => 'typedef',
	'alias' => 'alias',
	'enum' => 'enum',
	'commonvariable' => 'commonvariable',
	'classdatamember' => 'classdatamember',
	'structdatamember' => 'structdatamember',
	'constant' => 'constant',
	'function' => 'function',
	'enumerator' => 'enumerator',
	'namespace' => 'namespace',
];