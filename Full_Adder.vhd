----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering USAF Academy
-- Engineer: C3C Eric J. Wardner
-- 
-- Create Date:    22:52:00 02/09/2014 
-- Design Name: 	 4 Bit Full Adder with Carry
-- Module Name:    Full_Adder - Structural
-- Project Name: 	Lab 2
-- Target Devices: Spartan 3 FPGA
-- Tool versions: 
-- Description: Will implement a 4 bit adder with carry and overflow
--
-- Dependencies: 
--
-- Revision: 1.1
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Full_Adder is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           SubSwitch : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (3 downto 0);
           Overflow : out  STD_LOGIC);
end Full_Adder;

architecture Structural of Full_Adder is

COMPONENT Single_Bit_Adder
	Port ( A : in  STD_LOGIC;
          B : in  STD_LOGIC;
          Cin : in  STD_LOGIC;
          Sum : out  STD_LOGIC;
          Cout : out  STD_LOGIC);
	END COMPONENT;
	
COMPONENT subMux
	Port ( Input : in  STD_LOGIC_VECTOR(3 downto 0);
			 Subber : in  STD_LOGIC;
			 O : out  STD_LOGIC_VECTOR(3 downto 0));
END COMPONENT;

signal Cout0, Cout1, Cout2 : STD_LOGIC;
signal Bmuxed : STD_LOGIC_VECTOR(3 downto 0);

begin

	BsubMux: subMux PORT MAP(
		Input => B,
		Subber => SubSwitch,
		O => Bmuxed
	);

	ZeroBit: Single_Bit_Adder PORT MAP(
		A => A(0),
		B => Bmuxed(0),
		Cin => SubSwitch,
		Sum => Sum(0),
		Cout => Cout0
	);
	
	OneBit: Single_Bit_Adder PORT MAP(
		A => A(1),
		B => Bmuxed(1),
		Cin => Cout0,
		Sum => Sum(1),
		Cout => Cout1
	);
	
	TwoBit: Single_Bit_Adder PORT MAP(
		A => A(2),
		B => Bmuxed(2),
		Cin => Cout1,
		Sum => Sum(2),
		Cout => Cout2
	);

	ThreeBit: Single_Bit_Adder PORT MAP(
		A => A(3),
		B => Bmuxed(3),
		Cin => Cout2,
		Sum => Sum(3),
		Cout => Overflow
	);

end Structural;

