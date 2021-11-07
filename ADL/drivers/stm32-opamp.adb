with STM32.SYSCFG;

with Ada.Real_Time; use Ada.Real_Time;

package body STM32.OPAMP is

   ------------
   -- Enable --
   ------------

   procedure Enable (This : in out Operational_Amplifier) is
      use STM32.SYSCFG;
   begin
      --  Enable clock for the SYSCFG_COMP_OPAMP peripheral
      Enable_SYSCFG_Clock;
      --  There is no OPAMP-dedicated clock enable control bit in the RCC
      --  controller. Reset and clock enable bits are common for OPAMP and
      --  SYSCFG. See RM0440 pg 788 chapter 25.3.2.

      This.CSR.OPAEN := True;
   end Enable;

   -------------
   -- Disable --
   -------------

   procedure Disable (This : in out Operational_Amplifier) is
   begin
      This.CSR.OPAEN := False;
   end Disable;

   -------------
   -- Enabled --
   -------------

   function Enabled (This : Operational_Amplifier) return Boolean is
   begin
      return This.CSR.OPAEN;
   end Enabled;

   -----------------------
   -- Set_NI_Input_Mode --
   -----------------------

   procedure Set_NI_Input_Mode
     (This  : in out Operational_Amplifier;
      Input : NI_Input_Mode) is
   begin
      This.CSR.FORCE_VP := Input = Calibration_Mode;
   end Set_NI_Input_Mode;

   ------------------------
   -- Read_NI_Input_Mode --
   ------------------------

   function Read_NI_Input_Mode
     (This : Operational_Amplifier) return NI_Input_Mode is
   begin
      if This.CSR.FORCE_VP = True then
         return Calibration_Mode;
      else
         return Normal_Mode;
      end if;
   end Read_NI_Input_Mode;

   -----------------------
   -- Set_NI_Input_Port --
   -----------------------

   procedure Set_NI_Input_Port
     (This  : in out Operational_Amplifier;
      Input : NI_Input_Port) is
   begin
      This.CSR.VP_SEL := Input'Enum_Rep;
   end Set_NI_Input_Port;

   ------------------------
   -- Read_NI_Input_Port --
   ------------------------

   function Read_NI_Input_Port
     (This : Operational_Amplifier) return NI_Input_Port is
   begin
      return NI_Input_Port'Val (This.CSR.VP_SEL);
   end Read_NI_Input_Port;

   ----------------------
   -- Set_I_Input_Port --
   ----------------------

   procedure Set_I_Input_Port
     (This  : in out Operational_Amplifier;
      Input : I_Input_Port) is
   begin
      This.CSR.VM_SEL := Input'Enum_Rep;
   end Set_I_Input_Port;

   -----------------------
   -- Read_I_Input_Port --
   -----------------------

   function Read_I_Input_Port
     (This : Operational_Amplifier) return I_Input_Port is
   begin
      return I_Input_Port'Val (This.CSR.VM_SEL);
   end Read_I_Input_Port;

   ---------------------------------
   -- Set_NI_Secondary_Input_Port --
   ---------------------------------

   procedure Set_NI_Secondary_Input_Port
     (This  : in out Operational_Amplifier;
      Input : NI_Secondary_Input_Port)
   is
   begin
      This.TCMR.VPS_SEL := Input'Enum_Rep;
   end Set_NI_Secondary_Input_Port;

   ----------------------------------
   -- Read_NI_Secondary_Input_Port --
   ----------------------------------

   function Read_NI_Secondary_Input_Port
     (This : Operational_Amplifier) return NI_Secondary_Input_Port is
   begin
      return NI_Secondary_Input_Port'Val (This.TCMR.VPS_SEL);
   end Read_NI_Secondary_Input_Port;

   --------------------------------
   -- Set_I_Secondary_Input_Port --
   --------------------------------

   procedure Set_I_Secondary_Input_Port
     (This  : in out Operational_Amplifier;
      Input : I_Secondary_Input_Port) is
   begin
      This.TCMR.VMS_SEL := Input = VINM1_Or_Follower_Mode;
   end Set_I_Secondary_Input_Port;

   ---------------------------------
   -- Read_I_Secondary_Input_Port --
   ---------------------------------

   function Read_I_Secondary_Input_Port
     (This : Operational_Amplifier) return I_Secondary_Input_Port is
   begin
      if This.TCMR.VMS_SEL = True then
         return VINM1_Or_Follower_Mode;
      else
         return VINM0_Or_Feedback_Resistor_PGA_Mode;
      end if;
   end Read_I_Secondary_Input_Port;

   ------------------------
   -- Set_Input_Mux_Mode --
   ------------------------

   procedure Set_Input_Mux_Mode
     (This  : in out Operational_Amplifier;
      Timer : Input_Mux_Timer;
      Mode  : Input_Mux_Mode)
   is
   begin
      case Timer is
         when TIM1 =>
            This.TCMR.T1CM_EN := Mode = Automatic;
         when TIM8 =>
            This.TCMR.T8CM_EN := Mode = Automatic;
         when TIM20 =>
            This.TCMR.T20CM_EN := Mode = Automatic;
      end case;
   end Set_Input_Mux_Mode;

   -------------------------
   -- Read_Input_Mux_Mode --
   -------------------------

   function Read_Input_Mux_Mode
     (This : Operational_Amplifier;
      Timer : Input_Mux_Timer)
      return Input_Mux_Mode
   is
   begin
      case Timer is
         when TIM1 =>
            if This.TCMR.T1CM_EN = True then
               return Automatic;
            else
               return Manual;
            end if;
         when TIM8 =>
            if This.TCMR.T8CM_EN = True then
               return Automatic;
            else
               return Manual;
            end if;
         when TIM20 =>
            if This.TCMR.T20CM_EN = True then
               return Automatic;
            else
               return Manual;
            end if;
      end case;
   end Read_Input_Mux_Mode;

   --------------------------
   -- Set_Calibration_Mode --
   --------------------------

   procedure Set_Calibration_Mode
     (This  : in out Operational_Amplifier;
      Input : Calibration_Mode_On) is
   begin
      This.CSR.CALON := Input = Enabled;
   end Set_Calibration_Mode;

   ---------------------------
   -- Read_Calibration_Mode --
   ---------------------------

   function Read_Calibration_Mode
     (This : Operational_Amplifier) return Calibration_Mode_On is
   begin
      if This.CSR.CALON then
         return Enabled;
      else
         return Disabled;
      end if;
   end Read_Calibration_Mode;

   ---------------------------
   -- Set_Calibration_Value --
   ---------------------------

   procedure Set_Calibration_Value
     (This  : in out Operational_Amplifier;
      Input : Calibration_Value) is
   begin
      This.CSR.CALSEL := Input'Enum_Rep;
   end Set_Calibration_Value;

   ----------------------------
   -- Read_Calibration_Value --
   ----------------------------

   function Read_Calibration_Value
     (This : Operational_Amplifier) return Calibration_Value is
   begin
      return Calibration_Value'Val (This.CSR.CALSEL);
   end Read_Calibration_Value;

   -----------------------
   -- Set_PGA_Mode_Gain --
   -----------------------

   procedure Set_PGA_Mode_Gain
     (This  : in out Operational_Amplifier;
      Input : PGA_Mode_Gain) is
   begin
      This.CSR.PGA_GAIN := Input'Enum_Rep;
   end Set_PGA_Mode_Gain;

   ------------------------
   -- Read_PGA_Mode_Gain --
   ------------------------

   function Read_PGA_Mode_Gain
     (This : Operational_Amplifier) return PGA_Mode_Gain is
   begin
      return PGA_Mode_Gain'Val (This.CSR.PGA_GAIN);
   end Read_PGA_Mode_Gain;

   -----------------------
   -- Set_User_Trimming --
   -----------------------

   procedure Set_User_Trimming
     (This  : in out Operational_Amplifier;
      Input : User_Trimming) is
   begin
      This.CSR.USERTRIM := Input = Enabled;
   end Set_User_Trimming;

   ------------------------
   -- Read_User_Trimming --
   ------------------------

   function Read_User_Trimming
     (This : Operational_Amplifier) return User_Trimming is
   begin
      if This.CSR.USERTRIM = True then
         return Enabled;
      else
         return Disabled;
      end if;
   end Read_User_Trimming;

   -------------------------
   -- Set_Offset_Trimming --
   -------------------------

   procedure Set_Offset_Trimming
     (This  : in out Operational_Amplifier;
      Pair  : Differential_Pair;
      Input : UInt5) is
   begin
      if Pair = NMOS then
         This.CSR.TRIMOFFSETN := Input;
      else
         This.CSR.TRIMOFFSETP := Input;
      end if;
   end Set_Offset_Trimming;

   --------------------------
   -- Read_Offset_Trimming --
   --------------------------

   function Read_Offset_Trimming
     (This : Operational_Amplifier;
      Pair : Differential_Pair) return UInt5
   is
   begin
      if Pair = NMOS then
         return This.CSR.TRIMOFFSETN;
      else
         return This.CSR.TRIMOFFSETP;
      end if;
   end Read_Offset_Trimming;

   ---------------
   -- Calibrate --
   ---------------

   procedure Calibrate (This : in out Operational_Amplifier) is

      Trimoffset : UInt5 := 0;
   begin
      --  1. Enable OPAMP by setting the OPAMPxEN bit.
      if not Enabled (This) then
         Enable (This);
      end if;

      --  2. Enable the user offset trimming by setting the USERTRIM bit.
      Set_User_Trimming (This, Input => Enabled);

      --  3. Connect VM and VP to the internal reference voltage by setting
      --  the CALON bit.
      Set_Calibration_Mode (This, Input => Enabled);

      --  4. Set CALSEL to 11 (OPAMP internal reference = 0.9 x VDDA) for NMOS,
      --  Set CALSEL to 01 (OPAMP internal reference = 0.1 x VDDA) for PMOS.
      for Pair in Differential_Pair'Range loop
         if Pair = NMOS then
            Set_Calibration_Value (This, Input => VREFOPAMP_Is_90_VDDA);
         else
            Set_Calibration_Value (This, Input => VREFOPAMP_Is_10_VDDA);
         end if;

         --  5. In a loop, increment the TRIMOFFSETN (for NMOS) or TRIMOFFSETP
         --  (for PMOS) value. To exit from the loop, the OUTCAL bit must be
         --  reset (non-inverting < inverting).
         --  In this case, the TRIMOFFSETN value must be stored.
         Set_Offset_Trimming (This, Pair => Pair, Input => Trimoffset);
         --  Wait the OFFTRIMmax delay timing specified < 1 ms.
         delay until (Clock + Milliseconds (1));

         while Read_Output_Status_Flag (This) = NI_Greater_Then_I loop
            Trimoffset := Trimoffset + 1;
            Set_Offset_Trimming (This, Pair => Pair, Input => Trimoffset);
            --  Wait the OFFTRIMmax delay timing specified < 1 ms.
            delay until (Clock + Milliseconds (1));
         end loop;
      end loop;

   end Calibrate;

   -------------------------
   -- Set_Internal_Output --
   -------------------------

   procedure Set_Internal_Output
     (This  : in out Operational_Amplifier;
      Input : Internal_Output) is
   begin
      This.CSR.OPAINTOEN := Input = Is_Not_Output;
   end Set_Internal_Output;

   --------------------------
   -- Read_Internal_Output --
   --------------------------

   function Read_Internal_Output
     (This : Operational_Amplifier) return Internal_Output is
   begin
      if This.CSR.OPAINTOEN then
         return Is_Not_Output;
      else
         return Is_Output;
      end if;
   end Read_Internal_Output;

   --------------------
   -- Set_Speed_Mode --
   --------------------

   procedure Set_Speed_Mode
     (This  : in out Operational_Amplifier; Input : Speed_Mode) is
   begin
      This.CSR.OPAHSM := Input = HighSpeed_Mode;
   end Set_Speed_Mode;

   ---------------------
   -- Read_Speed_Mode --
   ---------------------

   function Read_Speed_Mode
     (This : Operational_Amplifier) return Speed_Mode is
   begin
      if This.CSR.OPAHSM then
         return HighSpeed_Mode;
      else
         return Normal_Mode;
      end if;
   end Read_Speed_Mode;

   -----------------------------
   -- Read_Output_Status_Flag --
   -----------------------------

   function Read_Output_Status_Flag
     (This : Operational_Amplifier) return Output_Status_Flag is
   begin
      if This.CSR.CALOUT = True then
         return NI_Greater_Then_I;
      else
         return NI_Lesser_Then_I;
      end if;
   end Read_Output_Status_Flag;

   --------------------
   -- Set_Lock_OpAmp --
   --------------------

   procedure Set_Lock_OpAmp (This : in out Operational_Amplifier) is
   begin
      This.CSR.LOCK := True;
      This.TCMR.LOCK := True;
   end Set_Lock_OpAmp;

   ---------------------
   -- Read_Lock_OpAmp --
   ---------------------

   function Read_Lock_OpAmp (This : Operational_Amplifier) return Boolean is
   begin
      return (This.CSR.LOCK or This.TCMR.LOCK);
   end Read_Lock_OpAmp;

end STM32.OPAMP;