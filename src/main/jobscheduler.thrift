namespace java com.asksunny.wm.protocol
namespace cpp com.asksunny.wm.protocol
namespace py WM.protocol
namespace perl WM.protocol
namespace ruby WM.protocol


enum Compression{	
	NONE = 0,
	JAR  = 1,
	ZIP = 2,		
	TGZ = 3,
	BZ2 = 4,
}


enum NodeType {		
	WORKER   = 1,
	MANAGER  = 2,
	BOTH = 3,
}


const i32 SHELL =  1,
const i32 PERL =   2,
const i32 PYTHON = 4,
const i32 NATIVE = 8
const i32 JAVA =   16



enum NodeLanguageType {	
	JAVA  = 1,
	PERL   = 2,		
	PYTHON = 2,
	BZ2 = 3,
}


struct NodeInfo
{
	1: required string nodeid,
	2: required string hostAddress,
	3: required string clusterId,
	
	5: required i32 supportedLanguage,
	6: required NodeType nodeType,
	7: required i32 numberOfRunningJob,
	
	10: required i32 numberOfCore,
	12: required i64 totalMemory,
	13: required i64 freeMemory,
	14: required double cpuUsage,
	
}





struct RemoteJob {
	1: required string jobid,
	2: required string executablePath,
	3: required map<string, string> jobData,
	4: required bool suspendible,
	8: required language 
	9: optional binary jobBinary,
	10: optional Compression compression,	
}


struct NodeConfig {
	1: required string workDirectory,
	2: required string tempDirectory,
	3: required map<string, string> nodeContext,	
}


struct JobStatus {
	
}


service WorkloadManager
{
	i64 heartBeat(),	
	
	
	NodeInfo getNodeInfo(),
	/**
	* When worker register with Master/Manager, master send basic configuration info to worker to allow 
	* central control of configuration
	*/
	NodeConfig register(NodeInfo nodeInfo),
	
	
	/**
	*Getting birdeye view of job cluster
	*/
	list<NodeInfo> getClusterInfo(),
	
	
	/**
	*This is used for worker to request job from server.
	*/
	RemoteJob requestForJob(NodeInfo nodeInfo),	
	
	
	/**
	* The follow methods are available in worker node to allow master to assign, cancel and suspend job
	**/
	JobStatus assignJob(RemoteJob jobInfo),
	JobStatus cancelJob(RemoteJob jobInfo),
	JobStatus suspendJob(RemoteJob jobInfo),
	JobStatus status(RemoteJob jobInfo),
		

}