<<<<<<< HEAD
	private int bankPort;
	private String address;
	
	public Bank() {
		// default constructor
		// default port = 3000
		// default address = "127.0.0.1"
		
		this(3000, "127.0.0.1");
	}
	
	public Bank(int bankPort, String address) {
		// Bank constructor
		this.bankPort = bankPort;
		this.address = address;
		
		// TODO: set up network connection
		// TODO: set up protocal state
		// TODO: set up auth file
	}
	
	public static void main(String[] args) {
		// random testing
		Bank chaseBank = new Bank();
		int chaseBankPort = chaseBank.bankPort;
		String chaseBankAddr = chaseBank.address;
		
		System.out.println("Chase Bank@" + chaseBankAddr + ":" + chaseBankPort);
		chaseBank.sendData("test", "test".length());
		chaseBank.getData("test", "test".length());
		chaseBank.processCMD("test", "test".length());
		
		// wait for CMD from ATMs
		while (true) {
			// TODO:
			
		}
	}
	
	/**
	 * Send data to ATMs
	 * 
	 * @param data
	 * @param length
	 * @return
	 */
	
	public int sendData(String data, int length) {
		// TODO: 
		System.out.println("Sent Message: " + data + "(" + length + " bytes).\n");
		return 0;
	}
	
	/**
	 * Receive data from ATMs
	 * 
	 * @param data
	 * @param length
	 * @return
	 */
	public int getData(String data, int length) {
		// TODO: 
		final int MAX_LENGTH = 1000;
		if (length > MAX_LENGTH) {
			System.out.println("ERROR\n");
			return -1;
		}
		// allow m
		System.out.println("Received Message: " + data + "(" + length + " bytes).\n");
		return 0;
	}
	
	/**
	 * 
	 * @param cmd
	 * @param length
	 */
	public void processCMD(String cmd, int length) {
		// bank side of the ATM-bank protocol
		
		// echo back to ATM
		String echo = "ACK back";
		sendData(echo, echo.length());
		System.out.println("Received CMD: " + cmd + "\n");
		
		// TODO: print out STDOUT in JSON format
		
	}
=======