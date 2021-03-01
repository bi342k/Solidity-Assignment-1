pragma solidity >=0.4.0 <0.8.0;

contract StudentEnroll{
    uint8 private studentCount;
    address payable public owner;
    enum Register {Online, Onsite}
    enum Gender {Male,Female}
    bool Qual = true;
    struct student{
        string Name;
        string fName;
        string Qualification;
        Register Reg;
        Gender gender;
    }
    mapping (address => student) public enrolStudent;
    address[] public arrayEnrolStudent;
    
    mapping (address => uint) private balance;
    
    event LogDepositMade(address indexed accountAddress, uint amount);
    
        constructor () payable {
        
        studentCount = 1;
        owner = msg.sender;
    }
    
    function AddStudents(address _Address, string memory _Name, string memory _fName, string memory _Qualification, Register _Reg, Gender _Gender) public payable returns(uint){
        require(Register.Onsite >= _Reg, "Only accept 0 or 1");
        require(Gender.Female >=_Gender, "only accept 0 or 1");
        require(msg.value == 2 ether, "2 ether initial enrolling fee required");
        require(keccak256(abi.encodePacked(_Qualification)) == keccak256(abi.encodePacked("BS")), "You can not be enrolled as your qualification is not BS");
        student storage enrStudent = enrolStudent[_Address];
        enrStudent.Name = _Name;
        enrStudent.fName = _fName;
        enrStudent.Qualification = _Qualification;
        enrStudent.Reg = _Reg;
        enrStudent.gender = _Gender;
        arrayEnrolStudent.push(_Address);
        studentCount += studentCount;
        
        owner.transfer(msg.value);
        balance[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balance[msg.sender];
    }
    
    function CountStudent() public view returns (uint8){
        
        return studentCount;
    }

    function getBalance() public view returns(uint){
        return owner.balance;
    }
    function getAddress() public view returns(address){
        return owner;
    }
  
}


