!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'FE 7/11/2020 15:56:48'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty.
	self assert: self createCart total = 0! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'FE 7/9/2020 21:00:04'!
test09LuegoDeAgregarUnElementoAUnCarritoVacioElTotalEsIgualAlValorDelElementoAgregado

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart total = (cart priceList at: self itemSellByTheStore)). ! !

!CartTest methodsFor: 'tests' stamp: 'FE 7/9/2020 21:01:12'!
test10LuegoDeAgregarUnElementoAUnCarritoConElementosElTotalSigueSiendoCorrecto

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	cart add: self itemSellByTheStore.
	
	self assert: (cart total = ((cart priceList at: self itemSellByTheStore) * 2)). ! !


!CartTest methodsFor: 'support' stamp: 'FE 7/9/2020 17:42:35'!
createCart
	
	^Cart acceptingItemsOf: self defaultPriceList! !

!CartTest methodsFor: 'support' stamp: 'FE 7/9/2020 17:41:32'!
defaultPriceList
	
	| priceList |
	
	priceList := Dictionary new.
	
	priceList add: 'validBook' -> 200 .
	
	^ priceList! !

!CartTest methodsFor: 'support' stamp: 'FE 7/9/2020 17:41:39'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierCartTest category: #TusLibros!
TestCase subclass: #CashierCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierCartTest methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 19:48:41'!
defaultPriceList
	
	| priceList |
	
	priceList := Dictionary new.
	
	priceList add: 'validBook' -> 200 .
	
	^ priceList
	! !

!CashierCartTest methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:24:18'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierCartTest methodsFor: 'as yet unclassified' stamp: 'FE 7/11/2020 15:45:17'!
test01NoPuedoRealizarUnCheckOutDeUnCarritoVacio

	| aCashier aCart aCreditCard |
	
	aCashier := CashierCart new.
	aCart := Cart acceptingItemsOf: self defaultPriceList .
	aCreditCard := CreditCard new.
	
	self 
		should: [ aCashier checkOutOf: aCart  with: aCreditCard]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier cartIsEmptyError. 
			self assert: aCashier sales isEmpty ]
! !

!CashierCartTest methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:23:52'!
test02NoPuedoRealizarUnCheckOutConUnaTarjetaVencida

	| aCashier aCart aCreditCard |
	
	aCashier := CashierCart new.
	aCart := Cart acceptingItemsOf: self defaultPriceList .
	aCart add: self itemSellByTheStore.
	
	aCreditCard := CreditCard new.
	aCreditCard initializeWithANumber: '1234567812345678' name: 'John' expiration: '052020' andCode: '312'.
	
	self 
		should: [ aCashier checkOutOf: aCart  with: aCreditCard]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier creditCardExpirationError . 
			self assert: aCashier sales isEmpty ]! !

!CashierCartTest methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:26:56'!
test03AlHacerCheckOutLaVentaEsAgregadaALaListaDeVentas

	| aCashier aCart aCreditCard |
	
	aCashier := CashierCart new.
	aCart := Cart acceptingItemsOf: self defaultPriceList .
	aCart add: self itemSellByTheStore.
	
	aCreditCard := CreditCard new.
	aCreditCard initializeWithANumber: '1234567812345678' name: 'John' expiration: '102020' andCode: '312'.
	
	aCashier checkOutOf: aCart with: aCreditCard. 
	
	self deny: aCashier sales isEmpty.! !

!CashierCartTest methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 21:21:41'!
test04AlHacerElCheckOutElCarritoEsVaciado

	| aCashier aCart aCreditCard |
	
	aCashier := CashierCart new.
	aCart := Cart acceptingItemsOf: self defaultPriceList .
	aCart add: self itemSellByTheStore.
	
	aCreditCard := CreditCard new.
	aCreditCard initializeWithANumber: '1234567812345678' name: 'John' expiration: '102020' andCode: '312'.
	
	aCashier checkOutOf: aCart with: aCreditCard. 
	
	self assert: aCart isEmpty .! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'FE 7/9/2020 20:06:01'!
test01NoPuedoCrearUnaTarjetaConUnNumeroInvalido

	| aCreditCard |
	
	aCreditCard  := CreditCard new.

	self 
		should: [aCreditCard initializeWithANumber: '000000000000000' name: 'John' expiration: '042022' andCode: '312' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCreditCard invalidCardNumberError. ]

	
	

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'FE 7/9/2020 20:05:05'!
test02NoPuedoCrearUnaTarjetaConUnNombreInvalido

	| aCreditCard |
	
	aCreditCard  := CreditCard new.

	self 
		should: [aCreditCard initializeWithANumber: '1111222233334444' name: 'John 45' expiration: '042022' andCode: '312' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCreditCard invalidCardNameError. ]

	
	

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'FE 7/9/2020 20:19:44'!
test03NoPuedoCrearUnaTarjetaConUnaFechaDeExpiracionInvalida

	| aCreditCard |
	
	aCreditCard  := CreditCard new.

	self 
		should: [aCreditCard initializeWithANumber: '1111222233334444' name: 'John' expiration: '002020' andCode: '312' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCreditCard invalidExpirationDateError. ]

	
	

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'FE 7/9/2020 20:06:12'!
test04NoPuedoCrearUnaTarjetaConUnCodigoDeSeguridadInvalido

	| aCreditCard |
	
	aCreditCard  := CreditCard new.

	self 
		should: [aCreditCard initializeWithANumber: '1111222233334444' name: 'John' expiration: '102020' andCode: '31a' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCreditCard invalidSecurityCodeError. ]

	
	

	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'FE 7/9/2020 17:34:24'!
invalidItemErrorMessage
	
	^'Item is not in list'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'FE 7/9/2020 17:43:40'!
assertIsValidItem: anItem

	(priceList includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'FE 7/9/2020 17:34:05'!
initializeAcceptingItemsOf: aPriceList

	priceList := aPriceList.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'FE 7/9/2020 21:16:57'!
items

	^ items . ! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'FE 7/9/2020 20:44:55'!
priceList

	^ priceList . ! !

!Cart methodsFor: 'queries' stamp: 'FE 7/11/2020 15:54:20'!
total

	^ items sum: [:item | self priceList at: item] ifEmpty: [0].	! !


!Cart methodsFor: 'operations' stamp: 'FE 7/9/2020 21:22:30'!
clear
	
	items removeAll. ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'FE 7/9/2020 17:35:55'!
acceptingItemsOf: aPriceList

	^self new initializeAcceptingItemsOf: aPriceList ! !


!classDefinition: #CashierCart category: #TusLibros!
Object subclass: #CashierCart
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierCart methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 19:58:08'!
assertIsValidCart: aCart

	(aCart isEmpty ) ifTrue: [ self error: self cartIsEmptyError ]! !

!CashierCart methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 19:58:19'!
assertIsValidCreditCard: aCreditCard

	aCreditCard isExpirated ifTrue: [ self error: self creditCardExpirationError ].! !

!CashierCart methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 19:58:44'!
cartIsEmptyError

	^ 'Cant checkout of empty cart.'! !

!CashierCart methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 21:23:32'!
checkOutOf: aCart with: aCreditCard

	| aSale |
	
	self assertIsValidCart: aCart.
	self assertIsValidCreditCard: aCreditCard. 
	
	aSale := Sale new initializeWith: aCart.
	
	sales add: aSale.
	aCart clear.
	! !

!CashierCart methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 19:58:55'!
creditCardExpirationError

	^ 'Cant checkout with expirated Credit Card.'! !

!CashierCart methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:09:16'!
initialize

	super initialize.
	sales := OrderedCollection new.! !

!CashierCart methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:10:46'!
sales
	
	^ sales.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration code name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/11/2020 16:07:47'!
assertIsValidExpirationDate: aExpirationDate

	| expirationMonth |
	
	(aExpirationDate size = 6 & (aExpirationDate allSatisfy: [:char | (char >= $0) & (char <= $9)]) )
		ifFalse: [ ^ self error: self invalidExpirationDateError ].
	
	expirationMonth := (aExpirationDate copyFrom: 1 to: 2) asInteger.
			
	((expirationMonth >= 1) & (expirationMonth <= 12))
		ifFalse: [ ^ self error: self invalidExpirationDateError ].! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:04:44'!
assertIsValidName: aName
	
	(aName allSatisfy: [:char | (char >= $A) & (char <= $z)] )
		ifFalse: [ ^ self error: self invalidCardNameError ].! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:05:18'!
assertIsValidNumber: aNumber
	
	(aNumber size = 16 & (aNumber allSatisfy: [:char | (char >= $0) & (char <= $9)]) )
		ifFalse: [ ^ self error: self invalidCardNumberError ].! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:05:48'!
assertIsValidSecurityCode: aCode
	
	(aCode size = 3 & (aCode allSatisfy: [:char | (char >= $0) & (char <= $9)]) )
		ifFalse: [ ^ self error: self invalidSecurityCodeError ].! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 19:40:06'!
initializeWithANumber: aNumber name: aName expiration: aDate andCode: aCode

	self assertIsValidNumber: aNumber.
	self assertIsValidName: aName.
	self assertIsValidExpirationDate: aDate.
	self assertIsValidSecurityCode: aCode.

	number := aNumber.
	name := aName.
	expiration := aDate.
	code := aCode.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:04:44'!
invalidCardNameError

	^ 'Invalid card name.'! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:05:18'!
invalidCardNumberError

	^ 'Invalid card number.'! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:05:36'!
invalidExpirationDateError

	^ 'Invalid Expiration Date.'! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/9/2020 20:05:48'!
invalidSecurityCodeError

	^ 'Invalid Security Code.'! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'FE 7/11/2020 16:14:26'!
isExpirated
	
	| expirationMonth expirationYear |
	
	expirationMonth := (expiration copyFrom: 1 to: 2) asInteger .
	expirationYear := (expiration copyFrom: 3 to: 6) asInteger .
		
	^ (Date year: expirationYear month: expirationMonth day: 01) < Date today.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'date priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'as yet unclassified' stamp: 'FE 7/11/2020 16:16:43'!
initializeWith: aCart

	items := aCart items.
	priceList := aCart priceList.
	date := Date today.! !
