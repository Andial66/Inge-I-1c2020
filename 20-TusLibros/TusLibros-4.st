!classDefinition: #CartSession category: #TusLibros!
TestCase subclass: #CartSession
	instanceVariableNames: 'lastActivity clock username'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'operations' stamp: 'SC 7/21/2020 21:19:26'!
isValid

	^(clock now - lastActivity) minutes < 30 .  ! !

!CartSession methodsFor: 'operations' stamp: 'SC 7/21/2020 21:19:53'!
updateTime

	lastActivity _ clock now.! !

!CartSession methodsFor: 'operations' stamp: 'SC 7/21/2020 20:45:05'!
username

	^username  .! !


!CartSession methodsFor: 'initialize' stamp: 'SC 7/21/2020 21:18:57'!
with: aUsername and: aClock

	clock := aClock .
	username := aUsername .
	lastActivity := aClock now.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 20:38:30'!
from: aUsername

	^self new with: aUsername.! !

!CartSession class methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 21:17:52'!
from: aUsername with: aClock

	^self new with: aUsername and: aClock.! !


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

!CashierCartTest methodsFor: 'support' stamp: 'SC 7/21/2020 22:47:14'!
setUp

	| aValidDateForCreditCard |
	
	aValidDateForCreditCard := StoreTestObjectsFactory validCreditCardDate .

	positiveMerchantProcessor := MerchantProcessorSimmulator with: [ :anAmmoun :aCC | 'OK'] .
	
	expiratedCard := CreditCard new initializeWithANumber: '1234567812345678' 
	                                                     name: 'John' 
	                                                     expiration: StoreTestObjectsFactory expiredCreditCardDate 
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

!CreditCardTest methodsFor: 'tests' stamp: 'SC 7/21/2020 22:44:55'!
test03CantCreateCardWithExpiredDate

	| aCreditCard |
	
	aCreditCard  := CreditCard new.

	self 
		should: [aCreditCard initializeWithANumber: '1111222233334444' 
			                         name: 'John' 
			                         expiration: '002020' 
			                         andCode: '312' ]
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


!classDefinition: #InterfaceFacadeTest category: #TusLibros!
TestCase subclass: #InterfaceFacadeTest
	instanceVariableNames: 'aValidUser aValidPassword anotherValidUser anotherValidPassword clock positiveMerchantProcessor priceList salesList aBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceFacadeTest methodsFor: 'addToCart' stamp: 'SC 7/21/2020 22:00:43'!
test06CanAddElementsToAValidCartId

	| aCartId anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId. 
	
	self assert: (anInterfaceFacade listCart: aCartId) size = 1.
	self assert: (anInterfaceFacade listCart: aCartId) includes: StoreTestObjectsFactory itemSellByTheStore. 
	
	! !

!InterfaceFacadeTest methodsFor: 'addToCart' stamp: 'SC 7/21/2020 22:00:51'!
test07CantAddAnElementToAnInvalidCartId
		
	| anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
		
	self 
		should: [ anInterfaceFacade add: 1 of: (StoreTestObjectsFactory itemSellByTheStore) intoCartWith: '']
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid Cart Id' ]
	
	! !


!InterfaceFacadeTest methodsFor: 'listCart' stamp: 'SC 7/21/2020 22:00:31'!
test05CantListACartWithInvalidId
	
	| anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	self 
		should: [ anInterfaceFacade listCart: '' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid Cart Id' ]
	
	! !

!InterfaceFacadeTest methodsFor: 'listCart' stamp: 'SC 7/21/2020 22:03:59'!
test19ListingACartWithoutItemsReturnsAnEmptyList

	| aCartId anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	self assert: (anInterfaceFacade listCart: aCartId) isEmpty .

	
	
	! !

!InterfaceFacadeTest methodsFor: 'listCart' stamp: 'SC 7/21/2020 22:04:07'!
test20ListingACartWithItemsReturnsHisItems

	| aCartId anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId. 
	
	self assert: (anInterfaceFacade listCart: aCartId) size = 1 .
	self assert: ((anInterfaceFacade listCart: aCartId) includes: StoreTestObjectsFactory itemSellByTheStore). 

	
	
	! !

!InterfaceFacadeTest methodsFor: 'listCart' stamp: 'SC 7/21/2020 22:04:14'!
test21ListingACartWithMoreThanOneItemReturnsAllHisItems

	| aCartId anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 5 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId. 
	
	self assert: (anInterfaceFacade listCart: aCartId) size = 5 .

	
	
	! !


!InterfaceFacadeTest methodsFor: 'createCart' stamp: 'SC 7/21/2020 21:59:44'!
test01CantCreateCartWithInvalidUsername

	| anInvalidUser anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	anInvalidUser := StoreTestObjectsFactory invalidUser.
	
	self 
		should: [ anInterfaceFacade createCart: anInvalidUser with: aValidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid Credentials' ]

	! !

!InterfaceFacadeTest methodsFor: 'createCart' stamp: 'SC 7/21/2020 22:48:10'!
test02CantCreateCartWithInvalidPassword

	| anInvalidPassword anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	anInvalidPassword := StoreTestObjectsFactory invalidPassword. 

	self 
		should: [ anInterfaceFacade createCart: aValidUser with: anInvalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid Credentials' ]

	! !

!InterfaceFacadeTest methodsFor: 'createCart' stamp: 'SC 7/21/2020 22:48:17'!
test03CanCreateCartWithValidCredentials
	
	| aCartId anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	self assert: (anInterfaceFacade listCart: aCartId) isEmpty .
	
	! !

!InterfaceFacadeTest methodsFor: 'createCart' stamp: 'SC 7/21/2020 22:48:20'!
test04TwoDifferentCartsHaveTwoDifferentIds

	| aCartId anOtherCartId anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	anOtherCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	self assert: aCartId ~= anOtherCartId .
	
	
	! !


!InterfaceFacadeTest methodsFor: 'checkOut' stamp: 'SC 7/21/2020 22:01:09'!
test08CantCheckoutAnInvalidCartId
		
	| anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
		
	self 
		should: [ anInterfaceFacade checkOutOfCart: '' with: '0000000000000000' anExpiration: '092020'  anOwner: 'John'  anCode: '123' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid Cart Id' ]
	
	! !

!InterfaceFacadeTest methodsFor: 'checkOut' stamp: 'SC 7/21/2020 22:01:17'!
test09CanCheckOutAValidCartId
		
	| aCartId anInterfaceFacade transactionId |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId. 
	
	transactionId := anInterfaceFacade checkOutOfCart: aCartId 
	                                                     with: '1234567812345678' 
	                                                     anExpiration: '092020' 
	                                                     anOwner: 'John' 
	                                                     anCode: '123'. 
	
	self 
		should: [ anInterfaceFacade listCart: aCartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid Cart Id'.
			self deny: transactionId isNil ] .
	! !

!InterfaceFacadeTest methodsFor: 'checkOut' stamp: 'SC 7/21/2020 22:01:27'!
test10TwoDifferentCheckOutsCreateTwoDifferentTransactionsId
		
	| aCartId anotherCartId anInterfaceFacade transactionId anotherTransactionId |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	anotherCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId. 
	
	transactionId := anInterfaceFacade checkOutOfCart: aCartId 
	                                                     with: '1234567812345678' 
	                                                     anExpiration: '092020' 
	                                                     anOwner: 'John' 
	                                                     anCode: '123'. 
	
	anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: anotherCartId. 
	
	anotherTransactionId := anInterfaceFacade checkOutOfCart: anotherCartId 
	                                                     with: '1234567812345678' 
	                                                     anExpiration: '092020' 
	                                                     anOwner: 'John' 
	                                                     anCode: '123'.
	
	self deny: transactionId = anotherTransactionId .
	
	
	
	
	! !


!InterfaceFacadeTest methodsFor: 'setUp' stamp: 'SC 7/21/2020 22:31:00'!
setUp

	aValidUser := StoreTestObjectsFactory validUser.
	aValidPassword := StoreTestObjectsFactory validPassword. 
	
	anotherValidUser := StoreTestObjectsFactory anotherValidUser .
	anotherValidPassword := StoreTestObjectsFactory anotherValidPassword .
	
	clock := Clock with: DateAndTime now .
	priceList := StoreTestObjectsFactory defaultPriceList .
	positiveMerchantProcessor := MerchantProcessorSimmulator with: [ :anAmmoun :aCC | 'OK'] .
	salesList := OrderedCollection new .
	
	aBook := StoreTestObjectsFactory itemSellByTheStore .
	

	! !


!InterfaceFacadeTest methodsFor: 'rest' stamp: 'SC 7/21/2020 22:04:21'!
test22CreatingACartCreatesACartSession
	
	| aCartId anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	self assert: (anInterfaceFacade hasCartSession: aCartId) .
	
	
	! !

!InterfaceFacadeTest methodsFor: 'rest' stamp: 'SC 7/21/2020 22:04:32'!
test23ASessionIsValid5minutesAfterCreated

	| aCartId anInterfaceFacade aClock |
	
	aClock := Clock with: DateAndTime now.
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: aClock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	aClock advanceTime: 5 minutes.
	
	self assert: (anInterfaceFacade hasValidSession: aCartId) .


	
	! !

!InterfaceFacadeTest methodsFor: 'rest' stamp: 'SC 7/21/2020 22:04:40'!
test24ASessionIsNotValid30minutesAfterCreated

	| aCartId anInterfaceFacade aClock |
	
	aClock := Clock with: DateAndTime now.
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: aClock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	aClock advanceTime: 30 minutes.
	
	self deny: (anInterfaceFacade hasValidSession: aCartId) .


	
	! !

!InterfaceFacadeTest methodsFor: 'rest' stamp: 'SC 7/21/2020 22:04:46'!
test25ASessionIsValid5minutesAfterLastOperation

	| aCartId anInterfaceFacade aClock |
	
	aClock := Clock with: DateAndTime now.
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: aClock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	aClock advanceTime: 29 minutes.
	anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId. 
	self assert: (anInterfaceFacade hasValidSession: aCartId) .
	
	aClock advanceTime: 5 minutes .
	self assert: (anInterfaceFacade hasValidSession: aCartId) .


	
	! !

!InterfaceFacadeTest methodsFor: 'rest' stamp: 'SC 7/21/2020 22:05:00'!
test26ASessionIsNotValid30minutesAfterLastOperation

	| aCartId anInterfaceFacade aClock |
	
	aClock := Clock with: DateAndTime now.
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: aClock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	aClock advanceTime: 29 minutes.	
	anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId. 
	self assert: (anInterfaceFacade hasValidSession: aCartId) .
	
	aClock advanceTime: 30 minutes .
	self deny: (anInterfaceFacade hasValidSession: aCartId) .


	
	! !

!InterfaceFacadeTest methodsFor: 'rest' stamp: 'SC 7/21/2020 22:05:08'!
test27CantListCartWithAnInvalidSession

	| aCartId anInterfaceFacade aClock |
	
	aClock := Clock with: DateAndTime now.
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: aClock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	aClock advanceTime: 30 minutes.
	
	self should: [ anInterfaceFacade listCart: aCartId. ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError |
			anError messageText = anInterfaceFacade sessionExpiredError .
			]


	
	! !

!InterfaceFacadeTest methodsFor: 'rest' stamp: 'SC 7/21/2020 22:05:20'!
test28CantAddProductsWithAnInvalidSession

	| aCartId anInterfaceFacade aClock |
	
	aClock := Clock with: DateAndTime now.
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: aClock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	aClock advanceTime: 30 minutes.
	
	self should: [ anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId. ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError |
			anError messageText = anInterfaceFacade sessionExpiredError .
			self assert: (anInterfaceFacade itemsFrom: aCartId) isEmpty .
			]


	
	! !

!InterfaceFacadeTest methodsFor: 'rest' stamp: 'SC 7/21/2020 22:05:26'!
test29CantCheckOutWithAnInvalidSession

	| aCartId anInterfaceFacade aClock |
	
	aClock := Clock with: DateAndTime now.
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: aClock.
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId.
	aClock advanceTime: 30 minutes.
	
	self should: [ anInterfaceFacade checkOutOfCart: aCartId 
	                                                     with: '1234567812345678' 
	                                                     anExpiration: '092020' 
	                                                     anOwner: 'John' 
	                                                     anCode: '123' ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError |
			anError messageText = anInterfaceFacade sessionExpiredError .
			self assert: anInterfaceFacade sales isEmpty .
			]


	
	! !

!InterfaceFacadeTest methodsFor: 'rest' stamp: 'SC 7/21/2020 22:43:29'!
test30CantCheckOutWithExpiredCreditCard

	| aCartId anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 1 of: StoreTestObjectsFactory itemSellByTheStore intoCartWith: aCartId. 
	
	self 
		should: [ anInterfaceFacade checkOutOfCart: aCartId 
	                                                     with: '1234567812345678' 
	                                                     anExpiration: StoreTestObjectsFactory expiredCreditCardDate 
	                                                     anOwner: 'John' 
	                                                     anCode: '123'.  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Cant checkout with expirated Credit Card.'.
			self assert: anInterfaceFacade sales isEmpty .] .

	
	! !


!InterfaceFacadeTest methodsFor: 'listPurchases' stamp: 'SC 7/21/2020 22:26:45'!
test11CantListPurchasesOfUserWithInvalidName

	| anInvalidUser anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	anInvalidUser := StoreTestObjectsFactory invalidUser.
		
	self 
		should: [ anInterfaceFacade listPurchasesOf: anInvalidUser with: aValidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid Credentials' ]

	
	! !

!InterfaceFacadeTest methodsFor: 'listPurchases' stamp: 'SC 7/21/2020 22:26:48'!
test12CantListPurchasesOfUserWithInvalidPassword

	| anInvalidPassword anInterfaceFacade |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	anInvalidPassword := StoreTestObjectsFactory invalidPassword .
		
	self 
		should: [ anInterfaceFacade listPurchasesOf: aValidUser with: anInvalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid Credentials' ]

	
	! !

!InterfaceFacadeTest methodsFor: 'listPurchases' stamp: 'SC 7/21/2020 22:12:19'!
test13CantListPurchasesOfValidUserWithNoPurchases
		
	| aPurchasesList anInterfaceFacade |
		
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aPurchasesList := anInterfaceFacade listPurchasesOf: aValidUser with: aValidPassword .
	
	self assert: aPurchasesList isEmpty .
	

	
	! !

!InterfaceFacadeTest methodsFor: 'listPurchases' stamp: 'SC 7/21/2020 22:31:33'!
test14CanListPurchasesOfValidUserWithOnePurchase
		
	| aCartId anInterfaceFacade aPurchasesList |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 1 of: aBook intoCartWith: aCartId. 
	
	anInterfaceFacade checkOutOfCart: aCartId 
	                            with: '1234567812345678' 
	                            anExpiration: StoreTestObjectsFactory notExpiredDate 
	                            anOwner: 'John' 
	                            anCode: '123'. 
		
	aPurchasesList := anInterfaceFacade listPurchasesOf: aValidUser with: aValidPassword .
	
	self deny: aPurchasesList isEmpty.
	

	
	! !

!InterfaceFacadeTest methodsFor: 'listPurchases' stamp: 'SC 7/21/2020 22:33:41'!
test15TheOnlySaleOfAValidUserIsInHisPurchaseList
		
	| aCartId anInterfaceFacade aPurchasesList |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 1 of: aBook intoCartWith: aCartId. 
	
	anInterfaceFacade checkOutOfCart: aCartId 
	                            with: '1234567812345678' 
	                            anExpiration: StoreTestObjectsFactory notExpiredDate 
	                            anOwner: 'John' 
	                            anCode: '123'. 
		
	aPurchasesList := anInterfaceFacade listPurchasesOf: aValidUser with: aValidPassword .
	
	self assert: (aPurchasesList quantityOf: aBook) = 1.
	self assert: aPurchasesList total = (priceList at: aBook) .
	

	
	! !

!InterfaceFacadeTest methodsFor: 'listPurchases' stamp: 'SC 7/21/2020 22:35:33'!
test16TotalOfAllPurchasesOfAValidUserAreInHisPurchaseList
		
	| aCartId anotherCartId anInterfaceFacade aPurchasesList |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	anotherCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	
	anInterfaceFacade add: 1 of: aBook intoCartWith: aCartId. 
	anInterfaceFacade add: 1 of: aBook intoCartWith: anotherCartId. 
	
	anInterfaceFacade checkOutOfCart: aCartId 
	                            with: '1234567812345678' 
	                            anExpiration: StoreTestObjectsFactory notExpiredDate 
	                            anOwner: 'John' 
	                            anCode: '123'. 
	
	anInterfaceFacade checkOutOfCart: anotherCartId 
	                            with: '1234567812345678' 
	                            anExpiration: StoreTestObjectsFactory notExpiredDate 
	                            anOwner: 'John' 
	                            anCode: '123'. 
		
	aPurchasesList := anInterfaceFacade listPurchasesOf: aValidUser with: aValidPassword .
	
	self assert: (aPurchasesList quantityOf: aBook) = 2.
	self assert: aPurchasesList total = ((priceList at: aBook)*2) .
	

	
	! !

!InterfaceFacadeTest methodsFor: 'listPurchases' stamp: 'SC 7/21/2020 22:36:18'!
test17PurchaseListsOfDifferentUsersAreDifferent
		
	| aCartId anotherCartId anInterfaceFacade aPurchasesList anotherPurchasesList |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	anotherCartId := anInterfaceFacade createCart: anotherValidUser with: anotherValidPassword .
	
	anInterfaceFacade add: 1 of: aBook intoCartWith: aCartId. 
	anInterfaceFacade add: 1 of: aBook intoCartWith: anotherCartId. 
	
	anInterfaceFacade checkOutOfCart: aCartId 
	                            with: '1234567812345678' 
	                            anExpiration: StoreTestObjectsFactory notExpiredDate 
	                            anOwner: 'John' 
	                            anCode: '123'. 
	
	anInterfaceFacade checkOutOfCart: anotherCartId 
	                            with: '1234567812345678' 
	                            anExpiration: StoreTestObjectsFactory notExpiredDate 
	                            anOwner: 'John' 
	                            anCode: '123'. 
		
	aPurchasesList := anInterfaceFacade listPurchasesOf: aValidUser with: aValidPassword .
	anotherPurchasesList := anInterfaceFacade listPurchasesOf: anotherValidUser with: anotherValidPassword .
	
	self deny: aPurchasesList = anotherPurchasesList .
	

	
	! !

!InterfaceFacadeTest methodsFor: 'listPurchases' stamp: 'SC 7/21/2020 22:38:37'!
test18PurchaseListsOfDifferentUsersAreDifferentAndContainTheCorrespondingPurchases
		
	| aCartId anotherCartId anInterfaceFacade aPurchasesList anotherPurchasesList |
	
	anInterfaceFacade := InterfaceFacade debitingWith: positiveMerchantProcessor 
	                                                             acceptingItemsFrom: priceList 
	                                                             registeringOn: salesList 
	                                                             measuringTimeWith: clock.
	
	aCartId := anInterfaceFacade createCart: aValidUser with: aValidPassword .
	anotherCartId := anInterfaceFacade createCart: anotherValidUser with: anotherValidPassword .
	
	anInterfaceFacade add: 1 of: aBook intoCartWith: aCartId. 
	anInterfaceFacade add: 2 of: aBook intoCartWith: anotherCartId. 
	
	anInterfaceFacade checkOutOfCart: aCartId 
	                            with: '1234567812345678' 
	                            anExpiration: StoreTestObjectsFactory notExpiredDate 
	                            anOwner: 'John' 
	                            anCode: '123'. 
	
	anInterfaceFacade checkOutOfCart: anotherCartId 
	                            with: '1234567812345678' 
	                            anExpiration: StoreTestObjectsFactory notExpiredDate 
	                            anOwner: 'John' 
	                            anCode: '123'. 
		
	aPurchasesList := anInterfaceFacade listPurchasesOf: aValidUser with: aValidPassword .
	anotherPurchasesList := anInterfaceFacade listPurchasesOf: anotherValidUser with: anotherValidPassword .
	
	self assert: (aPurchasesList quantityOf: aBook) = 1.
	self assert: aPurchasesList total = (priceList at: aBook) .
	
	self assert: (anotherPurchasesList quantityOf: aBook) = 2.
	self assert: anotherPurchasesList total = ((priceList at: aBook)*2) .	

	
	! !


!classDefinition: #AuthenticationSystem category: #TusLibros!
Object subclass: #AuthenticationSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticationSystem methodsFor: 'validation' stamp: 'FE 7/16/2020 19:14:24'!
isValid: aUserName with: aPassword

	self subclassResponsibility ! !


!classDefinition: #AuthenticationSystemSimulator category: #TusLibros!
AuthenticationSystem subclass: #AuthenticationSystemSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AuthenticationSystemSimulator methodsFor: 'validation' stamp: 'SC 7/18/2020 17:37:10'!
isValid: aUserName with: aPassword

	^ (aUserName = StoreTestObjectsFactory validUser & aPassword = StoreTestObjectsFactory validPassword )
		| (aUserName = StoreTestObjectsFactory anotherValidUser & aPassword = StoreTestObjectsFactory anotherValidPassword )
			ifFalse: [ self error: 'Invalid Credentials' ]. 
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


!Cart methodsFor: 'initialization' stamp: 'SC 7/21/2020 22:06:36'!
initializeAcceptingItemsOf: aPriceList

	priceList := aPriceList.
	items := Bag new.! !


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


!Cart methodsFor: 'operations' stamp: 'SC 7/21/2020 22:08:50'!
clear
	
	items _ Bag new. ! !


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

!Cart class methodsFor: 'instance creation' stamp: 'SC 7/18/2020 17:05:49'!
acceptingItemsOf: aPriceList from: aBuyer

	^self new initializeAcceptingItemsOf: aPriceList from:aBuyer ! !


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

!CashierCart methodsFor: 'operations' stamp: 'SC 7/21/2020 20:44:03'!
checkOutOf: aCart with: aCreditCard debitingWith: aMerchantProcessor from: aUsername

	| aSale |
	
	self assertIsValidCart: aCart.
	self assertIsValidCreditCard: aCreditCard. 
	
	aMerchantProcessor debit: aCart total from: aCreditCard .
	
	aSale := Sale of: aCart from: aUsername.
	
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


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: 'dateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'operations' stamp: 'SC 7/21/2020 20:13:29'!
advanceTime: aTime

	dateTime _ dateTime + aTime .! !

!Clock methodsFor: 'operations' stamp: 'SC 7/21/2020 20:14:26'!
now

	^dateTime ! !


!Clock methodsFor: 'initialize' stamp: 'SC 7/21/2020 20:48:48'!
with: aTime

	dateTime := aTime .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: #TusLibros!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 20:48:33'!
with: aTime

	^self new with: aTime! !


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


!classDefinition: #InterfaceFacade category: #TusLibros!
Object subclass: #InterfaceFacade
	instanceVariableNames: 'carts salesList merchantProcessor cartSessions clock priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceFacade methodsFor: 'operations' stamp: 'SC 7/21/2020 21:56:37'!
add: aQuantity of: aBook intoCartWith: aCartId

	| aCart |
	
	aCart := carts at: aCartId ifAbsent: [self error: 'Invalid Cart Id'].
	
	self validateSessionFrom: aCartId .
	
	aCart add: aQuantity of: aBook. 
	
	self updateTimeOfSessionFrom: aCartId .
	! !

!InterfaceFacade methodsFor: 'operations' stamp: 'SC 7/21/2020 21:40:34'!
checkOutOfCart: aCartId with: aCCNumber anExpiration: aCCExpiration anOwner: aCCOwner anCode: aCCCode

	| aCart aCreditCard aCashier aUsername |

	aCart := carts at: aCartId ifAbsent: [self error: 'Invalid Cart Id'].	

	self validateSessionFrom: aCartId .

	aCreditCard := CreditCard new initializeWithANumber: aCCNumber name: aCCOwner expiration: aCCExpiration andCode: aCCCode.
	aCashier := CashierCart with: salesList.
	aUsername := (cartSessions at: aCartId) username .
	
	aCashier checkOutOf: aCart with: aCreditCard  debitingWith: merchantProcessor from: aUsername. 
	
	carts removeKey: aCartId ifAbsent: [self error: 'Invalid Cart Id'].
	
	self updateTimeOfSessionFrom: aCartId .
	
	^ salesList size.
! !

!InterfaceFacade methodsFor: 'operations' stamp: 'SC 7/21/2020 21:57:01'!
createCart: aUsername with: aPassword

	| aCart aCartId aCartSession |
	
	AuthenticationSystemSimulator new isValid: aUsername with: aPassword . 
	
	aCart := Cart new initializeAcceptingItemsOf: priceList .
	aCartId := self generateCartId.
	
	aCartSession := CartSession from: aUsername with: clock.
	
	carts add: aCartId -> aCart .
	cartSessions add: aCartId -> aCartSession.
	
	^ aCartId .! !

!InterfaceFacade methodsFor: 'operations' stamp: 'FE 7/16/2020 21:00:28'!
generateCartId

	^ carts size + 1! !


!InterfaceFacade methodsFor: 'initialization' stamp: 'SC 7/21/2020 21:56:02'!
debitingWith: aMerchantProcessor acceptingItemsFrom: aPriceList registeringOn: aSalesList measuringTimeWith: aClock
	
	merchantProcessor := aMerchantProcessor .
	priceList := aPriceList .
	salesList := aSalesList .
	clock := aClock.
	carts := Dictionary new .
	cartSessions := Dictionary new .
	! !


!InterfaceFacade methodsFor: 'session' stamp: 'SC 7/21/2020 20:26:57'!
hasCartSession: aCartId

	^cartSessions includesKey: aCartId .! !

!InterfaceFacade methodsFor: 'session' stamp: 'SC 7/21/2020 21:19:36'!
hasValidSession: aCartId

	| aCartSession |

	aCartSession := cartSessions at: aCartId .
	
	^aCartSession isValid. ! !

!InterfaceFacade methodsFor: 'session' stamp: 'SC 7/21/2020 21:28:42'!
sessionExpiredError

	^'Session expired' .! !

!InterfaceFacade methodsFor: 'session' stamp: 'SC 7/21/2020 21:16:53'!
updateTimeOfSessionFrom: aCartId 
	
	| aCartSession |
	
	aCartSession := cartSessions at: aCartId .
	
	aCartSession updateTime .! !

!InterfaceFacade methodsFor: 'session' stamp: 'SC 7/21/2020 21:28:28'!
validateSessionFrom:  aCartId

	| aCartSession |
	
	aCartSession := cartSessions at: aCartId .
	
	(aCartSession isValid)
		ifFalse: [self error: self sessionExpiredError]! !


!InterfaceFacade methodsFor: 'list' stamp: 'SC 7/21/2020 21:35:17'!
itemsFrom: aCartId

	| aCart |
		
	aCart := carts at: aCartId ifAbsent: [self error: 'Invalid Cart Id'].
	
	^ aCart items.
! !

!InterfaceFacade methodsFor: 'list' stamp: 'SC 7/21/2020 21:37:33'!
listCart: aCartId

	| aCart |
	
	aCart := carts at: aCartId ifAbsent: [self error: 'Invalid Cart Id'].
	
	self validateSessionFrom: aCartId .
	self updateTimeOfSessionFrom: aCartId .
	
	^ aCart items.
! !

!InterfaceFacade methodsFor: 'list' stamp: 'SC 7/21/2020 22:16:37'!
listPurchasesOf: aUsername with: aPassword

	| salesFromUser |

	AuthenticationSystemSimulator new isValid: aUsername with: aPassword .
	
	salesFromUser := salesList select: [ :aSale | aSale owner = aUsername] .
	
	^self createTicket: salesFromUser .! !

!InterfaceFacade methodsFor: 'list' stamp: 'SC 7/21/2020 21:44:28'!
sales

	^salesList ! !


!InterfaceFacade methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 22:24:16'!
createTicket: aListOfSales

	| aTicket |
	
	aTicket := Ticket new .
	
	aListOfSales do: [ :aSale |
		aTicket addAllItemsFrom: aSale items .
		aTicket addToTotal: aSale total .
		].
	
	^aTicket .
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InterfaceFacade class' category: #TusLibros!
InterfaceFacade class
	instanceVariableNames: ''!

!InterfaceFacade class methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 21:53:57'!
debitingWith: aMerchantProcessor acceptingItemsFrom: aPriceList registeringOn: aSalesList measuringTimeWith: Clock

	^self new debitingWith: aMerchantProcessor acceptingItemsFrom: aPriceList registeringOn: aSalesList measuringTimeWith: Clock .! !

!InterfaceFacade class methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 20:51:52'!
with: aClock

	^self new with: aClock .! !


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

!MerchantProcessorSimmulator class methodsFor: 'initialization' stamp: 'SC 7/14/2020 19:32:42'!
with: aDebitBehaviour

	^self new with: aDebitBehaviour! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'date priceList items owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialize' stamp: 'SC 7/21/2020 20:41:04'!
initializeWith: aCart

	items := aCart items copy.
	priceList := aCart priceList copy.
	date := Date today.! !

!Sale methodsFor: 'initialize' stamp: 'SC 7/21/2020 20:44:35'!
initializeWith: aCart and: aUsername

	items := aCart items copy.
	priceList := aCart priceList copy.
	owner := aUsername .
	date := Date today.! !


!Sale methodsFor: 'operations' stamp: 'SC 7/18/2020 17:26:11'!
owner

	^owner .! !

!Sale methodsFor: 'operations' stamp: 'SC 7/11/2020 16:35:18'!
total

	^ items sum: [ :item | priceList at: item] .! !


!Sale methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 22:31:53'!
items

	^items .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'as yet unclassified' stamp: 'SC 7/16/2020 12:29:09'!
of: aCart

	^Sale new initializeWith: aCart .! !

!Sale class methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 20:44:19'!
of: aCart from: aUsername

	^self new initializeWith: aCart and: aUsername.! !


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

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/18/2020 17:37:54'!
anotherValidPassword
	
	^ 'anotherValidPassword'! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/18/2020 17:37:31'!
anotherValidUser
	
	^ 'anotherValidUser'! !

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

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/21/2020 22:41:46'!
expiredCreditCardDate
	
	^ '01' , (Date today yearNumber - 1) asString .! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'FE 7/16/2020 19:46:42'!
invalidCartId
	
	^ 'invalidCartId'! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'FE 7/16/2020 18:54:31'!
invalidPassword
	
	^ 'invalidPassword'! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'FE 7/16/2020 18:54:19'!
invalidUser
	
	^ 'invalidUser'! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/14/2020 20:06:06'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/14/2020 20:04:45'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/18/2020 17:20:10'!
notExpiredDate

	^'01' , (Date today yearNumber + 1) asString! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'FE 7/16/2020 19:46:35'!
validCartId
	
	^ 'validCartId'! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'SC 7/21/2020 22:47:30'!
validCreditCardDate
	
	^ '01' , (Date today yearNumber + 1) asString .! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'FE 7/16/2020 18:55:33'!
validPassword
	
	^ 'validPassword'! !

!StoreTestObjectsFactory class methodsFor: 'support' stamp: 'FE 7/16/2020 18:55:47'!
validUser
	
	^ 'validUser'! !


!classDefinition: #Ticket category: #TusLibros!
Object subclass: #Ticket
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'add' stamp: 'SC 7/21/2020 22:25:34'!
addAllItemsFrom: aBagOfItems

	items addAll: aBagOfItems  .! !

!Ticket methodsFor: 'add' stamp: 'SC 7/21/2020 22:25:50'!
addToTotal: anAmmount

	total _ total + anAmmount .! !


!Ticket methodsFor: 'initialize' stamp: 'SC 7/21/2020 22:25:16'!
initialize

	items := Bag new .
	total := 0 .! !


!Ticket methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 22:27:20'!
isEmpty

	^items isEmpty .! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 22:32:55'!
quantityOf: aBook

	^items occurrencesOf: aBook .! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'SC 7/21/2020 22:33:59'!
total

	^total .! !
