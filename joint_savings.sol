{\rtf1\ansi\ansicpg1252\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red79\green123\blue61;\red26\green26\blue41;\red172\green172\blue193;
\red70\green137\blue204;\red212\green212\blue212;\red167\green197\blue152;\red45\green175\blue118;\red13\green102\blue149;
\red194\green126\blue101;\red253\green181\blue13;\red14\green86\blue166;}
{\*\expandedcolortbl;;\cssrgb\c37647\c54510\c30588;\cssrgb\c13333\c13725\c21176;\cssrgb\c72941\c73333\c80000;
\cssrgb\c33725\c61176\c83922;\cssrgb\c86275\c86275\c86275;\cssrgb\c70980\c80784\c65882;\cssrgb\c19608\c72941\c53725;\cssrgb\c0\c47843\c65098;
\cssrgb\c80784\c56863\c47059;\cssrgb\c100000\c75686\c2745;\cssrgb\c3137\c42353\c70980;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 /*\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 Joint Savings Account\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 ---------------------\cf4 \cb1 \strokec4 \
\
\cf2 \cb3 \strokec2 To automate the creation of joint savings accounts, you will create a solidity smart contract that accepts two user addresses that are then able to control a joint savings account. Your smart contract will use ether management functions to implement various requirements from the financial institution to provide the features of the joint savings account.\cf4 \cb1 \strokec4 \
\
\cf2 \cb3 \strokec2 The Starting file provided for this challenge contains a `pragma` for solidity version `5.0.0`.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2 You will do the following:\cf4 \cb1 \strokec4 \
\
\cf2 \cb3 \strokec2 1. Create and work within a local blockchain development environment using the JavaScript VM provided by the Remix IDE.\cf4 \cb1 \strokec4 \
\
\cf2 \cb3 \strokec2 2. Script and deploy a **JointSavings** smart contract.\cf4 \cb1 \strokec4 \
\
\cf2 \cb3 \strokec2 3. Interact with your deployed smart contract to transfer and withdraw funds.\cf4 \cb1 \strokec4 \
\
\cf2 \cb3 \strokec2 */\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 pragma\cf4 \strokec4  \cf5 \strokec5 solidity\cf4 \strokec4  \cf6 \strokec6 ^\cf7 \strokec7 0.5.0\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2 // Define a new contract named `JointSavings`\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf5 \cb3 \strokec5 contract\cf4 \strokec4  JointSavings \cf6 \strokec6 \{\cf4 \cb1 \strokec4 \
\
\pard\pardeftab720\partightenfactor0
\cf4 \cb3     \cf2 \strokec2 /*\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2     Inside the new contract define the following variables:\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2     - Two variables of type `address payable` named `accountOne` and `accountTwo`\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2     - A variable of type `address public` named `lastToWithdraw`\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2     - Two variables of type `uint public` named `lastWithdrawAmount` and `contractBalance`.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2     */\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3     \cf5 \strokec5 address\cf4 \strokec4  \cf8 \strokec8 payable\cf4 \strokec4  accountOne\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\cb3     \cf5 \strokec5 address\cf4 \strokec4  \cf8 \strokec8 payable\cf4 \strokec4  accountTwo\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\cb3     \cf5 \strokec5 address\cf4 \strokec4  \cf8 \strokec8 public\cf4 \strokec4  lastToWithdraw\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\cb3     \cf5 \strokec5 uint\cf4 \strokec4  \cf8 \strokec8 public\cf4 \strokec4  lastWithdrawAmount\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\cb3     \cf5 \strokec5 uint\cf4 \strokec4  \cf8 \strokec8 public\cf4 \strokec4  contractBalance\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\
\cb3     \cf2 \strokec2 /*\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2     Define a function named **withdraw** that will accept two arguments.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2     - A `uint` variable named `amount`\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2     - A `payable address` named `recipient`\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2     */\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3     \cf5 \strokec5 function\cf4 \strokec4  withdraw\cf6 \strokec6 (\cf5 \strokec5 uint\cf4 \strokec4  amount\cf6 \strokec6 ,\cf4 \strokec4  \cf5 \strokec5 address\cf4 \strokec4  \cf8 \strokec8 payable\cf4 \strokec4  recipient\cf6 \strokec6 )\cf4 \strokec4  \cf8 \strokec8 public\cf4 \strokec4  \cf6 \strokec6 \{\cf4 \cb1 \strokec4 \
\
\cb3         \cf2 \strokec2 /*\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2         Define a `require` statement that checks if the `recipient` is equal to either `accountOne` or `accountTwo`. The `requiere` statement returns the text `"You don't own this account!"` if it does not.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2         */\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3         \cf9 \strokec9 require\cf6 \strokec6 (\cf4 \strokec4 recipient \cf6 \strokec6 ==\cf4 \strokec4  accountOne \cf6 \strokec6 ||\cf4 \strokec4  recipient \cf6 \strokec6 ==\cf4 \strokec4  accountTwo\cf6 \strokec6 ,\cf4 \strokec4  \cf10 \strokec10 "You don\'92t own this account!"\cf6 \strokec6 );\cf4 \cb1 \strokec4 \
\
\cb3         \cf2 \strokec2 /*\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2         Define a `require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation. If there are insufficient funds, the text `Insufficient funds!` is returned.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2         */\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3         \cf9 \strokec9 require\cf6 \strokec6 (\cf4 \strokec4 contractBalance \cf6 \strokec6 >=\cf4 \strokec4  amount\cf6 \strokec6 ,\cf4 \strokec4  \cf10 \strokec10 "Insufficient funds!"\cf6 \strokec6 );\cf4 \cb1 \strokec4 \
\
\cb3         \cf2 \strokec2 /*\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2         Add and `if` statement to check if the `lastToWithdraw` is not equal to (`!=`) to `recipient` If `lastToWithdraw` is not equal, then set it to the current value of `recipient`.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2         */\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3         \cf11 \strokec11 if\cf6 \strokec6 (\cf4 \strokec4 lastToWithdraw \cf6 \strokec6 !=\cf4 \strokec4  recipient\cf6 \strokec6 )\cf4 \strokec4  \cf6 \strokec6 \{\cf4 \cb1 \strokec4 \
\cb3             lastToWithdraw \cf6 \strokec6 =\cf4 \strokec4  recipient\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\cb3         \cf6 \strokec6 \}\cf4 \cb1 \strokec4 \
\
\cb3         \cf2 \strokec2 // Call the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.\cf4 \cb1 \strokec4 \
\cb3         recipient\cf6 \strokec6 .\cf4 \strokec4 transfer\cf6 \strokec6 (\cf4 \strokec4 amount\cf6 \strokec6 );\cf4 \cb1 \strokec4 \
\
\cb3         \cf2 \strokec2 // Set  `lastWithdrawAmount` equal to `amount`\cf4 \cb1 \strokec4 \
\cb3         lastWithdrawAmount \cf6 \strokec6 =\cf4 \strokec4  amount\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\
\cb3         \cf2 \strokec2 // Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance` to reflect the new balance of the contract.\cf4 \cb1 \strokec4 \
\cb3         contractBalance \cf6 \strokec6 =\cf4 \strokec4  \cf5 \strokec5 address\cf6 \strokec6 (\cf12 \strokec12 this\cf6 \strokec6 ).\cf4 \strokec4 balance\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\cb3     \cf6 \strokec6 \}\cf4 \cb1 \strokec4 \
\
\cb3     \cf2 \strokec2 // Define a `public payable` function named `deposit`.\cf4 \cb1 \strokec4 \
\cb3     \cf5 \strokec5 function\cf4 \strokec4  deposit\cf6 \strokec6 ()\cf4 \strokec4  \cf8 \strokec8 public\cf4 \strokec4  \cf8 \strokec8 payable\cf4 \strokec4  \cf6 \strokec6 \{\cf4 \cb1 \strokec4 \
\
\cb3         \cf2 \strokec2 /*\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2         Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance`.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2         */\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3         contractBalance \cf6 \strokec6 =\cf4 \strokec4  \cf5 \strokec5 address\cf6 \strokec6 (\cf12 \strokec12 this\cf6 \strokec6 ).\cf4 \strokec4 balance\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\cb3     \cf6 \strokec6 \}\cf4 \cb1 \strokec4 \
\
\cb3     \cf2 \strokec2 /*\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2     Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2     */\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3     \cf5 \strokec5 function\cf4 \strokec4  setAccounts\cf6 \strokec6 (\cf5 \strokec5 address\cf4 \strokec4  \cf8 \strokec8 payable\cf4 \strokec4  account1\cf6 \strokec6 ,\cf4 \strokec4  \cf5 \strokec5 address\cf4 \strokec4  \cf8 \strokec8 payable\cf4 \strokec4  account2\cf6 \strokec6 )\cf4 \strokec4  \cf8 \strokec8 public\cf6 \strokec6 \{\cf4 \cb1 \strokec4 \
\
\cb3         \cf2 \strokec2 // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.\cf4 \cb1 \strokec4 \
\cb3         accountOne \cf6 \strokec6 =\cf4 \strokec4  account1\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\cb3         accountTwo \cf6 \strokec6 =\cf4 \strokec4  account2\cf6 \strokec6 ;\cf4 \cb1 \strokec4 \
\cb3     \cf6 \strokec6 \}\cf4 \cb1 \strokec4 \
\
\cb3     \cf2 \strokec2 /*\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \strokec2     Finally, add the **default fallback function** so that your contract can store Ether sent from outside the deposit function.\cf4 \cb1 \strokec4 \
\cf2 \cb3 \strokec2     */\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf4 \cb3     \cf5 \strokec5 function\cf6 \strokec6 ()\cf4 \strokec4  \cf8 \strokec8 external\cf4 \strokec4  \cf8 \strokec8 payable\cf4 \strokec4  \cf6 \strokec6 \{\}\cf4 \cb1 \strokec4 \
\pard\pardeftab720\partightenfactor0
\cf6 \cb3 \strokec6 \}\cf4 \cb1 \strokec4 \
\
}