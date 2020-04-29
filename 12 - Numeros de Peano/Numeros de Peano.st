!classDefinition: #I category: #'Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros de Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'operations' stamp: 'SC 4/27/2020 22:00:16'!
* aNumber

	^aNumber! !

!I class methodsFor: 'operations' stamp: 'SC 4/29/2020 11:31:11'!
+ aNumber

	^aNumber next! !

!I class methodsFor: 'operations' stamp: 'SC 4/29/2020 16:24:27'!
- aNumber 

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'operations' stamp: 'SC 4/29/2020 16:31:33'!
/ aNumber

	self < aNumber 
		ifTrue: [ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ] 
		ifFalse: [ self = aNumber 
					ifTrue: [ ^I ] 
					ifFalse: [ ^ ((self - aNumber) / aNumber) next ] ]
		! !

!I class methodsFor: 'operations' stamp: 'SC 4/29/2020 16:18:39'!
< aNumber

	^aNumber parents includes: self! !

!I class methodsFor: 'operations' stamp: 'SC 4/29/2020 11:20:31'!
restarDe: aNumber

	^aNumber previous! !


!I class methodsFor: 'basic' stamp: 'SC 4/29/2020 11:29:30'!
next
	
	^self createChildNamed: self name, 'I'. ! !


!I class methodsFor: 'error' stamp: 'SC 4/29/2020 16:33:16'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'La division debe ser entera'! !

!I class methodsFor: 'error' stamp: 'SC 4/29/2020 16:23:51'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'En el dominio de los naturales, no se puede restar un numero a otro que sea mayor o igual a él'! !


!classDefinition: #II category: #'Numeros de Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros de Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'operations' stamp: 'SC 4/29/2020 16:11:46'!
* aNumber

	^self previous * aNumber + aNumber! !

!II class methodsFor: 'operations' stamp: 'SC 4/29/2020 11:29:20'!
+ aNumber

	^self previous + aNumber next! !

!II class methodsFor: 'operations' stamp: 'SC 4/29/2020 11:19:03'!
- aNumber 

	^aNumber restarDe: self! !

!II class methodsFor: 'operations' stamp: 'SC 4/29/2020 11:20:07'!
restarDe: aNumber 

	^self previous restarDe: aNumber previous! !


!II class methodsFor: 'basic' stamp: 'SC 4/27/2020 21:43:05'!
previous

	^self parent ! !


!classDefinition: #III category: #'Numeros de Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #IIII category: #'Numeros de Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #IIIII category: #'Numeros de Peano'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #IIIIII category: #'Numeros de Peano'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #IIIIIII category: #'Numeros de Peano'!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #IIIIIIII category: #'Numeros de Peano'!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #IIIIIIIII category: #'Numeros de Peano'!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #TestsDeVerificacion category: #'Numeros de Peano'!
DenotativeObject subclass: #TestsDeVerificacion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestsDeVerificacion class' category: #'Numeros de Peano'!
TestsDeVerificacion class
	instanceVariableNames: ''!

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 12:51:26'!
test01UnoMasUnSumandoEsElProximoDelSumando

	Assert that: I + II isEqualTo: II next.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:11:40'!
test02NumerosMayoresaUnoSumanBien

	Assert that: II + II isEqualTo: IIII.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:12:19'!
test03UnNumeroMenosUnoEsElPrevioDelNumero

	Assert that: II - I isEqualTo: II previous.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:15:11'!
test04NumerosMayoresaUnoRestanBien

	Assert that: IIII - II isEqualTo: II.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 12:51:02'!
test05RestaNoSoportaNumerosNegativos

	Assert should: [ I - II ] signal: Error withDescription: I descripcionDeErrorDeNumerosNegativosNoSoportados.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:15:53'!
test06UnNumeroMultiplicadoPorUnoEsIgualAlNumero

	Assert that: II * I isEqualTo: II.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:16:23'!
test07NumerosMayoresaUnoMultiplicanBien

	Assert that: II * II isEqualTo: IIII.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:16:46'!
test08UnoMultiplicadoUnoEsIgualAUno

	Assert that: I * I isEqualTo: I.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:01:58'!
test09NumerosMayoresaUnoDividenBien

	Assert that: IIII / II isEqualTo: II.
! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:28'!
test10UnNumeroDivididoUnoEsIgualAlNumero

	Assert that: II / I isEqualTo: II.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:38'!
test11UnoDivididoUnoEsIgualAUno

	Assert that: I / I isEqualTo: I.! !

!TestsDeVerificacion class methodsFor: 'as yet unclassified' stamp: 'ARM 3/26/2018 13:17:59'!
test12DivisionNoSoportaDividirPorUnNumeroMayor

	Assert should: [ III /  IIII ] signal: Error withDescription: II descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	
	Assert should: [ I /  II] signal: Error withDescription: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
! !


!classDefinition: #TestsPeano category: #'Numeros de Peano'!
DenotativeObject subclass: #TestsPeano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestsPeano class' category: #'Numeros de Peano'!
TestsPeano class
	instanceVariableNames: ''!

!TestsPeano class methodsFor: 'tests' stamp: 'SC 4/29/2020 11:32:11'!
test01NextFunciona

	Assert that: (I next) isEqualTo: II.
	Assert that: (I next next) isEqualTo: III.! !

!TestsPeano class methodsFor: 'tests' stamp: 'SC 4/29/2020 11:31:56'!
test02SumaFunciona
	
	Assert that: (I + III) isEqualTo: III next.
	Assert that: (I + IIIII) isEqualTo: IIIII next.
	Assert that: (III + II) isEqualTo: IIIII.! !

!TestsPeano class methodsFor: 'tests' stamp: 'SC 4/27/2020 21:52:13'!
test03RestaFunciona

	Assert that: (III - I) isEqualTo: II.
	Assert that: (IIII - I) isEqualTo: III.
	Assert that: (IIIII - III) isEqualTo: II.! !

!TestsPeano class methodsFor: 'tests' stamp: 'SC 4/29/2020 11:35:58'!
test04ProductoFunciona

	Assert that: (II * III) isEqualTo: IIIIII.
	Assert that: (I * IIIII) isEqualTo: IIIII.
	Assert that: (I * I) isEqualTo: I.! !

!TestsPeano class methodsFor: 'tests' stamp: 'SC 4/29/2020 16:39:35'!
test05MenorFunciona

	Assert that: (III < IIII) isEqualTo: true.
	Assert that: (II < I) isEqualTo: false.
	Assert that: (III < III) isEqualTo: false.! !

!TestsPeano class methodsFor: 'tests' stamp: 'SC 4/29/2020 16:40:38'!
test06DivisionFunciona

	Assert that: (IIII / II) isEqualTo: II.
	Assert that: (IIIII / I) isEqualTo: IIIII.
	Assert that: (IIIIII / II) isEqualTo: III.! !
