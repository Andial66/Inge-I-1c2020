!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolioOne accountOne accountTwo portfolioTwo portfolioThree deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:01'!
test01CanAddAnAccountToPortfolio

	portfolioOne := Portfolio new.
	accountOne := ReceptiveAccount new .
	
	portfolioOne addAccount: accountOne .
	
	self assert: portfolioOne numberOfAccounts = 1 .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:01'!
test02CanAddMoreThanOneAccountToPortfolio

	portfolioOne := Portfolio new.
	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new .
	
	portfolioOne addAccount: accountOne .
	portfolioOne addAccount: accountTwo .
	
	self assert: portfolioOne numberOfAccounts = 2 .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:09'!
test03CanAddAPortfolioToPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	
	portfolioOne addPortfolio: portfolioTwo .
	
	self assert: portfolioOne numberOfPortfolios = 1 .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:31'!
test04CanAddMoreThanOnePortfolioToPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	portfolioThree := Portfolio new.
	
	portfolioOne addPortfolio: portfolioTwo .
	portfolioOne addPortfolio: portfolioThree .
	
	self assert: portfolioOne numberOfPortfolios = 2 .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:01'!
test05AccountIsInPortfolioWhenAdded

	portfolioOne := Portfolio new.
	accountOne := ReceptiveAccount new .
	
	portfolioOne addAccount: accountOne .
	
	self assert: (portfolioOne hasAccount: accountOne).! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:09'!
test06PortfolioIsInPortfolioWhenAdded

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	
	portfolioOne addPortfolio: portfolioTwo .
	
	self assert: (portfolioOne hasPortfolio: portfolioTwo).! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:09'!
test07SameAccountCanBeInManyPortfolios

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	accountOne := ReceptiveAccount new .
	
	portfolioOne addAccount: accountOne .
	portfolioTwo addAccount: accountOne .
	
	self assert: (portfolioOne hasAccount: accountOne).
	self assert: (portfolioTwo hasAccount: accountOne).! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:01'!
test11CantAddSameAccountTwiceToPortfolio

	portfolioOne := Portfolio new.
	accountOne := ReceptiveAccount new .
	
	portfolioOne addAccount: accountOne .
	
	self should: [ portfolioOne addAccount: accountOne ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:09'!
test12CantAddSamePortfolioTwiceToPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	
	portfolioOne addPortfolio: portfolioTwo .
	
	self should: [ portfolioOne addPortfolio: portfolioTwo ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:09'!
test13CantAddAccountAlreadyRegisteredInOtherPorfolioFromMyPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	accountOne := ReceptiveAccount new .
	
	portfolioTwo addAccount: accountOne .
	portfolioOne addPortfolio: portfolioTwo .
	
	self should: [ portfolioOne addAccount: accountOne ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:09'!
test14CantAddPortfolioWithAlreadyRegisteredAccountToPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	accountOne := ReceptiveAccount new .
	
	portfolioOne addAccount: accountOne .
	portfolioTwo addAccount: accountOne .
	
	self should: [ portfolioOne addPortfolio: portfolioTwo ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:09'!
test15CantAddAccountIfFatherAlreadyHasThatAccount

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	accountOne := ReceptiveAccount new .
	
	portfolioOne addPortfolio: portfolioTwo .
	portfolioOne addAccount: accountOne .
	
	self should: [ portfolioTwo addAccount: accountOne ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'SC 6/22/2020 10:14:19'!
test16CantAddAccountIfLastAncestorAlreadyHasThatAccount

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	portfolioThree := Portfolio new.
	accountOne := ReceptiveAccount new .
	
	portfolioOne addPortfolio: portfolioThree .
	portfolioThree addPortfolio: portfolioTwo .
	portfolioOne addAccount: accountOne .
	
	self should: [ portfolioTwo addAccount: accountOne ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'SC 6/22/2020 10:15:25'!
test17CantAddAccountIfAccountAlreadyInTheTree

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	portfolioThree := Portfolio new.
	accountOne := ReceptiveAccount new .
	
	portfolioOne addPortfolio: portfolioThree .
	portfolioThree addPortfolio: portfolioTwo .
	portfolioOne addAccount: accountOne .
	
	self should: [ portfolioThree addAccount: accountOne ]
		 raise: Error
		 withMessageText: Portfolio accountAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:31'!
test18CantAddPortfolioIfItIsAlreadyInTheTree

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	portfolioThree := Portfolio new.
	
	portfolioOne addPortfolio: portfolioThree .
	portfolioOne addPortfolio: portfolioTwo .
	
	
	self should: [ portfolioTwo addPortfolio: portfolioThree . ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:31'!
test19CantAddPortfolioIfAnAccountFromItIsAlreadyInTheTree

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	portfolioThree := Portfolio new.
	accountOne := ReceptiveAccount new.
	
	portfolioOne addPortfolio: portfolioThree .
	portfolioOne addAccount: accountOne .
	portfolioTwo addAccount: accountOne .
	
	self should: [ portfolioThree addPortfolio: portfolioTwo . ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'FE 6/21/2020 19:18:09'!
test20CantAddPortfolioIfItIsAnAncestor

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	
	portfolioOne addPortfolio: portfolioTwo .
	
	self should: [ portfolioTwo addPortfolio: portfolioOne . ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !

!PortfolioTest methodsFor: 'addingTests' stamp: 'SC 6/22/2020 10:16:43'!
test21CantAddPortfolioIfItIsAChildrenPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	portfolioThree := Portfolio new .
	
	portfolioOne addPortfolio: portfolioTwo .
	portfolioTwo addPortfolio: portfolioThree .
	
	self should: [ portfolioOne addPortfolio: portfolioThree . ]
		 raise: Error
		 withMessageText: Portfolio portfolioAlreadyRegisteredError .! !


!PortfolioTest methodsFor: 'balanceTests' stamp: 'FE 6/21/2020 19:18:01'!
test08BalanceOfEmptyPortfolioIsZero

	portfolioOne := Portfolio new.
	
	self assert: portfolioOne balance = 0 .! !

!PortfolioTest methodsFor: 'balanceTests' stamp: 'FE 6/21/2020 19:18:01'!
test09BalanceOfPortfolioWithOneAccountIsBalanceOfAccount

	portfolioOne := Portfolio new.
	accountOne := ReceptiveAccount new.
	
	Deposit register: 100 on: accountOne .
	Withdraw register: 50 on: accountOne .
	
	portfolioOne addAccount: accountOne .
	
	self assert: portfolioOne balance = 50 .! !

!PortfolioTest methodsFor: 'balanceTests' stamp: 'FE 6/21/2020 19:18:09'!
test10BalanceOfPortfolioWithOnePortfolioIsBalanceOfPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new.
	accountOne := ReceptiveAccount new.
	
	Deposit register: 100 on: accountOne .
	Withdraw register: 50 on: accountOne .
	
	portfolioTwo addAccount: accountOne .
	portfolioOne addPortfolio: portfolioTwo .
	
	self assert: portfolioOne balance = 50 .! !


!PortfolioTest methodsFor: 'accessTests' stamp: 'SC 6/22/2020 10:16:54'!
test22PortfolioAccountsReturnsAllAccountsOfChildrenPortfolios

	| allAccounts |

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new.
	
	portfolioOne addAccount: accountOne .
	portfolioTwo addAccount: accountTwo .
	
	portfolioOne addPortfolio: portfolioTwo .
	
	allAccounts := OrderedCollection with: accountOne with: accountTwo .
	
	self assert: portfolioOne accounts = allAccounts .! !

!PortfolioTest methodsFor: 'accessTests' stamp: 'SC 6/22/2020 10:16:59'!
test23PortfolioLastAncestorsReturnsAllAncestorsFromPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	portfolioThree := Portfolio new.
	
	portfolioOne addPortfolio: portfolioTwo .
	portfolioTwo addPortfolio: portfolioThree .
	
	self assert: portfolioThree lastAncestors = (OrderedCollection with: portfolioOne) .! !

!PortfolioTest methodsFor: 'accessTests' stamp: 'SC 6/22/2020 10:27:57'!
test24PortfolioNumberOfPortfoliosIncludeNumberOfChildrenPortfolios

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new .
	portfolioThree := Portfolio new.
	
	portfolioOne addPortfolio: portfolioTwo .
	portfolioTwo addPortfolio: portfolioThree .
	
	self assert: portfolioOne numberOfPortfolios = 2.! !

!PortfolioTest methodsFor: 'accessTests' stamp: 'SC 6/22/2020 19:45:47'!
test25PortfolioWithOnlyOneAccountHasItsTransactions

	portfolioOne := Portfolio new.
	accountOne := ReceptiveAccount new.
	
	deposit := Deposit new initializeWith: 100.
	
	accountOne register: deposit. 
	portfolioOne addAccount: accountOne .
	
	self assert: (portfolioOne hasTransaction: deposit).! !

!PortfolioTest methodsFor: 'accessTests' stamp: 'SC 6/22/2020 19:47:26'!
test26PortfolioHasTransactionsFromChildrenPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new.
	accountOne := ReceptiveAccount new.
	
	deposit := Deposit new initializeWith: 100.
	
	accountOne register: deposit. 
	portfolioTwo addAccount: accountOne .
	portfolioOne addPortfolio: portfolioTwo .
	
	self assert: (portfolioOne hasTransaction: deposit).! !

!PortfolioTest methodsFor: 'accessTests' stamp: 'SC 6/22/2020 19:55:14'!
test27PortfolioHasTransactionsFromHisAccounts

	portfolioOne := Portfolio new.
	accountOne := ReceptiveAccount new.
	
	deposit := Deposit new initializeWith: 100.
	withdraw := Withdraw new initializeWith: 50.
	
	accountOne register: deposit. 
	accountOne register: withdraw.

	portfolioOne addAccount: accountOne .
	
	self assert: (portfolioOne transactions includes: deposit).
	self assert: (portfolioOne transactions includes: withdraw).
	self assert: (portfolioOne transactions size = 2)! !

!PortfolioTest methodsFor: 'accessTests' stamp: 'SC 6/22/2020 19:56:03'!
test28PortfolioHasTransactionsFromHisChildrenPortfolio

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new.
	accountOne := ReceptiveAccount new.
	
	deposit := Deposit new initializeWith: 100.
	withdraw := Withdraw new initializeWith: 50.
	
	accountOne register: deposit. 
	accountOne register: withdraw.

	portfolioTwo addAccount: accountOne .
	portfolioOne addPortfolio: portfolioTwo .
	
	self assert: (portfolioOne transactions includes: deposit).
	self assert: (portfolioOne transactions includes: withdraw).
	self assert: (portfolioOne transactions size = 2)! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FE 6/21/2020 19:52:02'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit with: 100.
	withdraw := Withdraw with: 50.
		
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'FE 6/21/2020 19:47:47'!
register: aValue on: account

	| transaction |
	
	transaction := self with: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'FE 6/21/2020 19:42:19'!
initializeWith: aValue

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

!Deposit class methodsFor: 'instance creation' stamp: 'FE 6/21/2020 19:43:06'!
with: aValue

	^ self new initializeWith: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'FE 6/21/2020 19:42:32'!
initializeWith: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'FE 6/21/2020 19:46:29'!
valueForBalance

	^ value*(-1)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'FE 6/21/2020 19:43:20'!
with: aValue

	^ self new initializeWith: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'SC 6/18/2020 20:40:01'!
balance

	^self balanceOfAccounts + self balanceOfPortfolios! !

!Portfolio methodsFor: 'balance' stamp: 'SC 6/18/2020 20:40:54'!
balanceOfAccounts

	^accounts sum: [ :anAccount | anAccount balance] ifEmpty: [0]! !

!Portfolio methodsFor: 'balance' stamp: 'SC 6/18/2020 20:40:36'!
balanceOfPortfolios

	^portfolios sum: [ :aPortfolio | aPortfolio balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'initialization' stamp: 'SC 6/20/2020 20:01:24'!
initialize

	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'operations' stamp: 'SC 6/20/2020 20:32:10'!
addAccount: anAccount

	(self parentsHaveAccount: anAccount)
		ifTrue: [ self error: self class accountAlreadyRegisteredError ]
		ifFalse: [ accounts add: anAccount. ] .! !

!Portfolio methodsFor: 'operations' stamp: 'SC 6/20/2020 20:38:29'!
addPortfolio: aPortfolio

	(self parentsHavePortfolio: aPortfolio) | (self parentsHaveAccountsFrom: aPortfolio)
		ifTrue: [ self error: self class portfolioAlreadyRegisteredError ]
		ifFalse: [ portfolios add: aPortfolio.
				  aPortfolio parents add: self] .
		
		! !


!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 10:21:46'!
accounts

	^accounts , self childrenAccounts 
	
	
		! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 10:22:07'!
childrenAccounts

	^(portfolios inject: OrderedCollection new 
				  into: [ :acum :aPortfolio | acum , aPortfolio accounts ])
	
	
		! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 19:48:40'!
childrenPortfolioHaveTransaction: aTransaction

	^portfolios anySatisfy: [ :aChildrenPortfolio | aChildrenPortfolio hasTransaction: aTransaction ] .! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 10:31:35'!
childrenPortfoliosHaveAccount: anAccount

	^portfolios inject: false into: [ :acum :aPortfolio | acum | (aPortfolio hasAccount: anAccount) ]! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 10:25:29'!
childrenPortfoliosHavePortfolio: aPortfolio

	^portfolios inject: false into: [ :acum :aChildPortfolio | acum | (aChildPortfolio hasPortfolio: aPortfolio)].! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 10:24:16'!
hasAccount: anAccount

	^(accounts includes: anAccount)
		or: [self childrenPortfoliosHaveAccount: anAccount ]! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/20/2020 19:43:57'!
hasAccountsFrom: aPortfolio

	^aPortfolio accounts inject: false into: [ :acum :anAccount | acum | self hasAccount: anAccount ].! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 10:25:43'!
hasPortfolio: aPortfolio

	^(aPortfolio = self) | (portfolios includes: aPortfolio)  
		or: [self childrenPortfoliosHavePortfolio: aPortfolio ].! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 19:48:13'!
hasTransaction: aTransaction

	^(accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ])
		or: [self childrenPortfolioHaveTransaction: aTransaction ].! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/20/2020 20:24:46'!
lastAncestors

	^(parents inject: OrderedCollection new into: [ :acum :aParent | acum , aParent lastAncestors]) 
			    ifEmpty: [OrderedCollection with: self]! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/20/2020 20:27:42'!
numberOfAccounts

	^self accounts size .! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 10:28:24'!
numberOfPortfolios

	^portfolios size + self numberOfPortfoliosFromChildrenPortfolios! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 10:29:07'!
numberOfPortfoliosFromChildrenPortfolios

	^portfolios sum: [ :aChildrenPortfolio | aChildrenPortfolio numberOfPortfolios ] ifEmpty: [0].! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/20/2020 20:08:36'!
parents

	^parents! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/20/2020 20:33:19'!
parentsHaveAccount: anAccount

	^(self lastAncestors) inject: false into: [ :acum :aParent | acum | aParent hasAccount: anAccount ] .

	! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/20/2020 20:40:24'!
parentsHaveAccountsFrom: aPortfolio

	^(self lastAncestors) inject: false into: [ :acum :aParent | acum | aParent hasAccountsFrom: aPortfolio ] .

	! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/20/2020 20:34:42'!
parentsHavePortfolio: aPortfolio

	^(self lastAncestors) inject: false into: [ :acum :aParent | acum | aParent hasPortfolio: aPortfolio ] .

	! !

!Portfolio methodsFor: 'access' stamp: 'SC 6/22/2020 19:54:35'!
transactions

	^(self accounts) inject: OrderedCollection new
				        into: [ :ListOfTransactions :anAccount | ListOfTransactions , anAccount transactions ].! !

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
