!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'accountOne accountTwo portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'accountOne accountTwo portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:02:44'!
test01AccountSummaryContainsAllDepositsOfAccount

	accountOne := ReceptiveAccount new .
	
	Deposit register: 100 on: accountOne .

	self assert: (accountOne accountSummary = 
		(OrderedCollection with: ('Depósito por 100')
							       with: ('Balance = 100'))) .
	 
! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:01:39'!
test02AccountSummaryContainsAllDepositsAndWithdrawsOfAccount

	accountOne := ReceptiveAccount new .
	
	Deposit register: 100 on: accountOne .
	Withdraw register: 50 on: accountOne .

	self assert: (accountOne accountSummary = 
		(OrderedCollection with: ('Depósito por 100') 
								  with: ('Extracción por 50')
								  with: ('Balance = 50'))) .
	 
! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:01:51'!
test03AccountSummaryContainsAllTransactionsOfAccount

	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new .
	
	Deposit register: 100 on: accountOne .
	Withdraw register: 50 on: accountOne .
	
	accountOne transfer: 50 to: accountTwo . 
	accountTwo transfer: 25 to: accountOne .
	

	self assert: (accountOne accountSummary = 
		(OrderedCollection with: ('Depósito por 100') 
							       with: ('Extracción por 50') 
							       with: ('Salida por transferencia de 50')
							       with: ('Entrada por transferencia de 25')
							       with: ('Balance = 25'))).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:02:18'!
test04AccountSummaryContainsAllTransactionsOfPortfolio

	portfolio := Portfolio new .
	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new .
	
	Deposit register: 100 on: accountOne .
	Withdraw register: 50 on: accountOne .
	
	accountOne transfer: 50 to: accountTwo . 
	accountTwo transfer: 25 to: accountOne .
	
	portfolio add: accountOne .
	
	self assert: (portfolio accountSummary = 
		(OrderedCollection with: ('Depósito por 100') 
							       with: ('Extracción por 50') 
							       with: ('Salida por transferencia de 50')
							       with: ('Entrada por transferencia de 25')
							       with: ('Balance = 25'))).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:04:30'!
test05TransferNetReportIsCeroIfNoTransfersWereDone

	accountOne := ReceptiveAccount new .
	
	Deposit register: 100 on: accountOne .

	self assert: (accountOne transferNetReport = 0).
	 
! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:06:04'!
test06TransferNetReportContainsAllOutgoingTransfersFromAccount

	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new .
	
	accountOne transfer: 50 to: accountTwo . 

	self assert: (accountOne transferNetReport = -50).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:09:17'!
test07TransferNetReportContainsAllKindOfTransfers

	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new .
	
	accountOne transfer: 50 to: accountTwo . 
	accountTwo transfer: 25 to: accountOne .

	self assert: (accountOne transferNetReport = -25).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:24:18'!
test08TransferNetReportContainsAllKindOfTransfersFromPortfolio

	portfolio := Portfolio new .
	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new .
	
	accountOne transfer: 50 to: accountTwo . 
	accountTwo transfer: 25 to: accountOne .
	
	portfolio add: accountOne .
	portfolio add: accountTwo .

	self assert: (portfolio transferNetReport = 0).! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'accountOne accountTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'SC 6/22/2020 20:43:46'!
test01

	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	
	Deposit register: 100 on: accountOne .
	Deposit register: 100 on: accountTwo .
	
	accountOne transfer: 50 to: accountTwo .
	
	self assert: (accountOne balance = 50) .
	self assert: (accountTwo balance = 150) .	 ! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'SC 6/22/2020 21:34:38'!
test02

	accountOne := ReceptiveAccount new.
	
	self should: [accountOne transfer: 50 to: accountOne ]
		 raise:  Error 
		 withMessageText: ReceptiveAccount sameAccountTransferError .	 ! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'SC 6/22/2020 21:37:48'!
test03

	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new .
	
	self should: [accountOne transfer: 0 to: accountTwo ]
		 raise:  Error 
		 withMessageText: ReceptiveAccount invalidAmmountError .	 ! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'SC 6/25/2020 20:51:38'!
accountSummary

	| report |
	
	report := AccountSummaryReport new.
	
	^report makeReportFromAccount: self.! !

!Account methodsFor: 'reports' stamp: 'SC 6/25/2020 21:04:55'!
transferNetReport

	| report |
	
	report := TransferNetReport new.
	
	^report makeReportFromAccount: self.! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'SC 6/22/2020 21:24:00'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance] .! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'transfer' stamp: 'SC 6/22/2020 21:36:30'!
assertIsValidTransferOf: anAmmount to: anAccount .
	
	(self = anAccount) ifTrue: [self error: ReceptiveAccount sameAccountTransferError ].
	
	(anAmmount > 0) ifFalse: [self error: ReceptiveAccount invalidAmmountError ] .! !

!ReceptiveAccount methodsFor: 'transfer' stamp: 'SC 6/25/2020 21:34:20'!
registerIncomingTransferFrom: aTransfer 

	transactions add: (IncomingTransfer from: aTransfer) .

	! !

!ReceptiveAccount methodsFor: 'transfer' stamp: 'SC 6/25/2020 21:34:13'!
registerOutgoingTransferFrom: aTransfer 

	transactions add: (OutgoingTransfer from: aTransfer) .

	! !

!ReceptiveAccount methodsFor: 'transfer' stamp: 'SC 6/25/2020 21:33:20'!
transfer: anAmmount to: anAccount 

	| transfer |

	self assertIsValidTransferOf: anAmmount to: anAccount .
	
	transfer := Transfer new from: self to: anAccount of: anAmmount . 
	
	self registerOutgoingTransferFrom: transfer .
	anAccount registerIncomingTransferFrom: transfer .
	
	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'SC 6/22/2020 21:36:51'!
invalidAmmountError

	^'Not a valid transfer ammount'! !

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'SC 6/22/2020 21:34:06'!
sameAccountTransferError

	^'Cant make a transfer between same account'! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'SC 6/25/2020 20:45:19'!
yyy: aReport

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'SC 6/22/2020 21:23:23'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:45:11'!
yyy: aReport

	aReport addDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransactionTransfer category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransactionTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:42:56'!
from: aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionTransfer class' category: #'Portfolio-Solucion'!
TransactionTransfer class
	instanceVariableNames: ''!

!TransactionTransfer class methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:45:15'!
from: aTransfer

	self subclassResponsibility .! !


!classDefinition: #IncomingTransfer category: #'Portfolio-Solucion'!
TransactionTransfer subclass: #IncomingTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:46:59'!
affectBalance: aBalance

	 ^ aBalance + self value! !

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:35:02'!
from: aTransfer

	transfer := aTransfer
	! !

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:47:39'!
value 

	 ^ transfer value! !

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:45:00'!
yyy: aReport

	aReport addIncomingTransfer: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingTransfer class' category: #'Portfolio-Solucion'!
IncomingTransfer class
	instanceVariableNames: ''!

!IncomingTransfer class methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:34:42'!
from: aTransfer

	^IncomingTransfer new from: aTransfer .! !


!classDefinition: #OutgoingTransfer category: #'Portfolio-Solucion'!
TransactionTransfer subclass: #OutgoingTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:47:06'!
affectBalance: aBalance

	^ aBalance - self value! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:43:13'!
from: aTransfer

	transfer := aTransfer .! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:47:33'!
value

	^ transfer value! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:44:51'!
yyy: aReport

	aReport addOutgoingTransfer: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingTransfer class' category: #'Portfolio-Solucion'!
OutgoingTransfer class
	instanceVariableNames: ''!

!OutgoingTransfer class methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:44:55'!
from: aTransfer

	^OutgoingTransfer new from: aTransfer! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'SC 6/22/2020 21:23:33'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:44:20'!
yyy: aReport

	aReport addWithdraw: self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:26:11'!
addDeposit: aDeposit

	self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:27:10'!
addIncomingTransfer: anIncomingTransfer

	self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:26:59'!
addOutgoingTransfer: anOutgoingTransfer

	self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:26:25'!
addWithdraw: aWithdraw

	self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:27:20'!
concludeReportFrom: anAccount

	self subclassResponsibility .! !

!Report methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:58:10'!
makeReportFromAccount: anAccount

	anAccount transactions do: [ :aTransaction | aTransaction yyy: self] .
	
	self concludeReportFrom: anAccount .
	
	^self returnReport .
	! !

!Report methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:27:25'!
returnReport

	self subclassResponsibility .! !


!classDefinition: #AccountSummaryReport category: #'Portfolio-Solucion'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'xxx summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:48:03'!
addDeposit: aDeposit

	summary add: 'Depósito por ' , aDeposit value asString .! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:48:55'!
addIncomingTransfer: anIncomingTransfer

	summary add: 'Entrada por transferencia de ' , anIncomingTransfer value asString .! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:48:38'!
addOutgoingTransfer: anOutgoingTransfer

	summary add: 'Salida por transferencia de ' , anOutgoingTransfer value asString .! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:47:30'!
addWithdraw: aWithdraw

	summary add: 'Extracción por ' , aWithdraw value asString .! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:57:53'!
concludeReportFrom: anAccount 

	summary add: 'Balance = ' , anAccount balance asString .! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:49:59'!
initialize

	summary := OrderedCollection new .! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:57:32'!
returnReport

	^summary! !


!classDefinition: #TransferNetReport category: #'Portfolio-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:59:31'!
addDeposit: aDeposit! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:08:25'!
addIncomingTransfer: anIncomingTransfer

	transferNet _ transferNet + anIncomingTransfer value! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:08:20'!
addOutgoingTransfer: anOutgoingTransfer

	transferNet _ transferNet - anOutgoingTransfer value! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:59:10'!
addWithdraw: aWithdraw! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:00:32'!
concludeReportFrom: anAccount

! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 20:58:58'!
initialize

	transferNet := 0 .! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:00:45'!
returnReport

	^transferNet .! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'origin destiny value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:31:12'!
from: anOriginAccount to: aDestinyAccount of: aValue

	origin := anOriginAccount .
	destiny := aDestinyAccount .
	value := aValue .
	! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:47:56'!
value

	^value ! !
