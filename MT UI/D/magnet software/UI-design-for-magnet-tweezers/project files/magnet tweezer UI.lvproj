<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="17008000">
	<Item Name="我的电脑" Type="My Computer">
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">我的电脑/VI服务器</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">我的电脑/VI服务器</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="UI-design-for-magnet-tweezers" Type="Folder">
			<Item Name="controls" Type="Folder">
				<Item Name="bead-center-x-correlation-simple-sum-v2.ctl" Type="VI" URL="../magnet software/UI-design-for-magnet-tweezers/bead-center-x-correlation-simple-sum-v2.ctl"/>
				<Item Name="display queue cluster.ctl" Type="VI" URL="../../display queue cluster.ctl"/>
				<Item Name="magnet_tweezers_命令.ctl" Type="VI" URL="../../magnet_tweezers_命令.ctl"/>
				<Item Name="parameter for radial profile.ctl" Type="VI" URL="../magnet software/UI-design-for-magnet-tweezers/parameter for radial profile.ctl"/>
				<Item Name="parameter set for calibration.ctl" Type="VI" URL="../../parameter set for calibration.ctl"/>
				<Item Name="parameter set for record.ctl" Type="VI" URL="../../parameter set for record.ctl"/>
				<Item Name="QI state.ctl" Type="VI" URL="../../QI state.ctl"/>
				<Item Name="QI 传递变量.ctl" Type="VI" URL="../../QI 传递变量.ctl"/>
				<Item Name="前面板命令.ctl" Type="VI" URL="../../前面板命令.ctl"/>
				<Item Name="数据分析命令集.ctl" Type="VI" URL="../../数据分析命令集.ctl"/>
				<Item Name="magnet control.ctl" Type="VI" URL="../../device control/magnet control.ctl"/>
				<Item Name="velocity set control.ctl" Type="VI" URL="../../velocity set control.ctl"/>
				<Item Name="bead info.ctl" Type="VI" URL="../../control/bead info.ctl"/>
				<Item Name="Bead track.ctl" Type="VI" URL="../../control/Bead track.ctl"/>
				<Item Name="ROI info.ctl" Type="VI" URL="../../vision test/ROI info.ctl"/>
				<Item Name="磁铁进程控制变量.ctl" Type="VI" URL="../../磁铁进程控制变量.ctl"/>
				<Item Name="Bead info action.ctl" Type="VI" URL="../../control/Bead info action.ctl"/>
				<Item Name="beads public.ctl" Type="VI" URL="../../control/beads public.ctl"/>
				<Item Name="record mode.ctl" Type="VI" URL="../../control/record mode.ctl"/>
			</Item>
			<Item Name="debug" Type="Folder">
				<Item Name="centroid offset.vi" Type="VI" URL="../magnet software/UI-design-for-magnet-tweezers/device control/centroid offset.vi"/>
			</Item>
			<Item Name="global" Type="Folder">
				<Item Name="CCD demand.vi" Type="VI" URL="../../vision test/CCD demand.vi"/>
			</Item>
			<Item Name="menu" Type="Folder">
				<Item Name="magnet_menu.rtm" Type="Document" URL="../magnet software/UI-design-for-magnet-tweezers/magnet_menu.rtm"/>
			</Item>
			<Item Name="modules" Type="Folder">
				<Item Name="Cali" Type="Folder">
					<Item Name="dialog_box for calibration.vi" Type="VI" URL="../../dialog_box for calibration.vi"/>
					<Item Name="cali_array upside down.vi" Type="VI" URL="../../cali_array upside down.vi"/>
					<Item Name="cali_building LUT.vi" Type="VI" URL="../../cali_building LUT.vi"/>
					<Item Name="cali_write cali array.vi" Type="VI" URL="../../cali_write cali array.vi"/>
					<Item Name="cali_interpolation.vi" Type="VI" URL="../../cali_interpolation.vi"/>
				</Item>
				<Item Name="tracking" Type="Folder">
					<Item Name="centroid_light field correction.vi" Type="VI" URL="../centroid_light field correction.vi"/>
					<Item Name="extract ROI.vi" Type="VI" URL="../../vision test/extract ROI.vi"/>
					<Item Name="add ROI module.vi" Type="VI" URL="../../vision test/add ROI module.vi"/>
					<Item Name="label ROI.vi" Type="VI" URL="../../label ROI.vi"/>
					<Item Name="modify ROI when tracking.vi" Type="VI" URL="../../modify ROI when tracking.vi"/>
					<Item Name="add ROI element.vi" Type="VI" URL="../../vision test/add ROI element.vi"/>
					<Item Name="QI radial profile calculate_new.vi" Type="VI" URL="../../QI radial profile calculate_new.vi"/>
					<Item Name="QI_correlation_X.vi" Type="VI" URL="../../QI_correlation_X.vi"/>
					<Item Name="QI_correlation_Y.vi" Type="VI" URL="../../QI_correlation_Y.vi"/>
					<Item Name="QI_proto.vi" Type="VI" URL="../../QI_proto.vi"/>
					<Item Name="QI_radial profile_new.vi" Type="VI" URL="../../QI_radial profile_new.vi"/>
					<Item Name="QI_radial profile normalization.vi" Type="VI" URL="../../QI_radial profile normalization.vi"/>
					<Item Name="lightfield normalization.vi" Type="VI" URL="../../lightfield normalization.vi"/>
					<Item Name="HXG_radial profile_new.vi" Type="VI" URL="../../HXG_radial profile_new.vi"/>
					<Item Name="modify ROI without transform.vi" Type="VI" URL="../../tracking/modify ROI without transform.vi"/>
					<Item Name="extract ROI image.vi" Type="VI" URL="../../tracking/extract ROI image.vi"/>
				</Item>
				<Item Name="Record" Type="Folder">
					<Item Name="Rec_organize data.vi" Type="VI" URL="../../Rec_organize data.vi"/>
					<Item Name="Rec_export one bead XYZ.vi" Type="VI" URL="../../Rec_export one bead XYZ.vi"/>
					<Item Name="Rec_configure tdms.vi" Type="VI" URL="../../Rec_configure tdms.vi"/>
					<Item Name="Rec_set dialog.vi" Type="VI" URL="../../Rec_set dialog.vi"/>
					<Item Name="Rec_calculate Z.vi" Type="VI" URL="../../Rec_calculate Z.vi"/>
					<Item Name="REC_wait.vi" Type="VI" URL="../../REC_wait.vi"/>
					<Item Name="REC_magnet move program.vi" Type="VI" URL="../../REC_magnet move program.vi"/>
					<Item Name="Rec_config magnet move program.vi" Type="VI" URL="../../Rec_config magnet move program.vi"/>
					<Item Name="Zmag to F.vi" Type="VI" URL="../../Zmag to F.vi"/>
					<Item Name="FR generate zmag.vi" Type="VI" URL="../../FR generate zmag.vi"/>
					<Item Name="F to Zmag.vi" Type="VI" URL="../../F to Zmag.vi"/>
					<Item Name="ROC_file_split.vi" Type="VI" URL="../../ROC_file_split.vi"/>
					<Item Name="Rec_calculate Z_2.vi" Type="VI" URL="../../tracking/Rec_calculate Z_2.vi"/>
					<Item Name="Rec_organize data_2.vi" Type="VI" URL="../../tracking/Rec_organize data_2.vi"/>
				</Item>
				<Item Name="device control" Type="Folder">
					<Item Name="CCD 多线程尝试.vi" Type="VI" URL="../../device control/CCD 多线程尝试.vi"/>
					<Item Name="comunication break.vi" Type="VI" URL="../../device control/comunication break.vi"/>
					<Item Name="device index.ctl" Type="VI" URL="../../device control/device index.ctl"/>
					<Item Name="device setup.vi" Type="VI" URL="../../device control/device setup.vi"/>
					<Item Name="labview setup procedure.ctl" Type="VI" URL="../../device control/labview setup procedure.ctl"/>
					<Item Name="motor control proto.vi" Type="VI" URL="../../device control/motor control proto.vi"/>
					<Item Name="motor control.ctl" Type="VI" URL="../../device control/motor control.ctl"/>
					<Item Name="motor_move_piezo.vi" Type="VI" URL="../../device control/motor_move_piezo.vi"/>
					<Item Name="motor_move_position.vi" Type="VI" URL="../../device control/motor_move_position.vi"/>
					<Item Name="motor_move_rotate.vi" Type="VI" URL="../../device control/motor_move_rotate.vi"/>
					<Item Name="move complete.vi" Type="VI" URL="../../device control/move complete.vi"/>
					<Item Name="rotate complete.vi" Type="VI" URL="../../device control/rotate complete.vi"/>
					<Item Name="setup_for_move.vi" Type="VI" URL="../../device control/setup_for_move.vi"/>
					<Item Name="setup_for_rot.vi" Type="VI" URL="../../device control/setup_for_rot.vi"/>
					<Item Name="vision acquisition 范例.vi" Type="VI" URL="../../device control/vision acquisition 范例.vi"/>
					<Item Name="多电机同时初始化.vi" Type="VI" URL="../../device control/多电机同时初始化.vi"/>
					<Item Name="仪器初始化proto.vi" Type="VI" URL="../../device control/仪器初始化proto.vi"/>
					<Item Name="仪器连通测试VI.vi" Type="VI" URL="../../device control/仪器连通测试VI.vi"/>
				</Item>
				<Item Name="data analysis for MT" Type="Folder">
					<Item Name="FitPSD" Type="Folder">
						<Item Name="AnalyticalPSD.vi" Type="VI" URL="../../data analysis module/data analysis for MT/FitPSD.llb/AnalyticalPSD.vi"/>
						<Item Name="FitErrors.vi" Type="VI" URL="../../data analysis module/data analysis for MT/FitPSD.llb/FitErrors.vi"/>
						<Item Name="FitFunc_Lorentz.vi" Type="VI" URL="../../data analysis module/data analysis for MT/FitPSD.llb/FitFunc_Lorentz.vi"/>
						<Item Name="FitFunc_LorentzCoupled.vi" Type="VI" URL="../../data analysis module/data analysis for MT/FitPSD.llb/FitFunc_LorentzCoupled.vi"/>
						<Item Name="PSD-Fit.vi" Type="VI" URL="../../data analysis module/data analysis for MT/FitPSD.llb/PSD-Fit.vi"/>
						<Item Name="Show Error Message.vi" Type="VI" URL="../../data analysis module/data analysis for MT/FitPSD.llb/Show Error Message.vi"/>
						<Item Name="TruncateFitArrays.vi" Type="VI" URL="../../data analysis module/data analysis for MT/FitPSD.llb/TruncateFitArrays.vi"/>
					</Item>
					<Item Name="choose a trajectory.vi" Type="VI" URL="../../data analysis module/data analysis for MT/choose a trajectory.vi"/>
					<Item Name="extract xyz segment with cursors.vi" Type="VI" URL="../../data analysis module/data analysis for MT/extract xyz segment with cursors.vi"/>
					<Item Name="leakage protection.vi" Type="VI" URL="../../data analysis module/data analysis for MT/leakage protection.vi"/>
					<Item Name="PSD fitting.vi" Type="VI" URL="../../data analysis module/data analysis for MT/PSD fitting.vi"/>
					<Item Name="wave to DBL matrix.vi" Type="VI" URL="../../data analysis module/data analysis for MT/wave to DBL matrix.vi"/>
					<Item Name="Y data to Force extension.vi" Type="VI" URL="../../data analysis module/data analysis for MT/Y data to Force extension.vi"/>
				</Item>
				<Item Name="cuda" Type="Folder">
					<Item Name="extract ROI CUDA.vi" Type="VI" URL="../../cuda/extract ROI CUDA.vi"/>
					<Item Name="UI trackingXY CUDA2.vi" Type="VI" URL="../../cuda/UI trackingXY CUDA2.vi"/>
					<Item Name="calculate Z CUDA.vi" Type="VI" URL="../../cuda/calculate Z CUDA.vi"/>
					<Item Name="dll_cuda_v2_80.vi" Type="VI" URL="../../cuda/dll_cuda_v2_80.vi"/>
				</Item>
				<Item Name="界面设计.vi" Type="VI" URL="../magnet software/UI-design-for-magnet-tweezers/界面设计.vi"/>
				<Item Name="良好风格模板VI.vi" Type="VI" URL="../magnet software/UI-design-for-magnet-tweezers/良好风格模板VI.vi"/>
				<Item Name="warning tone.vi" Type="VI" URL="../../warning tone.vi"/>
				<Item Name="ROI info.vi" Type="VI" URL="../../control/ROI info.vi"/>
			</Item>
			<Item Name="GCSMergedLabVIEW" Type="Folder">
				<Item Name="Backup" Type="Folder">
					<Item Name="GCS_LabVIEW_E-709_2017_7_10__22_37_37.zip" Type="Document" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Backup/GCS_LabVIEW_E-709_2017_7_10__22_37_37.zip"/>
					<Item Name="GCS_LabVIEW_Mercury_2017_7_10__22_37_36.zip" Type="Document" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Backup/GCS_LabVIEW_Mercury_2017_7_10__22_37_36.zip"/>
				</Item>
				<Item Name="Low Level" Type="Folder">
					<Item Name="Analog control" Type="Folder">
						<Item Name="Analog FGlobal.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Analog control.llb/Analog FGlobal.vi"/>
						<Item Name="Analog Functions.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Analog control.llb/Analog Functions.vi"/>
						<Item Name="Analog Receive String.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Analog control.llb/Analog Receive String.vi"/>
						<Item Name="Available Analog Commands.ctl" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Analog control.llb/Available Analog Commands.ctl"/>
						<Item Name="Global Analog.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Analog control.llb/Global Analog.vi"/>
					</Item>
					<Item Name="Communication" Type="Folder">
						<Item Name="Available DLL interfaces.ctl" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Available DLL interfaces.ctl"/>
						<Item Name="Available DLLs.ctl" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Available DLLs.ctl"/>
						<Item Name="Available interfaces.ctl" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Available interfaces.ctl"/>
						<Item Name="Close connection if open.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Close connection if open.vi"/>
						<Item Name="Find baudrate.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Find baudrate.vi"/>
						<Item Name="GCSTranslator DLL Functions.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/GCSTranslator DLL Functions.vi"/>
						<Item Name="Global DaisyChain.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Global DaisyChain.vi"/>
						<Item Name="Global1.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Global1.vi"/>
						<Item Name="IFC.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/IFC.vi"/>
						<Item Name="IFC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/IFC?.vi"/>
						<Item Name="IFS.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/IFS.vi"/>
						<Item Name="IFS?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/IFS?.vi"/>
						<Item Name="Initialize Global DaisyChain.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Initialize Global DaisyChain.vi"/>
						<Item Name="Initialize Global1.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Initialize Global1.vi"/>
						<Item Name="Is DaisyChain open.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Is DaisyChain open.vi"/>
						<Item Name="PI Ask for Communication Parameters.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/PI Ask for Communication Parameters.vi"/>
						<Item Name="PI Open Interface of one system.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/PI Open Interface of one system.vi"/>
						<Item Name="PI Open Interface.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/PI Open Interface.vi"/>
						<Item Name="PI Receive String.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/PI Receive String.vi"/>
						<Item Name="PI Send String.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/PI Send String.vi"/>
						<Item Name="PI VISA Receive Characters.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/PI VISA Receive Characters.vi"/>
						<Item Name="Select DaisyChain device.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Select DaisyChain device.vi"/>
						<Item Name="Select USB device.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Select USB device.vi"/>
						<Item Name="Set logging mode.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Set logging mode.vi"/>
						<Item Name="Syntax.ctl" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Syntax.ctl"/>
						<Item Name="Termination character.ctl" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Communication.llb/Termination character.ctl"/>
					</Item>
					<Item Name="File handling" Type="Folder">
						<Item Name="ArrayFile.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/File handling.llb/ArrayFile.vi"/>
						<Item Name="File handler.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/File handling.llb/File handler.vi"/>
						<Item Name="GetDataFormat.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/File handling.llb/GetDataFormat.vi"/>
						<Item Name="MatrixIO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/File handling.llb/MatrixIO.vi"/>
						<Item Name="TableIO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/File handling.llb/TableIO.vi"/>
					</Item>
					<Item Name="General command" Type="Folder">
						<Item Name="*IDN?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/*IDN?.vi"/>
						<Item Name="Controller names.ctl" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/Controller names.ctl"/>
						<Item Name="CSV?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/CSV?.vi"/>
						<Item Name="Define connected axes.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/Define connected axes.vi"/>
						<Item Name="Define connected systems (Array).vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/Define connected systems (Array).vi"/>
						<Item Name="ERR?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/ERR?.vi"/>
						<Item Name="Global2 (Array).vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/Global2 (Array).vi"/>
						<Item Name="HLP?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/HLP?.vi"/>
						<Item Name="HLT.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/HLT.vi"/>
						<Item Name="HPA?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/HPA?.vi"/>
						<Item Name="HPV?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/HPV?.vi"/>
						<Item Name="Initialize Global2.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/Initialize Global2.vi"/>
						<Item Name="MAN?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/MAN?.vi"/>
						<Item Name="MOV.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/MOV.vi"/>
						<Item Name="MOV?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/MOV?.vi"/>
						<Item Name="MVR.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/MVR.vi"/>
						<Item Name="MWG.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/MWG.vi"/>
						<Item Name="POS?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/POS?.vi"/>
						<Item Name="SAI?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/SAI?.vi"/>
						<Item Name="SPA.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/SPA.vi"/>
						<Item Name="SPA?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/SPA?.vi"/>
						<Item Name="STP.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/STP.vi"/>
						<Item Name="SVO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/SVO.vi"/>
						<Item Name="SVO?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/SVO?.vi"/>
						<Item Name="VEL.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/VEL.vi"/>
						<Item Name="VER?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/VER?.vi"/>
						<Item Name="VMO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/VMO.vi"/>
					</Item>
					<Item Name="Joystick" Type="Folder">
						<Item Name="Calculate joystick scaling.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/Calculate joystick scaling.vi"/>
						<Item Name="JAS?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/JAS?.vi"/>
						<Item Name="JAX.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/JAX.vi"/>
						<Item Name="JAX?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/JAX?.vi"/>
						<Item Name="JBS?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/JBS?.vi"/>
						<Item Name="JDT.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/JDT.vi"/>
						<Item Name="JLT.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/JLT.vi"/>
						<Item Name="JLT?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/JLT?.vi"/>
						<Item Name="JON.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/JON.vi"/>
						<Item Name="JON?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/JON?.vi"/>
						<Item Name="Read joystick.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/Read joystick.vi"/>
						<Item Name="Scale joystick data.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Joystick.llb/Scale joystick data.vi"/>
					</Item>
					<Item Name="Limits" Type="Folder">
						<Item Name="ATZ.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/ATZ.vi"/>
						<Item Name="ATZ?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/ATZ?.vi"/>
						<Item Name="DFH.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/DFH.vi"/>
						<Item Name="DFH?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/DFH?.vi"/>
						<Item Name="FED.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/FED.vi"/>
						<Item Name="FPL.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/FPL.vi"/>
						<Item Name="FRF.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/FRF.vi"/>
						<Item Name="FRF?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/FRF?.vi"/>
						<Item Name="GOH.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/GOH.vi"/>
						<Item Name="LIM?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/LIM?.vi"/>
						<Item Name="RON.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/RON.vi"/>
						<Item Name="RON?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/RON?.vi"/>
						<Item Name="TMN?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/TMN?.vi"/>
						<Item Name="TMX?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/TMX?.vi"/>
						<Item Name="TRS?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/TRS?.vi"/>
					</Item>
					<Item Name="Macros" Type="Folder">
						<Item Name="#8.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/#8.vi"/>
						<Item Name="Define macro contents.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/Define macro contents.vi"/>
						<Item Name="MAC BEG.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAC BEG.vi"/>
						<Item Name="MAC DEF.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAC DEF.vi"/>
						<Item Name="MAC DEF?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAC DEF?.vi"/>
						<Item Name="MAC DEL.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAC DEL.vi"/>
						<Item Name="MAC END.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAC END.vi"/>
						<Item Name="MAC ERR?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAC ERR?.vi"/>
						<Item Name="MAC NSTART.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAC NSTART.vi"/>
						<Item Name="MAC START.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAC START.vi"/>
						<Item Name="MAC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAC?.vi"/>
						<Item Name="MAT.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/MAT.vi"/>
						<Item Name="RMC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/RMC?.vi"/>
						<Item Name="VAR.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/VAR.vi"/>
						<Item Name="VAR?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Macros.llb/VAR?.vi"/>
					</Item>
					<Item Name="Old commands" Type="Folder">
						<Item Name="#5_old.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Old commands.llb/#5_old.vi"/>
						<Item Name="Wait for hexapod system axes to stop.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Old commands.llb/Wait for hexapod system axes to stop.vi"/>
					</Item>
					<Item Name="Optical or Analog Input" Type="Folder">
						<Item Name="MOV and TAV?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Optical or Analog Input.llb/MOV and TAV?.vi"/>
						<Item Name="MWG and TAV?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Optical or Analog Input.llb/MWG and TAV?.vi"/>
						<Item Name="TAC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Optical or Analog Input.llb/TAC?.vi"/>
						<Item Name="TAD?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Optical or Analog Input.llb/TAD?.vi"/>
						<Item Name="TAV?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Optical or Analog Input.llb/TAV?.vi"/>
						<Item Name="TNS?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Optical or Analog Input.llb/TNS?.vi"/>
						<Item Name="TSC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Optical or Analog Input.llb/TSC?.vi"/>
						<Item Name="TSP.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Optical or Analog Input.llb/TSP.vi"/>
						<Item Name="TSP?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Optical or Analog Input.llb/TSP?.vi"/>
					</Item>
					<Item Name="PZT voltage" Type="Folder">
						<Item Name="OVF?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/PZT voltage.llb/OVF?.vi"/>
						<Item Name="SVA.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/PZT voltage.llb/SVA.vi"/>
						<Item Name="SVA?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/PZT voltage.llb/SVA?.vi"/>
						<Item Name="SVR.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/PZT voltage.llb/SVR.vi"/>
						<Item Name="VCO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/PZT voltage.llb/VCO.vi"/>
						<Item Name="VCO?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/PZT voltage.llb/VCO?.vi"/>
						<Item Name="VOL.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/PZT voltage.llb/VOL.vi"/>
						<Item Name="VOL?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/PZT voltage.llb/VOL?.vi"/>
					</Item>
					<Item Name="Scan support" Type="Folder">
						<Item Name="Axis names.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Scan support.llb/Axis names.vi"/>
						<Item Name="Calculate 1D scan positions.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Scan support.llb/Calculate 1D scan positions.vi"/>
						<Item Name="Maximum Intensity?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Scan support.llb/Maximum Intensity?.vi"/>
					</Item>
					<Item Name="Special command" Type="Folder">
						<Item Name="#24.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/#24.vi"/>
						<Item Name="#4.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/#4.vi"/>
						<Item Name="#5.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/#5.vi"/>
						<Item Name="#6.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/#6.vi"/>
						<Item Name="#7.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/#7.vi"/>
						<Item Name="ACC.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/ACC.vi"/>
						<Item Name="ACC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/ACC?.vi"/>
						<Item Name="AOS.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/AOS.vi"/>
						<Item Name="AOS?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/AOS?.vi"/>
						<Item Name="BRA.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/BRA.vi"/>
						<Item Name="BRA?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/BRA?.vi"/>
						<Item Name="CCL.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/CCL.vi"/>
						<Item Name="CCL?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/CCL?.vi"/>
						<Item Name="CST.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/CST.vi"/>
						<Item Name="CST?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/CST?.vi"/>
						<Item Name="CTI.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/CTI.vi"/>
						<Item Name="CTI?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/CTI?.vi"/>
						<Item Name="CTO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/CTO.vi"/>
						<Item Name="CTO?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/CTO?.vi"/>
						<Item Name="DEC.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DEC.vi"/>
						<Item Name="DEC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DEC?.vi"/>
						<Item Name="DIO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DIO.vi"/>
						<Item Name="DIO?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DIO?.vi"/>
						<Item Name="DRC.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DRC.vi"/>
						<Item Name="DRC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DRC?.vi"/>
						<Item Name="DRL?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DRL?.vi"/>
						<Item Name="DRR? and display data.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DRR? and display data.vi"/>
						<Item Name="DRR?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DRR?.vi"/>
						<Item Name="DRT.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DRT.vi"/>
						<Item Name="DRT?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/DRT?.vi"/>
						<Item Name="HDR?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/HDR?.vi"/>
						<Item Name="IMP.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/IMP.vi"/>
						<Item Name="IMP?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/IMP?.vi"/>
						<Item Name="MVE.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/MVE.vi"/>
						<Item Name="RBT.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/RBT.vi"/>
						<Item Name="RPA.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/RPA.vi"/>
						<Item Name="RTR.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/RTR.vi"/>
						<Item Name="RTR?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/RTR?.vi"/>
						<Item Name="SAI.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/SAI.vi"/>
						<Item Name="SEP.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/SEP.vi"/>
						<Item Name="SEP?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/SEP?.vi"/>
						<Item Name="SMO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/SMO.vi"/>
						<Item Name="SMO?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/SMO?.vi"/>
						<Item Name="SRG?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/SRG?.vi"/>
						<Item Name="SSN?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/SSN?.vi"/>
						<Item Name="SST.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/SST.vi"/>
						<Item Name="SST?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/SST?.vi"/>
						<Item Name="STA?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/STA?.vi"/>
						<Item Name="STE.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/STE.vi"/>
						<Item Name="STE?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/STE?.vi"/>
						<Item Name="TCV?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/TCV?.vi"/>
						<Item Name="TIO?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/TIO?.vi"/>
						<Item Name="TNR?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/TNR?.vi"/>
						<Item Name="TPC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/TPC?.vi"/>
						<Item Name="TRI.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/TRI.vi"/>
						<Item Name="TRI?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/TRI?.vi"/>
						<Item Name="TRO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/TRO.vi"/>
						<Item Name="TRO?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/TRO?.vi"/>
						<Item Name="TVI?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/TVI?.vi"/>
						<Item Name="VST?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/VST?.vi"/>
						<Item Name="WPA.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/WPA.vi"/>
					</Item>
					<Item Name="Support" Type="Folder">
						<Item Name="Analyse input string for terminal.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Analyse input string for terminal.vi"/>
						<Item Name="Assign booleans from string to axes.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Assign booleans from string to axes.vi"/>
						<Item Name="Assign DRC values.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Assign DRC values.vi"/>
						<Item Name="Assign DRT values from string.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Assign DRT values from string.vi"/>
						<Item Name="Assign NaN for chosen axes.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Assign NaN for chosen axes.vi"/>
						<Item Name="Assign SPA values from string to axes.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Assign SPA values from string to axes.vi"/>
						<Item Name="Assign values from string to axes.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Assign values from string to axes.vi"/>
						<Item Name="Boolean array calculations.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Boolean array calculations.vi"/>
						<Item Name="Build channel query command substring.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Build channel query command substring.vi"/>
						<Item Name="Build command substring.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Build command substring.vi"/>
						<Item Name="Build DIO? query command substring.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Build DIO? query command substring.vi"/>
						<Item Name="Build num command substring.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Build num command substring.vi"/>
						<Item Name="Build query command substring.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Build query command substring.vi"/>
						<Item Name="Build SPA command substring.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Build SPA command substring.vi"/>
						<Item Name="Build SPA query command substring.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Build SPA query command substring.vi"/>
						<Item Name="Build stringplusnum substring.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Build stringplusnum substring.vi"/>
						<Item Name="Build WAV command substring.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Build WAV command substring.vi"/>
						<Item Name="Combine axes arrays.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Combine axes arrays.vi"/>
						<Item Name="Commanded axes connected?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Commanded axes connected?.vi"/>
						<Item Name="Commanded stage name available?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Commanded stage name available?.vi"/>
						<Item Name="Convert error to warning.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Convert error to warning.vi"/>
						<Item Name="Convert num array to string.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Convert num array to string.vi"/>
						<Item Name="Convert num value to syntax selection.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Convert num value to syntax selection.vi"/>
						<Item Name="Count occurrences in string.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Count occurrences in string.vi"/>
						<Item Name="Cut out additional spaces.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Cut out additional spaces.vi"/>
						<Item Name="Define axes to command from boolean array.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Define axes to command from boolean array.vi"/>
						<Item Name="GCSTranslateError.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/GCSTranslateError.vi"/>
						<Item Name="General wait for movement to stop.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/General wait for movement to stop.vi"/>
						<Item Name="Get all axes.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Get all axes.vi"/>
						<Item Name="Get arrays without blanks.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Get arrays without blanks.vi"/>
						<Item Name="Get lines and values from string.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Get lines and values from string.vi"/>
						<Item Name="Get lines from string.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Get lines from string.vi"/>
						<Item Name="Get string array size without blanks.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Get string array size without blanks.vi"/>
						<Item Name="Get total number of commanded axes.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Get total number of commanded axes.vi"/>
						<Item Name="How often does string contain regular expression?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/How often does string contain regular expression?.vi"/>
						<Item Name="Increase array size.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Increase array size.vi"/>
						<Item Name="Is command present in HLP answer?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Is command present in HLP answer?.vi"/>
						<Item Name="Longlasting one-axis command.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Longlasting one-axis command.vi"/>
						<Item Name="Return single characters from string.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Return single characters from string.vi"/>
						<Item Name="Return space.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Return space.vi"/>
						<Item Name="Round with options.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Round with options.vi"/>
						<Item Name="Select axis.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Select axis.vi"/>
						<Item Name="Select values for chosen axes.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Select values for chosen axes.vi"/>
						<Item Name="Select with boolean array input.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Select with boolean array input.vi"/>
						<Item Name="Selection to String array.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Selection to String array.vi"/>
						<Item Name="Set RON and return RON status.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Set RON and return RON status.vi"/>
						<Item Name="String with ASCII code conversion.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/String with ASCII code conversion.vi"/>
						<Item Name="Substract axes array subset from axes array.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Substract axes array subset from axes array.vi"/>
						<Item Name="Unbunde/bundle interface clusters for PI Terminal.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Unbunde/bundle interface clusters for PI Terminal.vi"/>
						<Item Name="Wait for answer of longlasting command.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Wait for answer of longlasting command.vi"/>
						<Item Name="Wait for axes to stop.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Wait for axes to stop.vi"/>
						<Item Name="Wait for controller ready.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Support.llb/Wait for controller ready.vi"/>
					</Item>
					<Item Name="WaveGenerator" Type="Folder">
						<Item Name="#9.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/#9.vi"/>
						<Item Name="GWD?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/GWD?.vi"/>
						<Item Name="TWC.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/TWC.vi"/>
						<Item Name="TWG?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/TWG?.vi"/>
						<Item Name="TWS.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/TWS.vi"/>
						<Item Name="WAV.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WAV.vi"/>
						<Item Name="WAV?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WAV?.vi"/>
						<Item Name="WCL.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WCL.vi"/>
						<Item Name="WGC.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WGC.vi"/>
						<Item Name="WGC?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WGC?.vi"/>
						<Item Name="WGI?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WGI?.vi"/>
						<Item Name="WGN?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WGN?.vi"/>
						<Item Name="WGO.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WGO.vi"/>
						<Item Name="WGO?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WGO?.vi"/>
						<Item Name="WGR.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WGR.vi"/>
						<Item Name="WOS.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WOS.vi"/>
						<Item Name="WOS?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WOS?.vi"/>
						<Item Name="WSL.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WSL.vi"/>
						<Item Name="WSL?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WSL?.vi"/>
						<Item Name="WTR.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WTR.vi"/>
						<Item Name="WTR?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/WaveGenerator.llb/WTR?.vi"/>
					</Item>
					<Item Name="GCSTranslator.dll" Type="Document" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/GCSTranslator.dll"/>
					<Item Name="merged.txt" Type="Document" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/merged.txt"/>
				</Item>
				<Item Name="1D Scan.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/1D Scan.vi"/>
				<Item Name="E709_All_VIs.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/E709_All_VIs.vi"/>
				<Item Name="E709_Configuration_Setup.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/E709_Configuration_Setup.vi"/>
				<Item Name="E709_Sample_Application_1.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/E709_Sample_Application_1.vi"/>
				<Item Name="E709_Sample_Application_2a.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/E709_Sample_Application_2a.vi"/>
				<Item Name="E709_Sample_Application_With_Analog.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/E709_Sample_Application_With_Analog.vi"/>
				<Item Name="E709_Simple_Test.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/E709_Simple_Test.vi"/>
				<Item Name="Joystick_Operation.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Joystick_Operation.vi"/>
				<Item Name="Mercury_GCS_All_VIs.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Mercury_GCS_All_VIs.vi"/>
				<Item Name="Mercury_GCS_Sample_Application_1.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Mercury_GCS_Sample_Application_1.vi"/>
				<Item Name="Mercury_GCS_Sample_Application_1_with_Move.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Mercury_GCS_Sample_Application_1_with_Move.vi"/>
				<Item Name="Mercury_GCS_Sample_Application_2a.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Mercury_GCS_Sample_Application_2a.vi"/>
				<Item Name="Mercury_GCS_Sample_Application_DaisyChain.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Mercury_GCS_Sample_Application_DaisyChain.vi"/>
				<Item Name="Mercury_GCS_Sample_Application_USBDaisyChain.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Mercury_GCS_Sample_Application_USBDaisyChain.vi"/>
				<Item Name="Mercury_GCS_Simple_Test.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Mercury_GCS_Simple_Test.vi"/>
				<Item Name="PI Terminal.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/PI Terminal.vi"/>
				<Item Name="Show_Save_Load_ XY_Data.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Show_Save_Load_ XY_Data.vi"/>
				<Item Name="SwitchToAnalogOrDigital.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/SwitchToAnalogOrDigital.vi"/>
				<Item Name="WaveGenerator_Sample_Program_NoDDL.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/WaveGenerator_Sample_Program_NoDDL.vi"/>
			</Item>
			<Item Name="UI_多电机初始化模块.vi" Type="VI" URL="../../device control/UI_多电机初始化模块.vi"/>
			<Item Name="UI_velocity set dialog.vi" Type="VI" URL="../../UI_velocity set dialog.vi"/>
			<Item Name="UI_write_into_tdms.vi" Type="VI" URL="../../tracking/UI_write_into_tdms.vi"/>
			<Item Name="UI_set velocity.vi" Type="VI" URL="../../UI_set velocity.vi"/>
			<Item Name="UI refresh ROI.vi" Type="VI" URL="../../UI refresh ROI.vi"/>
			<Item Name="UI remove ROI.vi" Type="VI" URL="../../UI remove ROI.vi"/>
			<Item Name="UI_tracking xy.vi" Type="VI" URL="../../UI_tracking xy.vi"/>
		</Item>
		<Item Name="UI_main_2.vi" Type="VI" URL="../../UI_main_2.vi"/>
		<Item Name="data_analysis main.vi" Type="VI" URL="../../data analysis module/data analysis for MT/data_analysis main.vi"/>
		<Item Name="pause record.vi" Type="VI" URL="../../pause record.vi"/>
		<Item Name="QI radial profile calculate_C.vi" Type="VI" URL="../../QI radial profile calculate_C.vi"/>
		<Item Name="ROI modi and release memory.vi" Type="VI" URL="../../tracking/ROI modi and release memory.vi"/>
		<Item Name="high through put.vi" Type="VI" URL="../../tracking/high through put.vi"/>
		<Item Name="QI_rdp_with_power.vi" Type="VI" URL="../../QI_rdp_with_power.vi"/>
		<Item Name="Fmix generate zmag.vi" Type="VI" URL="../../Fmix generate zmag.vi"/>
		<Item Name="generate waiting time line.vi" Type="VI" URL="../../generate waiting time line.vi"/>
		<Item Name="依赖关系" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="NI_AALBase.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALBase.lvlib"/>
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="VISA Configure Serial Port" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port"/>
				<Item Name="VISA Configure Serial Port (Instr).vi" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port (Instr).vi"/>
				<Item Name="VISA Configure Serial Port (Serial Instr).vi" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port (Serial Instr).vi"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="Space Constant.vi" Type="VI" URL="/&lt;vilib&gt;/dlg_ctls.llb/Space Constant.vi"/>
				<Item Name="Write JPEG File(6_1).vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Write JPEG File(6_1).vi"/>
				<Item Name="imagedata.ctl" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/imagedata.ctl"/>
				<Item Name="Write JPEG File.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Write JPEG File.vi"/>
				<Item Name="Check File Permissions.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check File Permissions.vi"/>
				<Item Name="Check Path.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Path.vi"/>
				<Item Name="Directory of Top Level VI.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Directory of Top Level VI.vi"/>
				<Item Name="Check Color Table Size.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Color Table Size.vi"/>
				<Item Name="Check Data Size.vi" Type="VI" URL="/&lt;vilib&gt;/picture/jpeg.llb/Check Data Size.vi"/>
				<Item Name="compatOverwrite.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatOverwrite.vi"/>
				<Item Name="IMAQ Image.ctl" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/IMAQ Image.ctl"/>
				<Item Name="ROI Descriptor" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/ROI Descriptor"/>
				<Item Name="IMAQdx.ctl" Type="VI" URL="/&lt;vilib&gt;/userdefined/High Color/IMAQdx.ctl"/>
				<Item Name="NI_Vision_Development_Module.lvlib" Type="Library" URL="/&lt;vilib&gt;/vision/NI_Vision_Development_Module.lvlib"/>
				<Item Name="IMAQ ArrayToImage" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ ArrayToImage"/>
				<Item Name="IMAQ ImageToArray" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ ImageToArray"/>
				<Item Name="IMAQ Rectangle" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/IMAQ Rectangle"/>
				<Item Name="IMAQ Convert ROI to Rectangle" Type="VI" URL="/&lt;vilib&gt;/vision/ROI Conversion.llb/IMAQ Convert ROI to Rectangle"/>
				<Item Name="Beep.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/system.llb/Beep.vi"/>
				<Item Name="NI_Vision_Acquisition_Software.lvlib" Type="Library" URL="/&lt;vilib&gt;/vision/driver/NI_Vision_Acquisition_Software.lvlib"/>
				<Item Name="NI_PackedLibraryUtility.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/LVLibp/NI_PackedLibraryUtility.lvlib"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="NI_AALPro.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALPro.lvlib"/>
				<Item Name="NI_Gmath.lvlib" Type="Library" URL="/&lt;vilib&gt;/gmath/NI_Gmath.lvlib"/>
				<Item Name="NI_Matrix.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/Matrix/NI_Matrix.lvlib"/>
				<Item Name="IMAQ Group ROIs" Type="VI" URL="/&lt;vilib&gt;/vision/ROI Tools.llb/IMAQ Group ROIs"/>
				<Item Name="Color to RGB.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/colorconv.llb/Color to RGB.vi"/>
				<Item Name="IMAQ Overlay Text" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Text"/>
				<Item Name="IMAQ Overlay Points" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Points"/>
				<Item Name="IMAQ Clear Overlay" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Clear Overlay"/>
				<Item Name="Image Type" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/Image Type"/>
				<Item Name="IMAQ Create" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ Create"/>
				<Item Name="IMAQ Convert Rectangle to ROI" Type="VI" URL="/&lt;vilib&gt;/vision/ROI Conversion.llb/IMAQ Convert Rectangle to ROI"/>
				<Item Name="IMAQ Ungroup ROIs" Type="VI" URL="/&lt;vilib&gt;/vision/ROI Tools.llb/IMAQ Ungroup ROIs"/>
				<Item Name="IMAQ Dispose" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ Dispose"/>
				<Item Name="GetHelpDir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetHelpDir.vi"/>
				<Item Name="BuildHelpPath.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/BuildHelpPath.vi"/>
				<Item Name="LVBoundsTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVBoundsTypeDef.ctl"/>
				<Item Name="Get String Text Bounds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Get String Text Bounds.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="Convert property node font to graphics font.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Convert property node font to graphics font.vi"/>
				<Item Name="Longest Line Length in Pixels.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Longest Line Length in Pixels.vi"/>
				<Item Name="LVRectTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVRectTypeDef.ctl"/>
				<Item Name="Three Button Dialog CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog CORE.vi"/>
				<Item Name="Three Button Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog.vi"/>
				<Item Name="DialogTypeEnum.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogTypeEnum.ctl"/>
				<Item Name="Not Found Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Not Found Dialog.vi"/>
				<Item Name="Set Bold Text.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set Bold Text.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
				<Item Name="TagReturnType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/TagReturnType.ctl"/>
				<Item Name="ErrWarn.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/ErrWarn.ctl"/>
				<Item Name="Details Display Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Details Display Dialog.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Find Tag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find Tag.vi"/>
				<Item Name="Format Message String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Format Message String.vi"/>
				<Item Name="Error Code Database.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Code Database.vi"/>
				<Item Name="GetRTHostConnectedProp.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetRTHostConnectedProp.vi"/>
				<Item Name="Set String Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set String Value.vi"/>
				<Item Name="Check Special Tags.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Check Special Tags.vi"/>
				<Item Name="General Error Handler Core CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler Core CORE.vi"/>
				<Item Name="DialogType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogType.ctl"/>
				<Item Name="General Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler.vi"/>
				<Item Name="Simple Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Simple Error Handler.vi"/>
				<Item Name="Find First Error.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find First Error.vi"/>
				<Item Name="Close File+.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Close File+.vi"/>
				<Item Name="compatWriteText.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatWriteText.vi"/>
				<Item Name="Write File+ (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write File+ (string).vi"/>
				<Item Name="WDT Number of Waveform Samples DBL.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/WDT Number of Waveform Samples DBL.vi"/>
				<Item Name="WDT Number of Waveform Samples SGL.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/WDT Number of Waveform Samples SGL.vi"/>
				<Item Name="WDT Number of Waveform Samples I8.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/WDT Number of Waveform Samples I8.vi"/>
				<Item Name="WDT Number of Waveform Samples I32.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/WDT Number of Waveform Samples I32.vi"/>
				<Item Name="WDT Number of Waveform Samples I16.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/WDT Number of Waveform Samples I16.vi"/>
				<Item Name="WDT Number of Waveform Samples EXT.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/WDT Number of Waveform Samples EXT.vi"/>
				<Item Name="WDT Number of Waveform Samples CDB.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/WDT Number of Waveform Samples CDB.vi"/>
				<Item Name="Number of Waveform Samples.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/Number of Waveform Samples.vi"/>
				<Item Name="WDT Get Waveform Time Array DBL.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/WDT Get Waveform Time Array DBL.vi"/>
				<Item Name="DTbl Digital Size.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/DTblOps.llb/DTbl Digital Size.vi"/>
				<Item Name="DWDT Digital Size.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/DWDTOps.llb/DWDT Digital Size.vi"/>
				<Item Name="DWDT Get Waveform Time Array.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/DWDTOps.llb/DWDT Get Waveform Time Array.vi"/>
				<Item Name="Get Waveform Time Array.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/Get Waveform Time Array.vi"/>
				<Item Name="Check for Equality.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTOps.llb/Check for Equality.vi"/>
				<Item Name="Waveform Time to Date Time String.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTFileIO.llb/Waveform Time to Date Time String.vi"/>
				<Item Name="compatCalcOffset.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatCalcOffset.vi"/>
				<Item Name="compatOpenFileOperation.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatOpenFileOperation.vi"/>
				<Item Name="compatFileDialog.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatFileDialog.vi"/>
				<Item Name="Open_Create_Replace File.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/Open_Create_Replace File.vi"/>
				<Item Name="Export Waveforms To Spreadsheet File (1D).vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTFileIO.llb/Export Waveforms To Spreadsheet File (1D).vi"/>
				<Item Name="Export Waveforms To Spreadsheet File (Digital).vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTFileIO.llb/Export Waveforms To Spreadsheet File (Digital).vi"/>
				<Item Name="Export Waveform To Spreadsheet File.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTFileIO.llb/Export Waveform To Spreadsheet File.vi"/>
				<Item Name="Export Waveforms To Spreadsheet File (2D).vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTFileIO.llb/Export Waveforms To Spreadsheet File (2D).vi"/>
				<Item Name="Export Waveforms to Spreadsheet File.vi" Type="VI" URL="/&lt;vilib&gt;/Waveform/WDTFileIO.llb/Export Waveforms to Spreadsheet File.vi"/>
				<Item Name="ClearError.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tdmsutil.llb/ClearError.vi"/>
				<Item Name="Merge Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Merge Errors.vi"/>
				<Item Name="imgUpdateErrorCluster.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgUpdateErrorCluster.vi"/>
				<Item Name="imgClose.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgClose.vi"/>
				<Item Name="IMAQRegisterSession.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/IMAQRegisterSession.vi"/>
				<Item Name="imgSessionOpen.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgSessionOpen.vi"/>
				<Item Name="imgInterfaceOpen.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgInterfaceOpen.vi"/>
				<Item Name="IMAQ Init.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/imaqhl.llb/IMAQ Init.vi"/>
				<Item Name="SessionLookUp.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/SessionLookUp.vi"/>
				<Item Name="imgSetGetRoiInternal.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgSetGetRoiInternal.vi"/>
				<Item Name="imgPopScalingAndROI.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgPopScalingAndROI.vi"/>
				<Item Name="imgPopScalingAndROIWhenFinished.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgPopScalingAndROIWhenFinished.vi"/>
				<Item Name="imgAssociateBufListWithInterface.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgAssociateBufListWithInterface.vi"/>
				<Item Name="IMAQ Attribute.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/imaqhl.llb/IMAQ Attribute.vi"/>
				<Item Name="imgGrabSetup.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgGrabSetup.vi"/>
				<Item Name="imgSetRoi.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgSetRoi.vi"/>
				<Item Name="imgSetGetScaling.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgSetGetScaling.vi"/>
				<Item Name="imgSetChannel.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgSetChannel.vi"/>
				<Item Name="imgPushScalingAndROI.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgPushScalingAndROI.vi"/>
				<Item Name="IMAQ Grab Setup.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/imaqhl.llb/IMAQ Grab Setup.vi"/>
				<Item Name="imgIsNewStyleInterface.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgIsNewStyleInterface.vi"/>
				<Item Name="IMAQ Image Bit Depth" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ Image Bit Depth"/>
				<Item Name="IMAQ Image Cluster to Image Datatype.vi" Type="VI" URL="/&lt;vilib&gt;/vision/DatatypeConversion.llb/IMAQ Image Cluster to Image Datatype.vi"/>
				<Item Name="IMAQ Image Datatype to Image Cluster.vi" Type="VI" URL="/&lt;vilib&gt;/vision/DatatypeConversion.llb/IMAQ Image Datatype to Image Cluster.vi"/>
				<Item Name="IMAQ GetImagePixelPtr" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ GetImagePixelPtr"/>
				<Item Name="imgGetBitsPerComponent.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgGetBitsPerComponent.vi"/>
				<Item Name="imgReconstructimage.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgReconstructimage.vi"/>
				<Item Name="IMAQ GetImageSize" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ GetImageSize"/>
				<Item Name="imgGrabArea.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/imgGrabArea.vi"/>
				<Item Name="IMAQ Grab Acquire Old Style.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/IMAQ Grab Acquire Old Style.vi"/>
				<Item Name="IMAQ Grab Acquire.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/imaqhl.llb/IMAQ Grab Acquire.vi"/>
				<Item Name="IMAQUnregisterSession.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/DLLCalls.llb/IMAQUnregisterSession.vi"/>
				<Item Name="IMAQ Close.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/imaqhl.llb/IMAQ Close.vi"/>
				<Item Name="Vision Acquisition CalculateFPS.vi" Type="VI" URL="/&lt;vilib&gt;/vision/driver/Vision Acquisition Express Utility VIs.llb/Vision Acquisition CalculateFPS.vi"/>
				<Item Name="IMAQ Write TIFF File 2" Type="VI" URL="/&lt;vilib&gt;/vision/Files.llb/IMAQ Write TIFF File 2"/>
				<Item Name="IMAQ Write PNG File 2" Type="VI" URL="/&lt;vilib&gt;/vision/Files.llb/IMAQ Write PNG File 2"/>
				<Item Name="IMAQ Write JPEG2000 File 2" Type="VI" URL="/&lt;vilib&gt;/vision/Files.llb/IMAQ Write JPEG2000 File 2"/>
				<Item Name="IMAQ Write JPEG File 2" Type="VI" URL="/&lt;vilib&gt;/vision/Files.llb/IMAQ Write JPEG File 2"/>
				<Item Name="IMAQ Write Image And Vision Info File 2" Type="VI" URL="/&lt;vilib&gt;/vision/Files.llb/IMAQ Write Image And Vision Info File 2"/>
				<Item Name="IMAQ Write BMP File 2" Type="VI" URL="/&lt;vilib&gt;/vision/Files.llb/IMAQ Write BMP File 2"/>
				<Item Name="IMAQ Write File 2" Type="VI" URL="/&lt;vilib&gt;/vision/Files.llb/IMAQ Write File 2"/>
				<Item Name="NI_PtbyPt.lvlib" Type="Library" URL="/&lt;vilib&gt;/ptbypt/NI_PtbyPt.lvlib"/>
			</Item>
			<Item Name="lvanlys.dll" Type="Document" URL="/&lt;resource&gt;/lvanlys.dll"/>
			<Item Name="winmm.dll" Type="Document" URL="winmm.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="Analog_Configuration_Setup.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Analog_Configuration_Setup.vi"/>
			<Item Name="nivision.dll" Type="Document" URL="nivision.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="nivissvc.dll" Type="Document" URL="nivissvc.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="niimaqdx.dll" Type="Document" URL="niimaqdx.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="magnet_menu.rtm" Type="Document" URL="../../magnet_menu.rtm"/>
			<Item Name="FNL.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Limits.llb/FNL.vi"/>
			<Item Name="VEL?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/VEL?.vi"/>
			<Item Name="ONT?.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/General command.llb/ONT?.vi"/>
			<Item Name="imaq.dll" Type="Document" URL="imaq.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="Mercury_GCS_Configuration_Setup.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Mercury_GCS_Configuration_Setup.vi"/>
			<Item Name="POS.vi" Type="VI" URL="../../../../../../Users/Public/PI/GCSMergedLabVIEW/Low Level/Special command.llb/POS.vi"/>
			<Item Name="cuda_QI_v2.dll" Type="Document" URL="../../../../../../Users/user/Documents/Visual Studio 2015/Projects/cuda_QI_v3/x64/Release/cuda_QI_v2.dll"/>
		</Item>
		<Item Name="程序生成规范" Type="Build"/>
	</Item>
</Project>
