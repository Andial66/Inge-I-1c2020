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

!PortfolioTest methodsFor: 'tests' stamp: 'FE 6/28/2020 16:02:53'!
test16PortfolioNameAndNumberOfAccountsIsCorrect

	| childrenPortfolio johnsAccount angiesAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	
	self assert: (childrenPortfolio name = 'Portfolio de hijos').
	self assert: (childrenPortfolio accountsSize = 2).! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FE 6/28/2020 16:01:11'!
test08AccountsNameIsCorrect

	| johnsAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	
	self assert: (johnsAccount name = 'Cuenta de Juan').
! !


!classDefinition: #ReportTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'accountOne accountTwo portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'test transfer net report' stamp: 'SC 6/25/2020 21:04:30'!
test05TransferNetReportIsCeroIfNoTransfersWereDone

	accountOne := ReceptiveAccount new .
	
	Deposit register: 100 on: accountOne .

	self assert: (accountOne transferNetReport = 0).
	 
! !

!ReportTest methodsFor: 'test transfer net report' stamp: 'SC 6/25/2020 21:06:04'!
test06TransferNetReportContainsAllOutgoingTransfersFromAccount

	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new .
	
	accountOne transfer: 50 to: accountTwo . 

	self assert: (accountOne transferNetReport = -50).! !

!ReportTest methodsFor: 'test transfer net report' stamp: 'SC 6/25/2020 21:09:17'!
test07TransferNetReportContainsAllKindOfTransfers

	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new .
	
	accountOne transfer: 50 to: accountTwo . 
	accountTwo transfer: 25 to: accountOne .

	self assert: (accountOne transferNetReport = -25).! !

!ReportTest methodsFor: 'test transfer net report' stamp: 'SC 6/25/2020 21:24:18'!
test08TransferNetReportContainsAllKindOfTransfersFromPortfolio

	portfolio := Portfolio new .
	accountOne := ReceptiveAccount new .
	accountTwo := ReceptiveAccount new .
	
	accountOne transfer: 50 to: accountTwo . 
	accountTwo transfer: 25 to: accountOne .
	
	portfolio add: accountOne .
	portfolio add: accountTwo .

	self assert: (portfolio transferNetReport = 0).! !


!ReportTest methodsFor: 'test account summary report' stamp: 'SC 6/25/2020 21:02:44'!
test01AccountSummaryContainsAllDepositsOfAccount

	accountOne := ReceptiveAccount new .
	
	Deposit register: 100 on: accountOne .

	self assert: (accountOne accountSummary = 
		(OrderedCollection with: ('Depósito por 100')
							       with: ('Balance = 100'))) .
	 
! !

!ReportTest methodsFor: 'test account summary report' stamp: 'SC 6/25/2020 21:01:39'!
test02AccountSummaryContainsAllDepositsAndWithdrawsOfAccount

	accountOne := ReceptiveAccount new .
	
	Deposit register: 100 on: accountOne .
	Withdraw register: 50 on: accountOne .

	self assert: (accountOne accountSummary = 
		(OrderedCollection with: ('Depósito por 100') 
								  with: ('Extracción por 50')
								  with: ('Balance = 50'))) .
	 
! !

!ReportTest methodsFor: 'test account summary report' stamp: 'SC 6/25/2020 21:01:51'!
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

!ReportTest methodsFor: 'test account summary report' stamp: 'SC 6/25/2020 21:02:18'!
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


!ReportTest methodsFor: 'test portfolio tree report' stamp: 'FE 6/28/2020 16:07:01'!
test09PortfolioTreeReportReturnErrorForReceptiveAccount

	| johnsAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	
	self
		should: [ johnsAccount treeReport ]
		raise: Error
		withMessageText: ReceptiveAccount receptiveAccountIsNotPortfolioError. 
	
	! !

!ReportTest methodsFor: 'test portfolio tree report' stamp: 'FE 6/28/2020 16:09:21'!
test10PortfolioTreeReportContainsAllAccounts

	| childrenPortfolio johnsAccount angiesAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	
	
	self assert: (childrenPortfolio treeReport = 
					    (OrderedCollection with: ('Portfolio de hijos')
												with: ('Cuenta de Juan')
												with: ('Cuenta de Angeles'))).
	! !

!ReportTest methodsFor: 'test portfolio tree report' stamp: 'FE 6/28/2020 16:09:53'!
test11PortfolioTreeReportContainsAllAccountsAndOthersPortfolios

	| childrenPortfolio johnsAccount angiesAccount myAccount familyPortfolio |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	
	self assert: (familyPortfolio treeReport = 
					    (OrderedCollection with: ('Portfolio de la familia') 
							       			with: ('Cuenta mia') 
							       			with: ('Portfolio de hijos')
												with: ('Cuenta de Juan')
												with: ('Cuenta de Angeles'))).
	! !


!ReportTest methodsFor: 'test portfolio special report' stamp: 'FE 6/28/2020 17:34:26'!
test12PortfolioSpecialReportReturnErrorForReceptiveAccount

	| johnsAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	
	self
		should: [ johnsAccount specialReport ]
		raise: Error
		withMessageText: ReceptiveAccount receptiveAccountIsNotPortfolioError. 
	
	! !

!ReportTest methodsFor: 'test portfolio special report' stamp: 'FE 6/28/2020 17:38:06'!
test13PortfolioSpecialReportContainsAllAccountsWithBalanceZero

	| childrenPortfolio johnsAccount angiesAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	
	
	self assert: (childrenPortfolio specialReport = 
					    (OrderedCollection with: ('Portfolio de hijos')
												with: ('Cuenta de Juan')
												with: ('Balance = 0')
												with: ('Cuenta de Angeles')
												with: ('Balance = 0'))).
	! !

!ReportTest methodsFor: 'test portfolio special report' stamp: 'FE 6/28/2020 17:39:59'!
test14PortfolioSpecialReportContainsAllAccountsWithBalance

	| childrenPortfolio johnsAccount angiesAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	angiesAccount register: (Deposit new initializeFor: 100).
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	
	
	self assert: (childrenPortfolio specialReport = 
					    (OrderedCollection with: ('Portfolio de hijos')
												with: ('Cuenta de Juan')
												with: ('Balance = 0')
												with: ('Cuenta de Angeles')
												with: ('Depósito por 100')
												with: ('Balance = 100'))).
	! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'accountOne accountTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'testing' stamp: 'FE 6/28/2020 16:27:42'!
test01BalancesOfAccountsIsCorrectBeforeATransfer

	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	
	Deposit register: 100 on: accountOne .
	Deposit register: 100 on: accountTwo .
	
	accountOne transfer: 50 to: accountTwo .
	
	self assert: (accountOne balance = 50) .
	self assert: (accountTwo balance = 150) .	 ! !

!TransferTest methodsFor: 'testing' stamp: 'FE 6/28/2020 16:29:09'!
test02TransfersBetweenTheSameAccountIsNotPossible

	accountOne := ReceptiveAccount new.
	
	self should: [accountOne transfer: 50 to: accountOne ]
		 raise:  Error 
		 withMessageText: ReceptiveAccount sameAccountTransferError .	 ! !

!TransferTest methodsFor: 'testing' stamp: 'FE 6/28/2020 16:30:47'!
test03TransferWithAmountZeroIsNotPossible

	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new .
	
	self should: [accountOne transfer: 0 to: accountTwo ]
		 raise:  Error 
		 withMessageText: ReceptiveAccount invalidAmmountError .	 ! !

!TransferTest methodsFor: 'testing' stamp: 'FE 6/28/2020 16:31:46'!
test04TransferWithAmountNegativeIsNotPossible

	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new .
	
	self should: [accountOne transfer: -1 to: accountTwo ]
		 raise:  Error 
		 withMessageText: ReceptiveAccount invalidAmmountError .	 ! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
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


!Account methodsFor: 'accessing' stamp: 'FE 6/28/2020 16:20:00'!
name
	^name.! !


!Account methodsFor: 'reports' stamp: 'SC 6/25/2020 20:51:38'!
accountSummary

	| report |
	
	report := AccountSummaryReport new.
	
	^report makeReportFromAccount: self.! !

!Account methodsFor: 'reports' stamp: 'FE 6/28/2020 17:07:35'!
specialReport

	self subclassResponsibility.! !

!Account methodsFor: 'reports' stamp: 'SC 6/25/2020 21:04:55'!
transferNetReport

	| report |
	
	report := TransferNetReport new.
	
	^report makeReportFromAccount: self.! !

!Account methodsFor: 'reports' stamp: 'FE 6/28/2020 17:07:31'!
treeReport

	self subclassResponsibility.! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'FE 6/28/2020 14:58:19'!
accounts

	^accounts.! !

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

!Portfolio methodsFor: 'initialization' stamp: 'FE 6/28/2020 13:42:51'!
initializeWithName: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName.
	
	! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !



!Portfolio methodsFor: 'reports' stamp: 'FE 6/28/2020 17:17:02'!
addForReport: aReport

	aReport addPortfolio: self.! !

!Portfolio methodsFor: 'reports' stamp: 'FE 6/28/2020 17:07:54'!
specialReport

	| report |
	
	report := SpecialReport new.
	
	^report makeSpecialReportFrom: self.! !

!Portfolio methodsFor: 'reports' stamp: 'FE 6/28/2020 14:50:34'!
treeReport

	| report |
	
	report := PortfolioTreeReport new.
	
	^report makeTreeReportFrom: self.! !


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

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FE 6/28/2020 13:46:40'!
named: aName with: anAccount

	^self new initializeWithName: aName;
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FE 6/28/2020 13:50:15'!
named: aName with: anAccount with: anotherAccount

	^self new initializeWithName: aName;
		add: anAccount;
		add: anotherAccount;
		yourself! !

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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FE 6/28/2020 13:36:08'!
initializeWithName: aName

	transactions := OrderedCollection new.
	name := aName.! !



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


!ReceptiveAccount methodsFor: 'reports' stamp: 'FE 6/28/2020 17:17:56'!
addForReport: aReport

	aReport addReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'FE 6/28/2020 17:34:47'!
specialReport
	
	self error: ReceptiveAccount receptiveAccountIsNotPortfolioError.
	! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'FE 6/28/2020 15:43:21'!
treeReport
	
	self error: ReceptiveAccount receptiveAccountIsNotPortfolioError.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'SC 6/22/2020 21:36:51'!
invalidAmmountError

	^'Not a valid transfer ammount'! !

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'FE 6/28/2020 13:39:12'!
named: aName

	^ self new initializeWithName: aName.! !

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'FE 6/28/2020 15:43:47'!
receptiveAccountIsNotPortfolioError

	^'Cant make a tree report for a receptive account'! !

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


!AccountTransaction methodsFor: 'report' stamp: 'SC 6/25/2020 20:45:19'!
yyy: aReport

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

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


!Deposit methodsFor: 'report' stamp: 'FE 6/28/2020 17:27:19'!
addForReport: aReport

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

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'FE 6/28/2020 17:27:32'!
addForReport: aReport

	aReport addIncomingTransfer: self! !

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

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'FE 6/28/2020 17:27:44'!
addForReport: aReport

	aReport addOutgoingTransfer: self! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:47:06'!
affectBalance: aBalance

	^ aBalance - self value! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:43:13'!
from: aTransfer

	transfer := aTransfer .! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'SC 6/25/2020 21:47:33'!
value

	^ transfer value! !

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


!Withdraw methodsFor: 'report' stamp: 'FE 6/28/2020 17:27:57'!
addForReport: aReport

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
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initialization' stamp: 'FE 6/28/2020 17:25:41'!
initialize

	self subclassResponsibility .! !


!Report methodsFor: 'operations' stamp: 'SC 6/25/2020 21:26:11'!
addDeposit: aDeposit

	self subclassResponsibility .! !

!Report methodsFor: 'operations' stamp: 'SC 6/25/2020 21:27:10'!
addIncomingTransfer: anIncomingTransfer

	self subclassResponsibility .! !

!Report methodsFor: 'operations' stamp: 'SC 6/25/2020 21:26:59'!
addOutgoingTransfer: anOutgoingTransfer

	self subclassResponsibility .! !

!Report methodsFor: 'operations' stamp: 'SC 6/25/2020 21:26:25'!
addWithdraw: aWithdraw

	self subclassResponsibility .! !

!Report methodsFor: 'operations' stamp: 'SC 6/25/2020 21:27:20'!
concludeReportFrom: anAccount

	self subclassResponsibility .! !

!Report methodsFor: 'operations' stamp: 'FE 6/28/2020 17:33:23'!
makeReportFromAccount: anAccount

	anAccount transactions do: [ :aTransaction | aTransaction addForReport: self] .
	
	self concludeReportFrom: anAccount .
	
	^self returnReport .
	! !

!Report methodsFor: 'operations' stamp: 'FE 6/28/2020 17:30:00'!
makeSpecialReportFrom: aPortfolio

	self subclassResponsibility .! !

!Report methodsFor: 'operations' stamp: 'FE 6/28/2020 15:55:26'!
makeTreeReportFrom: aPortfolio

	self subclassResponsibility .! !

!Report methodsFor: 'operations' stamp: 'FE 6/28/2020 16:55:29'!
returnReport

	^report .! !


!classDefinition: #AccountSummaryReport category: #'Portfolio-Solucion'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReport methodsFor: 'operations' stamp: 'FE 6/28/2020 16:54:00'!
addDeposit: aDeposit

	report add: 'Depósito por ' , aDeposit value asString .! !

!AccountSummaryReport methodsFor: 'operations' stamp: 'FE 6/28/2020 16:54:04'!
addIncomingTransfer: anIncomingTransfer

	report add: 'Entrada por transferencia de ' , anIncomingTransfer value asString .! !

!AccountSummaryReport methodsFor: 'operations' stamp: 'FE 6/28/2020 16:54:08'!
addOutgoingTransfer: anOutgoingTransfer

	report add: 'Salida por transferencia de ' , anOutgoingTransfer value asString .! !

!AccountSummaryReport methodsFor: 'operations' stamp: 'FE 6/28/2020 16:54:12'!
addWithdraw: aWithdraw

	report add: 'Extracción por ' , aWithdraw value asString .! !

!AccountSummaryReport methodsFor: 'operations' stamp: 'FE 6/28/2020 16:54:15'!
concludeReportFrom: anAccount 

	report add: 'Balance = ' , anAccount balance asString .! !


!AccountSummaryReport methodsFor: 'initialization' stamp: 'FE 6/28/2020 17:24:49'!
initialize

	report := OrderedCollection new .! !


!classDefinition: #PortfolioTreeReport category: #'Portfolio-Solucion'!
Report subclass: #PortfolioTreeReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeReport methodsFor: 'operations' stamp: 'FE 6/28/2020 17:19:07'!
addPortfolio: aPortfolio

	report add: aPortfolio name.
	
	aPortfolio accounts do: [ :aAccount | aAccount addForReport: self] .! !

!PortfolioTreeReport methodsFor: 'operations' stamp: 'FE 6/28/2020 16:55:07'!
addReceptiveAccount: aReceptiveAccount

	report add: aReceptiveAccount name.! !

!PortfolioTreeReport methodsFor: 'operations' stamp: 'FE 6/28/2020 17:19:15'!
makeTreeReportFrom: aPortfolio
	
	report add: aPortfolio name.
	
	aPortfolio accounts do: [ :aAccount | aAccount addForReport: self] .						
	
		
	^self returnReport .! !


!PortfolioTreeReport methodsFor: 'initialization' stamp: 'FE 6/28/2020 17:24:58'!
initialize

	report := OrderedCollection new .! !


!classDefinition: #SpecialReport category: #'Portfolio-Solucion'!
Report subclass: #SpecialReport
	instanceVariableNames: 'specialReport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SpecialReport methodsFor: 'initialization' stamp: 'FE 6/28/2020 17:25:17'!
initialize

	report := OrderedCollection new .! !


!SpecialReport methodsFor: 'operations' stamp: 'FE 6/28/2020 17:18:35'!
addPortfolio: aPortfolio

	report add: aPortfolio name.
	
	aPortfolio accounts do: [ :aAccount | aAccount addForReport: self] .! !

!SpecialReport methodsFor: 'operations' stamp: 'FE 6/28/2020 17:10:35'!
addReceptiveAccount: aReceptiveAccount

	report add: aReceptiveAccount name.
	report addAll: aReceptiveAccount accountSummary. ! !

!SpecialReport methodsFor: 'operations' stamp: 'FE 6/28/2020 17:18:43'!
makeSpecialReportFrom: aPortfolio
	
	report add: aPortfolio name.
	
	aPortfolio accounts do: [ :aAccount | aAccount addForReport: self] .						
	
		
	^self returnReport .! !


!classDefinition: #TransferNetReport category: #'Portfolio-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'initialization' stamp: 'FE 6/28/2020 17:25:27'!
initialize

	report := 0.
! !


!TransferNetReport methodsFor: 'operations' stamp: 'SC 6/25/2020 20:59:31'!
addDeposit: aDeposit! !

!TransferNetReport methodsFor: 'operations' stamp: 'FE 6/28/2020 16:56:11'!
addIncomingTransfer: anIncomingTransfer

	report _ report + anIncomingTransfer value! !

!TransferNetReport methodsFor: 'operations' stamp: 'FE 6/28/2020 16:56:17'!
addOutgoingTransfer: anOutgoingTransfer

	report _ report - anOutgoingTransfer value! !

!TransferNetReport methodsFor: 'operations' stamp: 'SC 6/25/2020 20:59:10'!
addWithdraw: aWithdraw! !

!TransferNetReport methodsFor: 'operations' stamp: 'SC 6/25/2020 21:00:32'!
concludeReportFrom: anAccount

! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'origin destiny value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'SC 6/25/2020 21:31:12'!
from: anOriginAccount to: aDestinyAccount of: aValue

	origin := anOriginAccount .
	destiny := aDestinyAccount .
	value := aValue .
	! !


!Transfer methodsFor: 'accessing' stamp: 'SC 6/25/2020 21:47:56'!
value

	^value ! !
