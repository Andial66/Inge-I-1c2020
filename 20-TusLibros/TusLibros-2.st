!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'SC 7/14/2020 20:07:10'!
test01NewCartsAreCreatedEmpty

	self assert: StoreTestObjectsFactory createCart isEmpty.
	self assert: StoreTestObjectsFactory createCart total = 0! !

!CartTest methodsFor: 'tests' stamp: 'SC 7/14/2020 20:07:23'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := StoreTestObjectsFactory createCart.
	
	self 
		should: [ cart add: StoreTestObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SC 7/14/2020 20:07:31'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := StoreTestObjectsFactory createCart.
	
	cart add: StoreTestObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'SC 7/14/2020 20:07:39'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := StoreTestObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: StoreTestObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SC 7/14/2020 20:07:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := StoreTestObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: StoreTestObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:27:00'!
test06CartRemembersAddedItems

	| cart |
	
	cart := StoreTestObjectsFactory createCart.
	cart add: StoreTestObjectsFactory itemSellByTheStore.
	
	self assert: (cart includes: StoreTestObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'SC 7/14/2020 20:08:01'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := StoreTestObjectsFactory createCart.
	
	self deny: (cart includes: StoreTestObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:27:17'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := StoreTestObjectsFactory createCart.
	cart add: 2 of: StoreTestObjectsFactory itemSellByTheStore.
	
	self assert: (cart occurrencesOf: StoreTestObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'SC 7/14/2020 20:08:18'!
test09TotalOfACartWithOneItemIsPriceOfTheItem

	| cart |
	
	cart := StoreTestObjectsFactory createCart.
	
	cart add: StoreTestObjectsFactory itemSellByTheStore.
	self assert: (cart total = (cart priceList at: StoreTestObjectsFactory itemSellByTheStore)). ! !

!CartTest methodsFor: 'tests' stamp: 'SC 7/14/2020 20:08:28'!
test10TotalOfACartEqualsTheSumOfAllItsItemsPrices

	| cart |
	
	cart := StoreTestObjectsFactory createCart.
	
	cart add: StoreTestObjectsFactory itemSellByTheStore.
	cart add: StoreTestObjectsFactory itemSellByTheStore.
	
	self assert: (cart total = ((cart priceList at: StoreTestObjectsFactory itemSellByTheStore) * 2)). ! !


!classDefinition: #CashierCartTest category: #TusLibros!
TestCase subclass: #CashierCartTest
	instanceVariableNames: 'positiveMerchantProcessor expiratedCard aValidCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierCartTest methodsFor: 'support' stamp: 'SC 7/14/2020 20:24:34'!
setUp

	| aValidDateForCreditCard |
	
	aValidDateForCreditCard := '01' , (Date today yearNumber + 1) asString .

	positiveMerchantProcessor := MerchantProcessorSimmulator with: [ :anAmmoun :aCC | 'OK'] .
	
	expiratedCard := CreditCard new initializeWithANumber: '1234567812345678' 
	                                                     name: 'John' 
	                                                     expiration: '012020' 
	                                                     andCode: '312'.
	
	aValidCard := CreditCard new initializeWithANumber: '1234567812345678' 
	                                              name: 'John'  
	                                              expiration:  aValidDateForCreditCard 
	                                              andCode: '312'.! !

!CashierCartTest methodsFor: 'support' stamp: 'SC 7/16/2020 12:15:44'!
totalOf: aSalesList

	^aSalesList sum: [ :aSale | aSale total] ifEmpty: [0] .! !


!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:15:54'!
test01CantCheckOutWithEmptyCart

	| aCashier aCart salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCart .
	
	
	self 
		should: [ aCashier checkOutOf: aCart  with: aValidCard debitingWith: positiveMerchantProcessor ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier cartIsEmptyError. 
			self assert: salesList isEmpty ]
! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:23:35'!
test02CantCheckOutWithExpiratedCard

	| aCashier aCart salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCartWithItem .
	
	self 
		should: [ aCashier checkOutOf: aCart  with: expiratedCard debitingWith: positiveMerchantProcessor ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCashier creditCardExpirationError . 
			self assert: salesList isEmpty ]! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:23:48'!
test03CashierRegistersSaleAfterValidCheckOut

	| aCashier aCart salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCartWithItem .
	
	aCashier checkOutOf: aCart with: aValidCard debitingWith: positiveMerchantProcessor .
	
	self deny: salesList isEmpty.! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:23:58'!
test04CartsAreEmptyAfterCheckOut

	| aCashier aCart salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCartWithItem .
	
	aCashier checkOutOf: aCart with: aValidCard debitingWith: positiveMerchantProcessor . 
	
	self assert: aCart isEmpty .! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:24:04'!
test05TotalOfASaleIsRegisteredAfterACheckOut

	| aCashier aCart cartTotal salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCartWithItem .
	
	cartTotal := aCart total .
	
	aCashier checkOutOf: aCart with: aValidCard debitingWith: positiveMerchantProcessor . 
	
	self assert: (self totalOf: salesList) = cartTotal .! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:24:17'!
test06TwoSalesAreRegisteredAfterTwoCheckOuts

	| aCashier aCart anotherCart salesTotal salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	
	aCart := StoreTestObjectsFactory createCartWithItem .
	anotherCart := StoreTestObjectsFactory createCartWithItem .
	
	salesTotal := aCart total + anotherCart total.
	
	aCashier checkOutOf: aCart with: aValidCard debitingWith: positiveMerchantProcessor . 
	aCashier checkOutOf: anotherCart with: aValidCard debitingWith: positiveMerchantProcessor .
	
	self assert: (self totalOf: salesList) = salesTotal .! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:24:46'!
test07CantDebitFromAStolenCard

	| aCart aCashier merchantProcessor aDebitBehaviour salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCartWithItem .
	
	aDebitBehaviour := [ :anAmmount :aCC | self error: 'Stolen Card'] .
	merchantProcessor := MerchantProcessorSimmulator with: aDebitBehaviour .
	
	self should: [ aCashier checkOutOf: aCart 
							 with: aValidCard
						       debitingWith: merchantProcessor ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo:  [ :anError |
			self assert: anError messageText = 'Stolen Card' .
			self deny: aCart isEmpty . 
			self assert: (self totalOf: salesList) = 0] .
			! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:24:53'!
test08CantDebitFromACardWithNotEnoughFunds

	| aCart aCashier merchantProcessor aDebitBehaviour salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCartWithItem .
	
	aDebitBehaviour := [ :anAmmount :aCC | self error: 'Not enough funds'] .
	merchantProcessor := MerchantProcessorSimmulator with: aDebitBehaviour .
	
	self should: [ aCashier checkOutOf: aCart 
							 with: aValidCard
						       debitingWith: merchantProcessor ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo:  [ :anError |
			self assert: anError messageText = 'Not enough funds' .
			self deny: aCart isEmpty . 
			self assert: (self totalOf: salesList) = 0] .
			! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:25:07'!
test09CanDebitWhenCardIsValid

	| aCart aCashier merchantProcessor aDebitBehaviour aCartTotal salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCartWithItem .
	
	aCartTotal := aCart total .
	
	aDebitBehaviour := [ :anAmmount :aCC | 'Ok'] .
	merchantProcessor := MerchantProcessorSimmulator with: aDebitBehaviour .
	
	aCashier checkOutOf: aCart 
		        with: aValidCard
			   debitingWith: merchantProcessor  .
		
	self assert: aCart isEmpty . 
	self assert: (self totalOf: salesList) = aCartTotal .! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:25:32'!
test10CashierDoesntComunicateWithMerchantProccessorIfCardIsExpired

	| aCart aCashier merchantProcessor aDebitBehaviour salesList |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCartWithItem .
	
	aDebitBehaviour := [ :anAmmount :aCC | self error: 'Merchant Processor was accessed'] .
	merchantProcessor := MerchantProcessorSimmulator with: aDebitBehaviour .
	
	self should: [ aCashier checkOutOf: aCart 
		        		      with: expiratedCard 
			   		      debitingWith: merchantProcessor  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CashierCart new creditCardExpirationError .
			self deny: aCart isEmpty .
			self assert: (self totalOf: salesList) = 0 .]
! !

!CashierCartTest methodsFor: 'tests' stamp: 'SC 7/16/2020 12:26:12'!
test11MultipleCashiersCanWriteSalesSimoutaneouslyInTheSalesList

	| aCart aCashier salesList anotherCashier anotherCart salesTotal |
	
	salesList := OrderedCollection new.
	aCashier := CashierCart with: salesList.
	anotherCashier := CashierCart with: salesList.
	aCart := StoreTestObjectsFactory createCartWithItem .
	anotherCart := StoreTestObjectsFactory createCartWithItem . 
	
	salesTotal := aCart total  + anotherCart total .
	
	aCashier checkOutOf: aCart 
		        with: aValidCard
			   debitingWith: positiveMerchantProcessor .
			
	anotherCashier checkOutOf: anotherCart 
		                  with: aValidCard
			             debitingWith: positiveMerchantProcessor .
	
	self assert: salesTotal = (self totalOf: salesList).
			
		
! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'SC 7/11/2020 16:56:27'!
test01CantCreateCardWithInvalidNumber

	| aCreditCard |
	
	aCreditCard  := CreditCard new.

	self 
		should: [aCreditCard initializeWithANumber: '000000000000000' name: 'John' expiration: '042022' andCode: '312' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCreditCard invalidCardNumberError. ]

	
	

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'FE 7/11/2020 20:47:28'!
test02CantCreateCardWithInvalidName

	| aCreditCard |
	
	aCreditCard  := CreditCard new.

	self 
		should: [aCreditCard initializeWithANumber: '1111222233334444' name: '' expiration: '042022' andCode: '312' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCreditCard invalidCardNameError. ]

	
	

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'SC 7/11/2020 16:56:56'!
test03CantCreateCardWithExpiredDate

	| aCreditCard |
	
	aCreditCard  := CreditCard new.

	self 
		should: [aCreditCard initializeWithANumber: '1111222233334444' name: 'John' expiration: '002020' andCode: '312' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = aCreditCard invalidExpirationDateError. ]

	
	

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'SC 7/11/2020 16:57:11'!
test04CantCreateCardWithInvalidSecurityNumber

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

!CashierCart methodsFor: 'errors' stamp: 'FE 7/9/2020 19:58:44'!
cartIsEmptyError

	^ 'Cant checkout of empty cart.'! !

!CashierCart methodsFor: 'errors' stamp: 'FE 7/9/2020 19:58:55'!
creditCardExpirationError

	^ 'Cant checkout with expirated Credit Card.'! !


!CashierCart methodsFor: 'validation' stamp: 'SC 7/11/2020 16:50:44'!
assertIsValidCart: aCart

	aCart isEmpty ifTrue: [ self error: self cartIsEmptyError ]! !

!CashierCart methodsFor: 'validation' stamp: 'SC 7/14/2020 20:00:24'!
assertIsValidCreditCard: aCreditCard

	(aCreditCard isExpiratedBy: Date today) ifTrue: [ self error: self creditCardExpirationError ].! !


!CashierCart methodsFor: 'operations' stamp: 'SC 7/16/2020 12:28:48'!
checkOutOf: aCart with: aCreditCard debitingWith: aMerchantProcessor

	| aSale |
	
	self assertIsValidCart: aCart.
	self assertIsValidCreditCard: aCreditCard. 
	
	aMerchantProcessor debit: aCart total from: aCreditCard .
	
	aSale := Sale of: aCart.
	
	sales add: aSale.
	aCart clear.
	! !


!CashierCart methodsFor: 'initialize' stamp: 'SC 7/16/2020 12:04:04'!
with: aSalesList

	sales := aSalesList .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierCart class' category: #TusLibros!
CashierCart class
	instanceVariableNames: ''!

!CashierCart class methodsFor: 'initialize' stamp: 'SC 7/16/2020 12:07:11'!
with: aSalesList

	^self new with: aSalesList .! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration code name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'access' stamp: 'SC 7/14/2020 19:59:12'!
isExpiratedBy: aDate
	
	| expirationMonth expirationYear |
	
	expirationMonth := (expiration copyFrom: 1 to: 2) asInteger .
	expirationYear := (expiration copyFrom: 3 to: 6) asInteger .
		
	^ (Date year: expirationYear month: expirationMonth day: 01) < aDate.! !

!CreditCard methodsFor: 'access' stamp: 'SC 7/13/2020 20:52:56'!
number

	^number .! !


!CreditCard methodsFor: 'validation' stamp: 'FE 7/11/2020 16:07:47'!
assertIsValidExpirationDate: aExpirationDate

	| expirationMonth |
	
	(aExpirationDate size = 6 & (aExpirationDate allSatisfy: [:char | (char >= $0) & (char <= $9)]) )
		ifFalse: [ ^ self error: self invalidExpirationDateError ].
	
	expirationMonth := (aExpirationDate copyFrom: 1 to: 2) asInteger.
			
	((expirationMonth >= 1) & (expirationMonth <= 12))
		ifFalse: [ ^ self error: self invalidExpirationDateError ].! !

!CreditCard methodsFor: 'validation' stamp: 'FE 7/11/2020 20:47:11'!
assertIsValidName: aName
	
	(aName isEmpty)
		ifTrue: [ ^ self error: self invalidCardNameError ].! !

!CreditCard methodsFor: 'validation' stamp: 'FE 7/9/2020 20:05:18'!
assertIsValidNumber: aNumber
	
	(aNumber size = 16 & (aNumber allSatisfy: [:char | (char >= $0) & (char <= $9)]) )
		ifFalse: [ ^ self error: self invalidCardNumberError ].! !

!CreditCard methodsFor: 'validation' stamp: 'FE 7/9/2020 20:05:48'!
assertIsValidSecurityCode: aCode
	
	(aCode size = 3 & (aCode allSatisfy: [:char | (char >= $0) & (char <= $9)]) )
		ifFalse: [ ^ self error: self invalidSecurityCodeError ].! !


!CreditCard methodsFor: 'errors' stamp: 'FE 7/9/2020 20:04:44'!
invalidCardNameError

	^ 'Invalid card name.'! !

!CreditCard methodsFor: 'errors' stamp: 'FE 7/9/2020 20:05:18'!
invalidCardNumberError

	^ 'Invalid card number.'! !

!CreditCard methodsFor: 'errors' stamp: 'FE 7/9/2020 20:05:36'!
invalidExpirationDateError

	^ 'Invalid Expiration Date.'! !

!CreditCard methodsFor: 'errors' stamp: 'FE 7/9/2020 20:05:48'!
invalidSecurityCodeError

	^ 'Invalid Security Code.'! !


!CreditCard methodsFor: 'initialize' stamp: 'FE 7/9/2020 19:40:06'!
initializeWithANumber: aNumber name: aName expiration: aDate andCode: aCode

	self assertIsValidNumber: aNumber.
	self assertIsValidName: aName.
	self assertIsValidExpirationDate: aDate.
	self assertIsValidSecurityCode: aCode.

	number := aNumber.
	name := aName.
	expiration := aDate.
	code := aCode.! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'SC 7/14/2020 19:23:36'!
debit: anAmmount from: aCreditCard! !


!classDefinition: #MerchantProcessorSimmulator category: #TusLibros!
MerchantProcessor subclass: #MerchantProcessorSimmulator
	instanceVariableNames: 'debitBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimmulator methodsFor: 'debit' stamp: 'SC 7/14/2020 19:58:04'!
debit: anAmmount from: aCreditCard

	^debitBehaviour value: anAmmount value: aCreditCard! !


!MerchantProcessorSimmulator methodsFor: 'initialize' stamp: 'SC 7/14/2020 19:33:02'!
with: aDebitBehaviour

	debitBehaviour := aDebitBehaviour  .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimmulator class' category: #TusLibros!
MerchantProcessorSimmulator class
	instanceVariableNames: ''!

!MerchantProcessorSimmulator class methodsFor: 'as yet unclassified' stamp: 'SC 7/14/2020 19:32:42'!
with: aDebitBehaviour

	^self new with: aDebitBehaviour! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'date priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialize' stamp: 'SC 7/11/2020 16:40:05'!
initializeWith: aCart

	items := aCart items copy.
	priceList := aCart priceList copy.
	date := Date today.! !


!Sale methodsFor: 'operations' stamp: 'SC 7/11/2020 16:35:18'!
total

	^ items sum: [ :item | priceList at: item] .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'as yet unclassified' stamp: 'SC 7/16/2020 12:29:09'!
of: aCart

	^Sale new initializeWith: aCart .! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'date priceList items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreTestObjectsFactory class' category: #TusLibros!
StoreTestObjectsFactory class
	instanceVariableNames: ''!

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/14/2020 20:06:24'!
createCart
	
	^Cart acceptingItemsOf: self defaultPriceList! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/16/2020 12:23:04'!
createCartWithItem
	
	| aCart |
	
	aCart := Cart acceptingItemsOf: self defaultPriceList .
	^aCart add: self itemSellByTheStore.! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/14/2020 20:05:02'!
defaultPriceList
	
	| priceList |
	
	priceList := Dictionary new.
	
	priceList add: 'validBook' -> 200 .
	
	^ priceList
	! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/14/2020 20:06:06'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/14/2020 20:04:45'!
itemSellByTheStore
	
	^ 'validBook'! !
