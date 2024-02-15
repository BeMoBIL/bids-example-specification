addpath(genpath("/Users/lukasgehrke/code/bids-example-specification/"));

% general metadata, recording environment and hardware specs
general = readstruct('general.json');
eeg = readstruct('eeg.json');
motion = readstruct('motion.json');
env = readstruct('bemobil.json');

%% info about the streams of this particular subject as they appear in the XDF file to parse
subject = readstruct('subject.json');

%% parse the XDF file and write the BIDS files
subject.bids_target_folder    = strcat(general.TaskName{1}, env.bids_target_folder{1});
subject.task                  = general.TaskName{1};

subject.eeg.stream_name       = eeg.eeg_stream_name{1};
subject.eeg.channel_labels    = cellstr(eeg.eeg_chanloc_names);
subject.eeg.ref_channel       = eeg.EEGReference;
subject.eeg.chanloc           = [];

if ~(motion.xdf_names == "")
    for i = 1:numel(motion.xdf_names)
        subject.motion.streams{i}.xdfname = motion.xdf_names{i};
        subject.motion.streams{i}.bidsname = motion.bids_names{i};
        subject.motion.streams{i}.tracked_points = motion.tracked_points{i};
    end
end

subject.bids_parsemarkers_custom = '';

tmp_subject_naming = strcat('sub-', sprintf('%02d', str2double(subject.subject)));
for session = subject.session_names
    subject.session               = session{1};              % optional
    subject.filename              = fullfile(env.bids_source_folder, tmp_subject_naming, strcat(tmp_subject_naming, '_', session, '.xdf'));

    bemobil_xdf2bids(subject, ...
        'general_metadata', general,...
        'eeg_metadata', eeg, ...
        'motion_metadata', motion ...
    );
end