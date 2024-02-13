

%% dataset description 
example_study_name = [];

% required for dataset_description.json
example_study_name.dataset_description.Name                = 'Prediction Error';
example_study_name.dataset_description.BIDSVersion         = 'unofficial extension';

% optional for dataset_description.json
example_study_name.dataset_description.License             = 'CC BY 4.0';
example_study_name.dataset_description.Authors             = {'Lukas Gehrke', 'Sezen Akman', 'Albert Chen', 'Pedro Lopes', 'Klaus Gramann'};
example_study_name.dataset_description.Acknowledgements    = 'We thank Avinash Singh, Tim Chen and C.-T. Lin from the Univsersity of Sydney (New South Wales, Australia) for their help developing the task.';
example_study_name.dataset_description.Funding             = {'n/a'};
example_study_name.dataset_description.ReferencesAndLinks  = {'Detecting Visuo-Haptic Mismatches in Virtual Reality using the Prediction Error Negativity of Event-Related Brain Potentials. Lukas Gehrke, Sezen Akman, Pedro Lopes, Albert Chen, Avinash Kumar Singh, Hsiang-Ting Chen, Chin-Teng Lin and Klaus Gramann | In Proceedings of the 2019 CHI Conference on Human Factors in Computing Systems (CHI ???19). ACM, New York, NY, USA, Paper 427, 11 pages. DOI: https://doi.org/10.1145/3290605.3300657'};    
example_study_name.dataset_description.DatasetDOI          = '10.18112/openneuro.ds003552.v1.2.0';
example_study_name.dataset_description.EthicsApproval      = {"GR_10_20180603"};

% general information shared across modality specific json files 
example_study_name.InstitutionName                         = 'Technische Universitaet zu Berlin';
example_study_name.InstitutionalDepartmentName             = 'Biological Psychology and Neuroergonomics';
example_study_name.InstitutionAddress                      = 'Strasse des 17. Juni 135, 10623, Berlin, Germany';
example_study_name.TaskDescription                         = 'Mismatch Negativity paradigm in which participants equipped with VR HMD and 64 Channel EEG reached to touch virtual objects';
 
%% Specification EEG Recording System

eegInfo     = []; 
eegInfo.eeg.ManufacturersModelName = 'BrainProducts BrainAmp';
eegInfo.eeg.SamplingFrequency = 500;
eegInfo.eeg.EOGChannelCount = 0;
eegInfo.eeg.PowerLineFrequency = 50;
eegInfo.eeg.EEGReference = 'FCz';
eegInfo.eeg.EEGReference = 'AFz';

eegInfo.eeg.SoftwareFilters = 'n/a';
                                                   
%% Specification Motion Recording System

motionInfo  = []; 

% motion specific fields in json
motionInfo.motion = [];
motionInfo.motion.RecordingType                     = 'continuous';

% system 1 information
motionInfo.motion.TrackingSystems(1).TrackingSystemName               = 'HTCViveHead';
motionInfo.motion.TrackingSystems(1).Manufacturer                     = 'HTC';
motionInfo.motion.TrackingSystems(1).ManufacturersModelName           = 'Vive Pro';
motionInfo.motion.TrackingSystems(1).SamplingFrequencyNominal         = 'n/a'; %  If no nominal Fs exists, n/a entry returns 'n/a'. If it exists, n/a entry returns nominal Fs from motion stream.
% system 1 information
motionInfo.motion.TrackingSystems(2).TrackingSystemName               = 'HTCViveRightHand';
motionInfo.motion.TrackingSystems(2).Manufacturer                     = 'HTC';
motionInfo.motion.TrackingSystems(2).ManufacturersModelName           = 'Vive Pro';
motionInfo.motion.TrackingSystems(2).SamplingFrequencyNominal         = 'n/a'; %  If no nominal Fs exists, n/a entry returns 'n/a'. If it exists, n/a entry returns nominal Fs from motion stream.

% coordinate system
% motionInfo.coordsystem.MotionCoordinateSystem      = 'RUF';
% motionInfo.coordsystem.MotionRotationRule          = 'left-hand';
% motionInfo.coordsystem.MotionRotationOrder         = 'ZXY';

% participant information 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% here describe the fields in the participant file
% for numerical values  : 
%       subjectData.fields.[insert your field name here].Description    = 'describe what the field contains';
%       subjectData.fields.[insert your field name here].Unit           = 'write the unit of the quantity';
% for values with discrete levels :
%       subjectData.fields.[insert your field name here].Description    = 'describe what the field contains';
%       subjectData.fields.[insert your field name here].Levels.[insert the name of the first level] = 'describe what the level means';
%       subjectData.fields.[insert your field name here].Levels.[insert the name of the Nth level]   = 'describe what the level means';
%--------------------------------------------------------------------------
participantInfo = [];

% participant information for participants.tsv file
% -------------------------------------------------
% tmp = readtable([path, 'studies\Prediction_Error\admin\questionnaires_PE_2018.xlsx'], 'Sheet', 'Matlab Import');
tmp = readtable([path, '/admin/questionnaires_PE_2018.xlsx'], 'Sheet', 'Matlab Import');
participantInfo.cols = tmp.Properties.VariableNames;
participantInfo.cols{1} = 'nr';
participantInfo.data = [table2cell(tmp)];
        
% participant column description for participants.json file
% ---------------------------------------------------------
participantInfo.fields.nr.Description = 'unique participant identifier';
participantInfo.fields.biological_sex.Description = 'biological sex of the participant';
participantInfo.fields.biological_sex.Levels.m = 'male';
participantInfo.fields.biological_sex.Levels.f = 'female';
participantInfo.fields.age.Description = 'age of the participant';
participantInfo.fields.age.Units       = 'years';
participantInfo.fields.cap_size.Description = 'head circumference and EEG cap sized used';
participantInfo.fields.cap_size.Units       = 'centimeter';
participantInfo.fields.block_1.Description = 'pseudo permutation of sensory feedback conditions: condition of first block';
participantInfo.fields.block_1.Units       = 'Visual = Visual only condition; Visual + Vibro = Simultaneous visual and vibrotactile sensory feedback';
participantInfo.fields.block_2.Description = 'pseudo permutation of sensory feedback conditions: condition of second block';
participantInfo.fields.block_3.Description = 'some select participants completed a third block with Visual + Vibro + EMS sensory feedback';
participantInfo.fields.block_3.Units       = 'Visual + Vibro + EMS = Simultaneous visual, vibrotactile and electrical muscle stimulation sensory feedback';

sessions = {'TestVisual', 'TestVibro', 'TestEMS', 'Training'};
ems_subjects = [1,2,5,6,7,10,11,12,13,14,15];
runs = {'erste100', '101bis300'};

%% loop over participants
for subject = 1:size(participantInfo.data,1)

    config                        = [];                                 % reset for each loop 
    config.bids_target_folder     = [path, 'studies/Prediction_Error/data/1_BIDS-data'];                     % required            
    config.task                   = 'PredError';                      % optional 
    config.subject                = subject;                            % required
    config.overwrite              = 'on';

    config.eeg.stream_name        = 'BrainVision';                      % required
    config.eeg.SamplingFrequency = 500;
    cfg.eeg.chanloc_newname    = {'Fp1', 'Fz', 'F3', 'F7', 'FT9', 'FC5', 'FC1', ...
        'C3', 'T7', 'TP9', 'CP5', 'CP1', 'Pz', 'P3', 'P7', 'O1', 'Oz', 'O2', ...
        'P4', 'P8', 'TP10', 'CP6', 'CP2', 'Cz', 'C4', 'T8', 'FT10', 'FC6', ...
        'FC2', 'F4', 'F8', 'Fp2', 'AF7', 'AF3', 'AFz', 'F1', 'F5', 'FT7', ...
        'FC3', 'C1', 'C5', 'TP7', 'CP3', 'P1', 'P5', 'PO7', 'PO3', 'POz', ...
        'PO4', 'PO8', 'P6', 'P2', 'CPz', 'CP4', 'TP8', 'C6', 'C2', 'FC4', ...
        'FT8', 'F6', 'AF8', 'AF4', 'F2', 'VEOG'};
    config.eeg.EOGChannelCount = 0;
    config.eeg.PowerLineFrequency = 50;
    config.eeg.EEGReference = 'REF';
    config.eeg.SoftwareFilters = 'n/a';
    
    config.motion.tracksys{1}.name              = 'HTCViveHead';
    config.motion.tracksys{2}.name              = 'HTCViveRightHand';

    config.motion.streams{1}.tracksys           = 'HTCViveHead';   
    config.motion.streams{1}.name               = 'Rigid_Head';
    config.motion.streams{1}.tracked_points     = 'Rigid_Head';
    config.motion.streams{1}.tracked_points_anat= 'head';

    config.motion.streams{2}.tracksys           = 'HTCViveRightHand';       
    config.motion.streams{2}.name               = 'Rigid_handR';
    config.motion.streams{2}.tracked_points     = 'Rigid_handR';
    config.motion.streams{2}.tracked_points_anat= 'right_hand';    
    
    % config.bids_parsemarkers_custom = 'bids_parsemarkers_pe';
    config.bids_parsemarkers_custom = '';
    
    thisSessions = sessions;
    if subject == 2
        thisSessions = {'TestVisual', 'TestVibroerste100', 'TestVibro101bis300', 'TestEMS', 'Training'};
    elseif subject == 6
        config.eeg_index = 1;
    % TODO Fix this so also EMS Blocks are included where available
    elseif ~ismember(subject, ems_subjects)
        thisSessions = {'TestVisual', 'TestVibro', 'Training'};
    end
    
    for session = thisSessions
        config.session                = session{1};              % optional
        config.filename               = [path 'studies/Prediction_Error/data/0_raw-data/s' num2str(subject+1) '/s' num2str(subject+1) '_PredError_block_' session{1} '.xdf']; % required
        bemobil_xdf2bids(config, ...
            'general_metadata', example_study_name,...
            'participant_metadata', participantInfo,...
            'motion_metadata', motionInfo, ...
            'eeg_metadata', eegInfo);
    end
    
    % BIDS 2 set
    config.study_folder             = [path 'studies/Prediction_Error/data/'];
    config.session_names            = thisSessions;
    config.raw_EEGLAB_data_folder   = '2_raw-EEGLAB';
    config.other_data_types        = {'motion'};
    bemobil_bids2set(config);
end

disp('IMPORT DONE!')
disp('PLEASE CHECK FIGURES FOR TIMING CONSISTENCY!')