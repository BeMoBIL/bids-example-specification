addpath(genpath("/Users/lukasgehrke/code/bids-example-specification/"));

env = readstruct('bemobil.json');
subject = readstruct('subject.json');
eeg = readstruct('eeg.json');

subject.bids_target_folder = env.bids_target_folder{1};
subject.set_folder         = fullfile('data', 'derivatives', env.raw_eeglab_folder{1});
subject.subject            = str2double(subject.subject{1});
subject.other_data_types   = {env.other_data_types{1}};
subject.match_electrodes_channels = {eeg.eeg_chanloc_names};

bemobil_bids2set(subject);
