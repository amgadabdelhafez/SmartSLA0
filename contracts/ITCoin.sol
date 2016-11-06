pragma solidity ^0.4.2;
//import "DateTime.sol";
//import "DateTimeAPI.sol";
import "ConvertLib.sol";

contract ITCoin {
	/*enum Priorities {high, medium, low}
	enum Stages {in_progress, canceled, paused, completed, breached}
	enum States {open, assigned, in_progress, resolved, closed}*/

	/*struct TaskRecord {
		bytes32 sys_id;
		address requester;
		string created_on;*/
		/*Priorities taskPriority;
	  States taskState;
		int taskType;
		int timeWorked;
		address assigned_to;
		bool active;
		address updated_by;
		//DateTime created_on;
		DateTime updated_on;
		DateTime closed_on;
	}
*/
/*
	struct SlaRecord {
		bytes32 sys_id;
		Stages stage;
		address assigned_to;
		bool active;
		address updated_by;
		DateTime creted_on;
		DateTime updated_on;
		DateTime closed_on;
		DateTime startTime;	//The time the SLA was started.
		DateTime stopTime;	//The time the SLA ended.
		DateTime breachTime;	//The time the SLA will breach, adjusted for business pause duration (for task SLAs with a schedule specified) or pause duration (for task SLAs with no schedule).
		DateTime ActualElapsedTime;//Time between start time and now (minus pause duration).
		DateTime ActualElapsedPercentage;//Percentage of total SLA that has elapsed (minus pause duration).
		DateTime ActualTimeLeft;//Time remaining until SLA breach.
		/*DateTime BusinessElapsedTime;//Time within the specified schedule between start time and now (minus pause duration).
		DateTime BusinessElapsedPercentage;//Percentage of total SLA that has elapsed within the specified schedule (minus pause duration).
		DateTime BusinessTimeLeft;//Time within the schedule remaining until SLA breach.*/
		//DateTime OriginalBreachTime;//The date/time the SLA would breach, as calculated when the SLA is first attached.
		//}*/
		struct TaskRecord {
			//bytes32 sys_id;
			address requester;
			string created_on;
		}

	mapping (address => uint) balances;
	mapping (bytes32 => TaskRecord) public incidents;
//	mapping (bytes32 => SlaRecord) slas;

	int public numOfIncs;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	function ITCoin() {
		balances[msg.sender] = 10000;
	}

	function newIncident(address _requester, bytes32 _sys_id, string _created) returns(bool success){
		incidents[_sys_id].requester =  _requester ;
		incidents[_sys_id].created_on =  _created ;
		numOfIncs += 1;

		return true;
	}

	function sendCoin(address receiver, uint amount) returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) returns(uint) {
		return balances[addr];
	}
}
