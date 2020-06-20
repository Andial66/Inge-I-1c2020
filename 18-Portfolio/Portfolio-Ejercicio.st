!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio receptiveAccount anotherReceptiveAccount anotherPortfolio anotherPortfolio2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:08:53'!
test01CanAddAnAccountToPortfolio

	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new .
	
	portfolio addAccount: receptiveAccount .
	
	self assert: portfolio numberOfAccounts = 1 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:08:48'!
test02CanAddMoreThanOneAccountToPortfolio

	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new .
	anotherReceptiveAccount := ReceptiveAccount new .
	
	portfolio addAccount: receptiveAccount .
	portfolio addAccount: anotherReceptiveAccount .
	
	self assert: portfolio numberOfAccounts = 2 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:23:51'!
test03CanAddAPortfolioToPortfolio

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	
	portfolio addPortfolio: anotherPortfolio .
	
	self assert: portfolio numberOfPortfolios = 1 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:23:34'!
test04CanAddMoreThanOnePortfolioToPortfolio

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	anotherPortfolio2 := Portfolio new.
	
	portfolio addPortfolio: anotherPortfolio .
	portfolio addPortfolio: anotherPortfolio2 .
	
	self assert: portfolio numberOfPortfolios = 2 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:10:01'!
test05AccountIsInPortfolioWhenAdded

	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new .
	
	portfolio addAccount: receptiveAccount .
	
	self assert: (portfolio hasAccount: receptiveAccount).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:26:03'!
test06PortfolioIsInPortfolioWhenAdded

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	
	portfolio addPortfolio: anotherPortfolio .
	
	self assert: (portfolio hasPortfolio: anotherPortfolio).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:11:54'!
test07SameAccountCanBeInManyPortfolios

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	receptiveAccount := ReceptiveAccount new .
	
	portfolio addAccount: receptiveAccount .
	anotherPortfolio addAccount: receptiveAccount .
	
	self assert: (portfolio hasAccount: receptiveAccount).
	self assert: (anotherPortfolio hasAccount: receptiveAccount).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:37:47'!
test08BalanceOfEmptyPortfolioIsZero

	portfolio := Portfolio new.
	
	self assert: portfolio balance = 0 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:43:13'!
test09BalanceOfPortfolioWithOneAccountIsBalanceOfAccount

	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: receptiveAccount .
	Withdraw register: 50 on: receptiveAccount .
	
	portfolio addAccount: receptiveAccount .
	
	self assert: portfolio balance = 50 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:43:59'!
test10BalanceOfPortfolioWithOnePortfolioIsBalanceOfPortfolio

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: receptiveAccount .
	Withdraw register: 50 on: receptiveAccount .
	
	anotherPortfolio addAccount: receptiveAccount .
	portfolio addPortfolio: anotherPortfolio .
	
	self assert: portfolio balance = 50 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 21:03:40'!
test11CantAddSameAccountTwiceToPortfolio

	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new .
	
	portfolio addAccount: receptiveAccount .
	
	self should: [ portfolio addAccount: receptiveAccount ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 21:04:28'!
test12CantAddSamePortfolioTwiceToPortfolio

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	
	portfolio addPortfolio: anotherPortfolio .
	
	self should: [ portfolio addPortfolio: anotherPortfolio ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 21:07:16'!
test13CantAddAccountAlreadyRegisteredInOtherPorfolioFromMyPortfolio

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	receptiveAccount := ReceptiveAccount new .
	
	anotherPortfolio addAccount: receptiveAccount .
	portfolio addPortfolio: anotherPortfolio .
	
	self should: [ portfolio addAccount: receptiveAccount ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 21:05:57'!
test14CantAddPortfolioWithAlreadyRegisteredAccountToPortfolio

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	receptiveAccount := ReceptiveAccount new .
	
	portfolio addAccount: receptiveAccount .
	anotherPortfolio addAccount: receptiveAccount .
	
	self should: [ portfolio addPortfolio: anotherPortfolio ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:00:29'!
test15CantAddAccountIfFatherAlreadyHasThatAccount

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	receptiveAccount := ReceptiveAccount new .
	
	portfolio addPortfolio: anotherPortfolio .
	portfolio addAccount: receptiveAccount .
	
	self should: [ anotherPortfolio addAccount: receptiveAccount ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:09:38'!
test16CantAddAccountIfFatherAlreadyHasThatAccount

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	anotherPortfolio2 := Portfolio new.
	receptiveAccount := ReceptiveAccount new .
	
	portfolio addPortfolio: anotherPortfolio2 .
	anotherPortfolio2 addPortfolio: anotherPortfolio .
	portfolio addAccount: receptiveAccount .
	
	self should: [ anotherPortfolio addAccount: receptiveAccount ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:29:20'!
test17CantAddAccountIfFatherAlreadyHasThatAccount

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	anotherPortfolio2 := Portfolio new.
	receptiveAccount := ReceptiveAccount new .
	
	portfolio addPortfolio: anotherPortfolio2 .
	anotherPortfolio2 addPortfolio: anotherPortfolio .
	portfolio addAccount: receptiveAccount .
	
	self should: [ anotherPortfolio addAccount: receptiveAccount ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:30:56'!
test18CantAddPortfolioIfItIsAlreadyInTheTree

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	anotherPortfolio2 := Portfolio new.
	
	portfolio addPortfolio: anotherPortfolio2 .
	portfolio addPortfolio: anotherPortfolio .
	
	
	self should: [ anotherPortfolio addPortfolio: anotherPortfolio2 . ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:40:56'!
test19CantAddPortfolioIfAnAccountFromItIsAlreadyInTheTree

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	anotherPortfolio2 := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	
	portfolio addPortfolio: anotherPortfolio2 .
	portfolio addAccount: receptiveAccount .
	anotherPortfolio addAccount: receptiveAccount .
	
	self should: [ anotherPortfolio2 addPortfolio: anotherPortfolio . ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:47:39'!
test20CantAddPortfolioIfItIsAnAncestor

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	
	portfolio addPortfolio: anotherPortfolio .
	
	self should: [ anotherPortfolio addPortfolio: portfolio . ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 19:36:18'!
testXXPortfolioAccountsReturnsAllAccountsOfChildrenPortfolios

	| allAccounts |

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	receptiveAccount := ReceptiveAccount new .
	anotherReceptiveAccount := ReceptiveAccount new.
	
	portfolio addAccount: receptiveAccount .
	anotherPortfolio addAccount: anotherReceptiveAccount .
	
	portfolio addPortfolio: anotherPortfolio .
	
	allAccounts := OrderedCollection with: receptiveAccount with: anotherReceptiveAccount .
	
	self assert: portfolio accounts = allAccounts .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:25:01'!
testYYPortfolioLastAncestorsReturnsAllAncestorsFromPortfolio

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new .
	anotherPortfolio2 := Portfolio new.
	
	portfolio addPortfolio: anotherPortfolio .
	anotherPortfolio addPortfolio: anotherPortfolio2 .
	
	self assert: anotherPortfolio2 lastAncestors = (OrderedCollection with: portfolio) .! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SC 6/18/2020 20:18:03'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 19:37:47'!
isDeposit

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 19:37:51'!
isWithdraw

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'SC 6/18/2020 20:31:22'!
valueForBalance

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'SC 6/18/2020 20:31:35'!
valueForBalance

	^value*(-1)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 19:37:06'!
accounts

	^accounts , (portfolios inject: OrderedCollection new 
				                 into: [ :acum :aPortfolio | acum , aPortfolio accounts ])
		! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:32:10'!
addAccount: anAccount

	(self parentsHaveAccount: anAccount)
		ifTrue: [ self error: self class accountAlreadyRegisteredError ]
		ifFalse: [ accounts add: anAccount. ] .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:38:29'!
addPortfolio: aPortfolio

	(self parentsHavePortfolio: aPortfolio) | (self parentsHaveAccountsFrom: aPortfolio)
		ifTrue: [ self error: self class portfolioAlreadyRegisteredError ]
		ifFalse: [ portfolios add: aPortfolio.
				  aPortfolio parents add: self] .
		
		! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:40:01'!
balance

	^self balanceOfAccounts + self balanceOfPortfolios! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:40:54'!
balanceOfAccounts

	^accounts sum: [ :anAccount | anAccount balance] ifEmpty: [0]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:40:36'!
balanceOfPortfolios

	^portfolios sum: [ :aPortfolio | aPortfolio balance] ifEmpty: [0]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:04:53'!
hasAccount: anAccount

	^(accounts includes: anAccount)
		or: [portfolios inject: false into: [ :acum :aPortfolio | acum | (aPortfolio hasAccount: anAccount) ] ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 19:43:57'!
hasAccountsFrom: aPortfolio

	^aPortfolio accounts inject: false into: [ :acum :anAccount | acum | self hasAccount: anAccount ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:49:13'!
hasPortfolio: aPortfolio

	^(portfolios includes: aPortfolio) | (aPortfolio = self).! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:01:24'!
initialize

	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:24:46'!
lastAncestors

	^(parents inject: OrderedCollection new into: [ :acum :aParent | acum , aParent lastAncestors]) 
			    ifEmpty: [OrderedCollection with: self]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:27:42'!
numberOfAccounts

	^self accounts size .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:24:14'!
numberOfPortfolios

	^portfolios size! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:08:36'!
parents

	^parents! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:33:19'!
parentsHaveAccount: anAccount

	^(self lastAncestors) inject: false into: [ :acum :aParent | acum | aParent hasAccount: anAccount ] .

	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:40:24'!
parentsHaveAccountsFrom: aPortfolio

	^(self lastAncestors) inject: false into: [ :acum :aParent | acum | aParent hasAccountsFrom: aPortfolio ] .

	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'SC 6/20/2020 20:34:42'!
parentsHavePortfolio: aPortfolio

	^(self lastAncestors) inject: false into: [ :acum :aParent | acum | aParent hasPortfolio: aPortfolio ] .

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 20:16:33'!
accountAlreadyRegisteredError

	^'This account is already registered in this portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'SC 6/18/2020 21:04:41'!
portfolioAlreadyRegisteredError

	^'This portfolio is already registered in this portfolio'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'SC 6/20/2020 19:09:14'!
balance
	
	^transactions sum: [ :aTransaction | aTransaction valueForBalance] ifEmpty: [0].
	
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
