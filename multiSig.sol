pragma solidity 0.7.5;


contract MultiSigWallet {
    
    mapping(address => uint)balance; // accessing the balance of the contract
    
    
    // defining the owners as state variables
    address private owner1;
    address private owner2;
    address private owner3;
    
    
    // "console.logs" 
    event submitTx(address sender, address to, uint amount, uint txID);
    event confirmTx(address owner,uint txID);
    event executeTx(address owner,uint txID);
    event depositAdded(address sender,uint amount);
    
    
  
    // object that specifies the criteria for a transaction 
    struct Transaction{
        address payable to;
        address sender; // seeing who initaited the tx
        uint amount;
        uint numberOfConfirmations;
        bool confirmed;
        uint txID;
    }
    
      constructor(uint numberOfConfirmations){
        owner1 = msg.sender;
        owner2 = address(0);
        owner3 = address(1);
        
        numberOfConfirmations = 2;
      }
    
    
    // array of single transactions
    Transaction[] public singleTransactions;
    
     mapping(address => bool)ownerThatConfirmed; // seeing who approved the tx
    
    // the function is only accessable to the owners
    modifier onlyOwners {
        
        require(msg.sender == owner1 || owner2 || owner3,"this addres doesn't have permission");
      _;
        
    }
    
    //check if the tranasction exist already 
    
    modifier txExist(uint txID){
        
        require(txID <= singleTransactions.length, "Transaction doesn't exist");
    }
    
    
    
    
     // anyone can deposit to the contract
    function deposit() public payable returns (uint){
        
        
        balance[msg.sender] += msg.value;
        emit depositAdded(msg.sender,msg.value);
        
        return balance[msg.sender];
        
    }
    
    
    
     //one owner proposes a tx
     // this tx gets pushed into the array of txs
    function submitTx(uint _amount,address _to) public onlyOwners {
        
        Transaction memory newTransaction = singleTransaction(_amount,_to,0,false,SingleTransaction.length);
        
        SingleTransaction.push(newTransaction);
        
        emit submitTx(msg.sender, address to, uint amount, uint txID);
       
        
    }
    
    
    //by calling this the other owners approve the tx
    
    function confirmTx(uint txID) public onlyOwners txExist{
        
    
    
    }
       
        
    // after everyone confirmed, tx is being executed
    function executeTx() public onlyOwners{
        require(numberOfConfirmations > 1,"not enough confirmations for executing the transaction");
        msg.sender.transfer(_amount,_address,numberOfConfirmations);
        
    }
    
     // get final balance after tx executed, everyone can check it
    function getBalance() public  returns (uint) {
        
        return address(this).balance;
    }
    
}