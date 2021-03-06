classdef DummyJob < hdsort.grid.GridJob
    properties (SetAccess=private)
    end
    
    properties
        dummyJobP
    end
    
    methods
        %%% ----------------CONSTRUCTOR------------------------------------
        function self = DummyJob(name, rootFolder, varargin)
            self = self@hdsort.grid.GridJob(name, rootFolder, varargin{:});
            self.taskType = 'DummyJob';
            
            p = struct;
            p = hdsort.util.parseInputs(p, self.P_untreated, 'error');
            self.dummyJobP = p;
                       
            self.startIndex = 1;
            self.endIndex = 3;
            self.taskIDs = self.startIndex:self.endIndex;
        end
        
        
        %------------------------------------------------------------------
        function setTaskParameters(self)
            
            taskParameters = struct;
            
            taskParameters.runName = self.jobName;
             
%             if ~isempty(strfind(computer, 'WIN')) | ~isempty(strfind(computer, 'MACI64'))
%                 	 taskParameters.destinationFolder =hdsort.grid.GridJob.convertToLinux(self.folders.destination);
%                 else
%                      taskParameters.destinationFolder = self.folders.destination;
%                 end
%             
            %% Create cell variable allTaskParamters:
            for ii = 1:length(self.taskIDs)
                taskParameters.taskID = self.taskIDs(ii);
                
                self.allTaskParameters{ii} = taskParameters;
            end
        end
        
    end
    
    methods(Static)
        %------------------------------------------------------------------
        %------------------------- RUN  FUNCTION ---------------------------
        %------------------------------------------------------------------
        function run(taskFile, debugFlag)
            if nargin < 2
                debugFlag = false;
            end
            
            %% Load taskFile:
            T = load(taskFile);
            taskP = T.taskParameters
            clear T;
            
            %% Check necessary parameters:
            %assert( exist(taskP.destinationFolder, 'dir') == 7, ['Task aborted: no valid destinationFolder specified! Path given:' taskP.destinationFolder]);
            assert( isfield(taskP, 'taskID'), 'Task aborted: field taskParameters.taskID not specified!');
            
            %% (Re-)Set reporting file:
            rep = hdsort.file.util.BinaryFileMatrix(taskP.reportFile, [1 2], 'writable', true);
            rep(:,:) = [0 0];
            
            if ~debugFlag
                try
                    mainBlock();
                catch ME
                    errorHandling(ME);
                end
            else
                mainBlock();
            end
            
            function mainBlock()
                disp(['This is a dummy job. The taskID is ' num2str(taskP.taskID) ])
                
                %% Write to reporter file:
                disp('Writing results...')
                rep = hdsort.file.util.BinaryFileMatrix(taskP.reportFile, [1 2], 'writable', true);
                rep(:,:) = [1 0];
            end
            
            function errorHandling(ME)
                
                disp('Catch error...')
                errStr = hdsort.util.buildLastErrString(ME);
                disp(errStr)
                
                rep = hdsort.file.util.BinaryFileMatrix(taskP.reportFile, [1 2], 'writable', true);
                rep(:,:) = [0 1];
                rethrow(ME)
            end
        end
        
    end
end
