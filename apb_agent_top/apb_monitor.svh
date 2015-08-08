/*****************************************************************
 * Filename: apb_monitor.svh
 * Class Name: apb_monitor
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Get Virtual Interface from ENV Configuration
 *  -> Collect APB Transaction on to AHB-APB Bridge
 * **************************************************************/

class apb_monitor extends uvm_monitor;

	//Factory Registration
	`uvm_component_utils(apb_monitor)

	//Agent Configuration Object
	apb_agent_config cfg_h;

	//Analysis Port
	uvm_analysis_port#(apb_xtn) monitor_ap;

	//Virtual Interface Handle
	virtual apb_if.MON_MP vif;

	//APB Transaction Handle
	apb_xtn xtn;

	//----------------------------------------------
	// Methods
	// ---------------------------------------------
	extern function new(string name = "apb_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass: apb_monitor

//Constructor
function apb_monitor::new(string name = "apb_monitor", uvm_component parent);
	super.new(name, parent);
	monitor_ap = new("monitor_ap", this);
endfunction //new

//Build Phase
function void apb_monitor::build_phase(uvm_phase phase);
	//Get Configuration Object from AHB Agent
	if(!uvm_config_db#(apb_agent_config)::get(this, "", "apb_agent_config", cfg_h))
		`uvm_fatal("APB_MONITOR", "Cannot get vif from APB Agent")

	super.build_phase(phase);
endfunction //build_phase

//Connect Phase
function void apb_monitor::connect_phase(uvm_phase phase);
	vif = cfg_h.vif;
endfunction //connect_phase

//End of Elaboration Phase
function void apb_monitor::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("APB_MONITOR", {get_full_name(), " Created.."}, UVM_MEDIUM);
endfunction //end_of_elaboration

