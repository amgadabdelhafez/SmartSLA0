pragma solidity ^0.4.2;
import "HelperLib.sol";

contract PayNowAlpha {
	/*

	enum Stages {in_progress, canceled, paused, completed, breached};
*/
/*
//Incident_Data_Structure
var work_duration; \\[Label] Actual duration [type] glide_duration Description The actual length of time (from start time to end time) of work on the planned task, to be compared with the Planned duration.
var work_effort; \\[Label] Actual effort [type] glide_duration Description The actual time spent working, to be compared to the Planned effort.
var critical_path; \\[Label] Critical Path [type] boolean Description
var cost; \\[Label] Estimated cost [type] currency Description An estimation of the cost of the planned task, to be compared with the actual cost.
var html_description; \\[Label] HTML Description [type] html Description A description field that accepts HTML mark-up.
var percent_complete; \\[Label] Percent Complete [type] decimal Description A percentage of the completed effort. Generated using the Planned effort and Actual effort fields.
var duration; \\[Label] Planned duration [type] glide_duration Description The estimated length of time (from start time to end time) of the planned task.
var effort; \\[Label] Planned effort [type] glide_duration Description The estimated amount of time spent working on the planned task.
var end_date; \\[Label] Planned end date [type] glide_date_time Description The estimated date and time for the planned task to end.
var start_date; \\[Label] Planned start date [type] glide_date_time Description The estimated date and time for the planned task to start.
var remaining_duration; \\[Label] Remaining duration [type] glide_duration Description The difference in planned and actual duration, representing the time left for the planned task.
var remaining_effort; \\[Label] Remaining effort [type] glide_duration Description The difference in planned and actual effort, representing the amount of work time left for the planned task.
var rollup; \\[Label] Rollup [type] boolean Description Read-only field managed by the system that identifies the task as having child tasks. A rollup task will have a number of its fields calculated from the children so those fields will be read-only.
var time_constraint; \\[Label] Time constraint [type] string Description A description of time constraints that apply to the planned task.
var top_task; \\[Label] Top Task [type] reference (planned_task) Description When different planned tasks are stacked in a hierarchy, this field populates with the highest-level parent task. For example, if Project A has a child Project B, and Project B has a child Project C, then Project C's Top Task is Project A. Project A's Top Taskfield will be blank.
/*

	/*
	struct TaskRecord {
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
		//}

		//Incident Record Data structure
		struct incidentRecord {
			//string sys_id;//incident sys_id in servicenow
			address requester;//requester address (mapped to user sys_id in servicenow)
		//bytes32 priority;//incidnet priority
			string currentState;//incidet current state
			uint stateUpdatedOn;//state last update timestamp
			string incidetCreatedOn;//incidnet creation timestamp
			uint stateChangesCounter;//incident state changes
			//string incidetUpdatedOn;//incidnet last update timestamp
			mapping (uint => string) previousStates;//array of states mapped to timestamps
		}

	mapping (address => uint) balances;
	mapping (bytes32 => incidentRecord) public incidents;

	//	mapping (bytes32 => SlaRecord) slas;

	uint public numOfIncs;

	//create a new incidnet
	function createIncident(address _requester, bytes32 _sys_id, string _created) returns(bool success){
		incidents[_sys_id].requester = _requester;
		incidents[_sys_id].incidetCreatedOn = _created;
		incidents[_sys_id].currentState = "open";
		numOfIncs += 1;

		return true;
	}

	//update an open incidnet
	function updateIncidentState(bytes32 _sys_id, string _newState) returns(bool success){
		incidents[_sys_id].stateChangesCounter += 1;
		incidents[_sys_id].previousStates[incidents[_sys_id].stateChangesCounter] = incidents[_sys_id].currentState;
		incidents[_sys_id].currentState = _newState;
		incidents[_sys_id].stateUpdatedOn = now;
		return true;
	}

	//read number of open incidnets
	function readOpenIncidents() constant returns(uint) {
		return numOfIncs;
	}

	//read an open incidnet state
	function readIncidentState(bytes32 _sys_id) constant returns(string ) {
		return incidents[_sys_id].currentState;
	}

	//read an open incidnet timestamp
	function readIncidentCreatedOn(bytes32 _sys_id) constant returns(string) {
		return incidents[_sys_id].incidetCreatedOn;
	}
	//read an open incidnet timestamp
	function readIncUpdatedOn(bytes32 _sys_id) constant returns(uint) {
		return incidents[_sys_id].stateUpdatedOn;
	}

}
