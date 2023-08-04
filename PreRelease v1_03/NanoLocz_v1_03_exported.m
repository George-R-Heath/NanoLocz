classdef NanoLocz_v1_03_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        NanoLocz1_00Pre                 matlab.ui.Figure
        FileMenu                        matlab.ui.container.Menu
        OpenMenu                        matlab.ui.container.Menu
        FolderMenu                      matlab.ui.container.Menu
        OpenSessionMenu                 matlab.ui.container.Menu
        SaveMenu                        matlab.ui.container.Menu
        QuitMenu                        matlab.ui.container.Menu
        ImageMenu                       matlab.ui.container.Menu
        CropMenu                        matlab.ui.container.Menu
        HelpMenu                        matlab.ui.container.Menu
        ComingSoonMenu                  matlab.ui.container.Menu
        SimulationsMenu                 matlab.ui.container.Menu
        OpenMat_SimAFMMenu              matlab.ui.container.Menu
        ThumbnailViewButton             matlab.ui.control.Button
        SaveType                        matlab.ui.control.DropDown
        FilesDropDown                   matlab.ui.control.DropDown
        SaveSession                     matlab.ui.control.Image
        OpenFolderButton                matlab.ui.control.Image
        View1st                         matlab.ui.control.NumericEditField
        View1stCheckBox                 matlab.ui.control.CheckBox
        AutoplayCheckBox                matlab.ui.control.CheckBox
        BidirectionaldataCheckBox       matlab.ui.control.CheckBox
        FramePartSwitch                 matlab.ui.control.Switch
        PreviewonoffButton              matlab.ui.control.StateButton
        ImagePanel                      matlab.ui.container.Panel
        ClearButton_2                   matlab.ui.control.Button
        MultiReferenceCheckBox          matlab.ui.control.CheckBox
        ReferenceButtonGroup            matlab.ui.container.ButtonGroup
        RefCropButton                   matlab.ui.control.Button
        DropDown                        matlab.ui.control.DropDown
        LAFMPanel                       matlab.ui.container.Panel
        LAFMScalebarCheckBox            matlab.ui.control.CheckBox
        ViewSymmetrizedButton           matlab.ui.control.StateButton
        AutoCenterLAFM                  matlab.ui.control.CheckBox
        LAFM_sym_2                      matlab.ui.control.Spinner
        LAFMMinSlider                   matlab.ui.control.Slider
        MinLabel_5                      matlab.ui.control.Label
        LAFMMaxSlider                   matlab.ui.control.Slider
        MaxLabel_5                      matlab.ui.control.Label
        LineProfilePanel                matlab.ui.container.Panel
        AlignLineType                   matlab.ui.control.DropDown
        Live                            matlab.ui.control.StateButton
        AlignButton                     matlab.ui.control.Button
        PopAx2                          matlab.ui.control.Button
        UITable2                        matlab.ui.control.Table
        PopAx1                          matlab.ui.control.Button
        HistBin                         matlab.ui.control.EditField
        HistValue                       matlab.ui.control.DropDown
        Forceto11Button                 matlab.ui.control.Button
        ProcessingImage                 matlab.ui.control.Image
        ColorBarCheckBox                matlab.ui.control.CheckBox
        AcceptButtonImage               matlab.ui.control.Image
        RightPlotList                   matlab.ui.control.DropDown
        ViewpixelsDropDown              matlab.ui.control.DropDown
        LeftPlotList                    matlab.ui.control.DropDown
        AspectRatioSwitch               matlab.ui.control.Switch
        TimescaleCheckBox               matlab.ui.control.CheckBox
        ScalebarCheckBox                matlab.ui.control.CheckBox
        OverlayDropDown                 matlab.ui.control.DropDown
        PlotTypeDropDown                matlab.ui.control.DropDown
        ColourmapDropDown               matlab.ui.control.DropDown
        ExportFileFormat                matlab.ui.control.DropDown
        ExportSelect                    matlab.ui.control.DropDown
        ExportButton                    matlab.ui.control.Button
        ZPanel                          matlab.ui.container.Panel
        HoldButton                      matlab.ui.control.Button
        AutoButton                      matlab.ui.control.Button
        ContrastMinSpinner              matlab.ui.control.Spinner
        minSpinnerLabel                 matlab.ui.control.Label
        ContrastMaxSpinner              matlab.ui.control.Spinner
        maxSpinnerLabel                 matlab.ui.control.Label
        ZScaleDropBox                   matlab.ui.control.DropDown
        VideoPanel                      matlab.ui.container.Panel
        DeleterangeLabel                matlab.ui.control.Label
        RemoveframesEditField           matlab.ui.control.EditField
        BinRangeImage                   matlab.ui.control.Image
        BinImage                        matlab.ui.control.Image
        StartImage                      matlab.ui.control.Image
        EndImage                        matlab.ui.control.Image
        PauseImage                      matlab.ui.control.Image
        PlayImage                       matlab.ui.control.Image
        fps                             matlab.ui.control.NumericEditField
        fpsEditFieldLabel               matlab.ui.control.Label
        Spinner                         matlab.ui.control.Spinner
        FrameSlider                     matlab.ui.control.Slider
        UIAxes_2                        matlab.ui.control.UIAxes
        UIAxes                          matlab.ui.control.UIAxes
        TabGroup                        matlab.ui.container.TabGroup
        LevelTab                        matlab.ui.container.Tab
        FixShiftValue                   matlab.ui.control.NumericEditField
        FixShiftMethod                  matlab.ui.control.DropDown
        FixLineShift                    matlab.ui.control.CheckBox
        AutoFlattenPanel                matlab.ui.container.Panel
        AutoflattenDropDown             matlab.ui.control.DropDown
        RestoreButton                   matlab.ui.control.Button
        ZeroallButton                   matlab.ui.control.Button
        Panel                           matlab.ui.container.Panel
        Hist_excludeOut                 matlab.ui.control.StateButton
        FitButton                       matlab.ui.control.Button
        ClearROIButton                  matlab.ui.control.Button
        ROIThresholdButton              matlab.ui.control.StateButton
        InvertselectedLabel             matlab.ui.control.Label
        InvertSelected                  matlab.ui.control.CheckBox
        ThresholdContrastSwitch         matlab.ui.control.Switch
        SliderMax                       matlab.ui.control.Slider
        SliderMin                       matlab.ui.control.Slider
        LogYLabel                       matlab.ui.control.Label
        LogYHist                        matlab.ui.control.CheckBox
        PreviewThresholdLabel           matlab.ui.control.Label
        PreviewThresholdCheck           matlab.ui.control.CheckBox
        ThresholdMethod                 matlab.ui.control.DropDown
        upperlimitLabel                 matlab.ui.control.Label
        lowerlimitLabel                 matlab.ui.control.Label
        Hist_Axes                       matlab.ui.control.UIAxes
        ManualFlattenPanel              matlab.ui.container.Panel
        MeanLabel_2                     matlab.ui.control.Label
        MeanPlaneCheckBox               matlab.ui.control.CheckBox
        MeanLabel                       matlab.ui.control.Label
        MedianCheckBox                  matlab.ui.control.CheckBox
        YPlaneSpinner                   matlab.ui.control.Spinner
        YSpinnerLabel                   matlab.ui.control.Label
        XPlaneSpinner                   matlab.ui.control.Spinner
        XSpinnerLabel                   matlab.ui.control.Label
        YLineSpinner                    matlab.ui.control.Spinner
        XLineSpinner                    matlab.ui.control.Spinner
        LineLabel                       matlab.ui.control.Label
        PlaneLabel                      matlab.ui.control.Label
        FilteringPanel                  matlab.ui.container.Panel
        HighpassEditField               matlab.ui.control.NumericEditField
        HighpassEditFieldLabel          matlab.ui.control.Label
        GaussianEditField               matlab.ui.control.NumericEditField
        GaussianEditFieldLabel          matlab.ui.control.Label
        AlignTab                        matlab.ui.container.Tab
        Sq_roi_Button_3                 matlab.ui.control.StateButton
        UseAvgrefCheckBox               matlab.ui.control.CheckBox
        UpdateRefwithAverageButton      matlab.ui.control.Button
        SettingsLabel                   matlab.ui.control.Label
        SubPixelLabel                   matlab.ui.control.Label
        ViewSwitch                      matlab.ui.control.Switch
        ViewSwitchLabel                 matlab.ui.control.Label
        MaxdriftEditField               matlab.ui.control.NumericEditField
        MaxdriftEditFieldLabel          matlab.ui.control.Label
        FilterImgEditField              matlab.ui.control.NumericEditField
        FilterImgEditFieldLabel         matlab.ui.control.Label
        SubPixCheckBox                  matlab.ui.control.CheckBox
        FilterCCREditField              matlab.ui.control.NumericEditField
        FilterCCREditFieldLabel         matlab.ui.control.Label
        RunAlignButton                  matlab.ui.control.Button
        DetectTab                       matlab.ui.container.Tab
        Sq_roi_Button_2                 matlab.ui.control.StateButton
        MinseparationLabel              matlab.ui.control.Label
        MinheightLabel                  matlab.ui.control.Label
        Peaks_minSep                    matlab.ui.control.Spinner
        Peaks_minHeight                 matlab.ui.control.Spinner
        AllowrotationofreferencePanel   matlab.ui.container.Panel
        SearchanglesEditField           matlab.ui.control.EditField
        SearchanglesEditFieldLabel      matlab.ui.control.Label
        RotationalFreedom               matlab.ui.control.CheckBox
        AutocenterreferencePanel        matlab.ui.container.Panel
        Symmetry_detect                 matlab.ui.control.NumericEditField
        FilterImageLabel_2              matlab.ui.control.Label
        AutocentrereCheckBox            matlab.ui.control.CheckBox
        PreviewpeaksLabel               matlab.ui.control.Label
        PreviewPeaks                    matlab.ui.control.CheckBox
        FilterdetectionsLabel           matlab.ui.control.Label
        ExcludeedgesLabel               matlab.ui.control.Label
        ExcludeEdgeCheckBox             matlab.ui.control.CheckBox
        FilterxcorimageLabel            matlab.ui.control.Label
        SettingsLabel_Detect_2          matlab.ui.control.Label
        FilterCCREditField_Detect       matlab.ui.control.NumericEditField
        BoxSizeEditField                matlab.ui.control.NumericEditField
        BoxSizeEditFieldLabel           matlab.ui.control.Label
        PeaksRegionsSwitch              matlab.ui.control.Switch
        SelectMethodLabel_2             matlab.ui.control.Label
        SettingsLabel_Detect            matlab.ui.control.Label
        FindParticlesButton             matlab.ui.control.Button
        FilterImgEditField_Detect       matlab.ui.control.NumericEditField
        FilterImageLabel                matlab.ui.control.Label
        TrackDetectionsPanel            matlab.ui.container.Panel
        MaxstepEditField                matlab.ui.control.NumericEditField
        MaxstepEditFieldLabel           matlab.ui.control.Label
        MaxmissingEditField             matlab.ui.control.NumericEditField
        MaxmissingEditFieldLabel        matlab.ui.control.Label
        RunTrackingButton               matlab.ui.control.Button
        Overlay                         matlab.ui.container.Panel
        ValuesLabel                     matlab.ui.control.Label
        OverlayValues                   matlab.ui.control.DropDown
        TrackLengthEditField            matlab.ui.control.NumericEditField
        TrackLengthEditFieldLabel       matlab.ui.control.Label
        BoxesCheckBox                   matlab.ui.control.CheckBox
        MarkersCheckBox                 matlab.ui.control.CheckBox
        Filter_detections_panel         matlab.ui.container.Panel
        Height_corr_switch              matlab.ui.control.Switch
        CCRSliderMax                    matlab.ui.control.Slider
        CCRSliderMin                    matlab.ui.control.Slider
        upperlimitLabel_2               matlab.ui.control.Label
        lowerlimitLabel_2               matlab.ui.control.Label
        CorrelationCheckBox             matlab.ui.control.CheckBox
        HeightCheckBox                  matlab.ui.control.CheckBox
        Min_CCR_Edit                    matlab.ui.control.NumericEditField
        Max_CCR_Edit                    matlab.ui.control.NumericEditField
        MaxLabel_2                      matlab.ui.control.Label
        MinLabel_2                      matlab.ui.control.Label
        MinLabel                        matlab.ui.control.Label
        MaxLabel                        matlab.ui.control.Label
        Min_h_Edit                      matlab.ui.control.NumericEditField
        Max_h_Edit                      matlab.ui.control.NumericEditField
        HeightCCRHist                   matlab.ui.control.UIAxes
        FineAlignTab                    matlab.ui.container.Tab
        ApplyButton                     matlab.ui.control.Button
        RoiareaEditField                matlab.ui.control.NumericEditField
        RoiareaEditFieldLabel           matlab.ui.control.Label
        SymmetryEditField               matlab.ui.control.NumericEditField
        SymmetryEditFieldLabel          matlab.ui.control.Label
        Panel_3                         matlab.ui.container.Panel
        ThresholdwithminheightCheckBox  matlab.ui.control.CheckBox
        RunFineAlignButton              matlab.ui.control.Button
        AutoupdatereferenceimageCheckBox  matlab.ui.control.CheckBox
        MaxdriftEditField_2             matlab.ui.control.NumericEditField
        MaxdriftEditField_2Label        matlab.ui.control.Label
        Tran_IterationsEditField        matlab.ui.control.NumericEditField
        IterationsEditField_3Label      matlab.ui.control.Label
        TranslationalLabel              matlab.ui.control.Label
        Rot_IterationsEditField         matlab.ui.control.NumericEditField
        IterationsEditField_2Label      matlab.ui.control.Label
        RotationalLabel                 matlab.ui.control.Label
        searchangleEditField            matlab.ui.control.NumericEditField
        searchangleEditFieldLabel       matlab.ui.control.Label
        CenterrefButton                 matlab.ui.control.Button
        LocalizeTab                     matlab.ui.container.Tab
        ColourmapLabel                  matlab.ui.control.Label
        LAFM_exp                        matlab.ui.control.NumericEditField
        imageexpansionLabel             matlab.ui.control.Label
        LAFM_gus                        matlab.ui.control.NumericEditField
        RenderpointsLabel               matlab.ui.control.Label
        LAFM_LUT                        matlab.ui.control.DropDown
        RenderLAFMButton                matlab.ui.control.Button
        Localize_ThreshPanel            matlab.ui.container.Panel
        LoczProminenceSpinner           matlab.ui.control.Spinner
        ProminenceSpinnerLabel          matlab.ui.control.Label
        ThresholdLabel_3                matlab.ui.control.Label
        LoczHeightSpinner               matlab.ui.control.Spinner
        ThresholdLabel_2                matlab.ui.control.Label
        LoczMinSep                      matlab.ui.control.Spinner
        ThresholdLabel                  matlab.ui.control.Label
        LoczImagepeaksCheckBox          matlab.ui.control.CheckBox
        FindallpeaksButton              matlab.ui.control.Button
        Localize_FilterPanel            matlab.ui.container.Panel
        LoczShowfilterCheckBox          matlab.ui.control.CheckBox
        LocFilterLabel                  matlab.ui.control.Label
        LoczHighpass                    matlab.ui.control.Spinner
        LoczLowpass                     matlab.ui.control.Spinner
        LoczLowpassDropDown             matlab.ui.control.DropDown
        LowpassDropDownLabel            matlab.ui.control.Label
        LoczHighpassDropDown            matlab.ui.control.DropDown
        HighpassDropDownLabel           matlab.ui.control.Label
        ChannelDropDown                 matlab.ui.control.DropDown
        FolderDown                      matlab.ui.control.Image
        FolderUp                        matlab.ui.control.Image
        UITable                         matlab.ui.control.Table
        FilesListBox                    matlab.ui.control.ListBox
        Toolbar                         matlab.ui.container.Panel
        Button                          matlab.ui.control.Button
        kymo                            matlab.ui.control.Button
        RotationalAvgButton             matlab.ui.control.Button
        AverageRefButton                matlab.ui.control.Button
        HistPlot                        matlab.ui.control.StateButton
        ZoomIn                          matlab.ui.control.StateButton
        CropButton                      matlab.ui.control.Button
        Point_roi_Button                matlab.ui.control.StateButton
        Line_roi_Button                 matlab.ui.control.StateButton
        Sq_roi_Button                   matlab.ui.control.StateButton
        Circ_roi_Button                 matlab.ui.control.StateButton
        ClearButton                     matlab.ui.control.Button
        CancelButton                    matlab.ui.control.Button
        loadbar                         matlab.ui.control.UIAxes
        ContextMenu_ScaleBar            matlab.ui.container.ContextMenu
        ChangeColorMenu                 matlab.ui.container.Menu
        BlackMenu                       matlab.ui.container.Menu
        WhiteMenu                       matlab.ui.container.Menu
        CyanMenu                        matlab.ui.container.Menu
        MagentaMenu                     matlab.ui.container.Menu
        BlueMenu                        matlab.ui.container.Menu
        GreenMenu                       matlab.ui.container.Menu
        YellowMenu                      matlab.ui.container.Menu
        ChangePositionMenu              matlab.ui.container.Menu
        BottomRightMenu                 matlab.ui.container.Menu
        BottomLeftMenu                  matlab.ui.container.Menu
        TopRightMenu                    matlab.ui.container.Menu
        TopLeftMenu                     matlab.ui.container.Menu
        ContextMenu_TimeScale           matlab.ui.container.ContextMenu
        ChangePositionMenu_2            matlab.ui.container.Menu
        TopLeftMenu_2                   matlab.ui.container.Menu
        TopRightMenu_2                  matlab.ui.container.Menu
        BottomRightMenu_2               matlab.ui.container.Menu
        BottomLeftMenu_2                matlab.ui.container.Menu
        ChangeColourMenu                matlab.ui.container.Menu
        BlackMenu_2                     matlab.ui.container.Menu
        WhiteMenu_2                     matlab.ui.container.Menu
        CyanMenu_2                      matlab.ui.container.Menu
        MagentaMenu_2                   matlab.ui.container.Menu
        BlueMenu_2                      matlab.ui.container.Menu
        GreenMenu_2                     matlab.ui.container.Menu
        YellowMenu_2                    matlab.ui.container.Menu
        ExportContextMenu               matlab.ui.container.ContextMenu
        BackgroundcolorMenu             matlab.ui.container.Menu
        blackMenu                       matlab.ui.container.Menu
        whiteMenu                       matlab.ui.container.Menu
        ResolutionDPIMenu               matlab.ui.container.Menu
        dpi75                           matlab.ui.container.Menu
        dpi150                          matlab.ui.container.Menu
        dpi300                          matlab.ui.container.Menu
        dpi450                          matlab.ui.container.Menu
    end


%  DESCRIPTION:   NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  COPYRIGHT:     George Heath, 2023
%  LICENSE:       GPLv3
%  AUTHOR:        George Heath, University of Leeds, g.r.heath@leeds.ac.uk 30.06.2023
%         
%  If using the Localization Atomic Force Microscopy method please cite: 
%  Heath, G.R., Kots, E., Robertson, J.L. et al. Localization atomic force microscopy. 
%  Nature 594, 385–390 (2021). https://doi.org/10.1038/s41586-021-03551-x

    properties (Access = public)
        OpenFolder
        ImageName
        ImageTarget
        ImagePreview
        Part      %Particle locations: 1=x, 2=y, 3=z, 4=ccr, 5=frame, 6 = id; 7=particle track, 8 = particle angle
        ImageInfo
        cmap
        filter_full
        filter_already
        viewangle
        ref
        rect
        img_locs
        LAFM
        roi
        patches
        PointROI
        LineROI
        SquareROI
        CircleROI
        stop
        label
        VideoExp
        ExportSettings
        stored
        ThresholdROI
        PlotMode
        RadialDist
        PopupApp
        ThumbnailApp
        ROIs
        RefNo
    end
    
    

      methods (Access = public)

        function reset_defaults(app)
            app.img_locs = []; app.ref = []; app.rect = []; app.ImageInfo=[]; app.Part=[];  app.LAFM = []; app.LineROI=[];app.SquareROI=[]; app.PointROI=[];
            app.LineROI = [];  app.SquareROI = []; app.ThresholdROI = [];
            app.RightPlotList.Items = {'Off'};
            app.RightPlotList.Value = 'Off';
            PauseImageClicked(app)
            app.filter_already =0;
            app.FramePartSwitch.Value = 'Frames';
            app.OverlayDropDown.Value = 'None';
            cla(app.UIAxes);   cla(app.UIAxes_2); cla(app.HeightCCRHist); cla(app.loadbar);
            app.LoczImagepeaksCheckBox.Value =0;
           app.Max_CCR_Edit.Value =1;
           app.Min_CCR_Edit.Value =0.5;
           app.UseAvgrefCheckBox.Visible=0;
           app.UseAvgrefCheckBox.Value =0; 
           app.PreviewPeaks.Value =0;
           app.LAFMPanel.Visible = 0;
           TurnOffButtons(app,'all')
        end

        function updateFolder(app)
            %Show file from the chosen directory in the listbox
            if app.OpenFolder ~= 0
                imageFiles = dir([app.OpenFolder]);
                imageFiles = imageFiles(~ismember({imageFiles(:).name},{'.','..','.DS_Store'}));
                app.FilesListBox.Items = {imageFiles.name};
            end
        end



        function updateVideoTools(app)
                        if app.View1stCheckBox.Value ==1 && app.View1st.Value < app.ImageInfo.n
                            loadn = app.View1st.Value;
                        else
                            loadn = app.ImageInfo.n;
                        end
            
            ty = app.FramePartSwitch.Value;
            switch ty
                case 'Frames'
                    if loadn <2
                        app.TimescaleCheckBox.Visible = 0;
                        app.TimescaleCheckBox.Value = 0;
                        app.VideoPanel.Visible = 0;
                    else
                        app.Spinner.Limits = [1 loadn];
                        app.FrameSlider.Limits = [1 loadn];
                        if app.Spinner.Limits(2)>=10
                            inter = (app.Spinner.Limits(2)/10);
                        else
                            inter = 1;
                        end
                        app.FrameSlider.MajorTicks = round(1:inter:loadn);
                        app.FrameSlider.MajorTickLabels = string(round(1:inter:loadn));
                        app.VideoPanel.Visible = 1;
                        app.TimescaleCheckBox.Visible = 1;
                    end
           
                case 'Particles'
                    app.TimescaleCheckBox.Visible = 0;
                    app.TimescaleCheckBox.Value = 0;
                    if    numel(app.Part.Image(1,1,app.Part.IncludeImages ))<2
                        app.VideoPanel.Visible = 0;

                    else
                        app.Spinner.Limits = [1 numel(app.Part.Image(1,1,app.Part.IncludeImages ))];
                        app.FrameSlider.Limits = app.Spinner.Limits;
                        if app.Spinner.Limits(2)>=10
                            inter = (app.Spinner.Limits(2)/10);
                        else
                            inter = 1;
                        end
                        app.FrameSlider.MajorTicks = round(1:inter:app.Spinner.Limits(2));
                        app.FrameSlider.MajorTickLabels = string(round(1:inter:app.Spinner.Limits(2)));
                        app.VideoPanel.Visible = 1;
                    end
            end
        end
        


        function filter_Partlocs(app)

            app.Part.IncludeImages = ones(numel(app.Part.Locs(:,3)),1);
            if app.CorrelationCheckBox.Value==1
                app.Part.IncludeImages = app.Part.IncludeImages.*(app.Part.Locs(:,4)>=app.Min_CCR_Edit.Value);
                app.Part.IncludeImages = app.Part.IncludeImages.*(app.Part.Locs(:,4)<=app.Max_CCR_Edit.Value);
            end

            if app.HeightCheckBox.Value==1
                app.Part.IncludeImages = app.Part.IncludeImages.*(app.Part.Locs(:,3)>=app.Min_h_Edit.Value);
                app.Part.IncludeImages = app.Part.IncludeImages.*(app.Part.Locs(:,3)<=app.Max_h_Edit.Value);
            end
            app.Part.IncludeImages = app.Part.IncludeImages >0;
            app.Part.Locs(:,6) = NaN;

            app.Part.Locs(app.Part.IncludeImages,6) =  1:numel(app.Part.Locs(app.Part.IncludeImages,3));

        end



        %Update Plot 1
        function updatePlot(app,varargin)
            switch  app.FramePartSwitch.Value
                case 'Frames'
                    switch  app.LeftPlotList.Value
                        case 'Target'
                            if app.MultiReferenceCheckBox.Value
                                img = findobj(app.UIAxes, 'type', 'image');
                                img = img.CData;
                            else    
                                img = app.ImageTarget;
                            end    
                            app.AcceptButtonImage.Visible = 0;
                            app.PreviewonoffButton.Value = 0;
                        case 'Preview'
                            if app.MultiReferenceCheckBox.Value
                                img = findobj(app.UIAxes, 'type', 'image');
                            else    
                                img = app.ImageTarget;
                            end 
                            app.AcceptButtonImage.Visible = 1;
                            app.PreviewonoffButton.Value = 1;     
                    end
                case 'Particles'
                     switch  app.LeftPlotList.Value
                        case 'Target'
                            img = app.Part.Image(:,:,app.Part.IncludeImages);
                            app.AcceptButtonImage.Visible = 0;
                            app.PreviewonoffButton.Value = 0;
                        case 'Preview'
                            img = app.ImagePreview(:,:,app.Part.IncludeImages);
                            app.AcceptButtonImage.Visible = 1;
                            app.PreviewonoffButton.Value = 1;     
                     end
            end

            switch varargin{1}
                case {'popout','export frame'}
                    frame = round(app.Spinner.Value);
                    figure
                    ax = gca;
                case 'export video'
                    frame = 1:numel(img(1,1,:));
                    figure(1)
                    ax = gca;
 
                case 'normal'
                    ax = app.UIAxes;
                    frame = round(app.Spinner.Value);
                    if ~app.MultiReferenceCheckBox.Value
                        cla(ax);
                    end
            end


            for iii = frame
                if numel(frame) < 2
                    iii=1;
                end
                if frame(iii) <= app.Spinner.Limits(2)
                    prev = img(:,:,frame(iii));
                else
                    prev = img(:,:,1);
                end


            if app.LoczShowfilterCheckBox.Value==1
                if strcmp(app.LoczHighpassDropDown.Value,'-Average')
                d_av = mean(img,3);
                prev = filter_movie(prev, app.LoczLowpassDropDown.Value, app.LoczLowpass.Value, app.LoczHighpassDropDown.Value,  app.LoczHighpass.Value,d_av);
                else
                prev = filter_movie(prev, app.LoczLowpassDropDown.Value, app.LoczLowpass.Value, app.LoczHighpassDropDown.Value,  app.LoczHighpass.Value);
                end
            end

            switch app.ZScaleDropBox.Value
                case 'Max Min'
                    minC = round(min(prev(:)),3,"significant");
                    maxC = round(max(prev(:)),3,"significant");
                    if minC<maxC
                        app.ContrastMinSpinner.Value = double(minC);
                        app.ContrastMaxSpinner.Value = double(maxC);
                    else
                        app.ContrastMinSpinner.Value = 0;
                        app.ContrastMaxSpinner.Value = 1;
                    end

                case 'Exc outliers'
                    B = rmoutliers(prev(:),"mean");
                    minC = round(min(B(:)),3,"significant");
                    maxC = round(max(B(:)),3,"significant");
                    if minC<maxC
                        app.ContrastMinSpinner.Value = double(minC);
                        app.ContrastMaxSpinner.Value = double(maxC);
                    else
                        app.ContrastMinSpinner.Value = 0;
                        app.ContrastMaxSpinner.Value = 1;
                    end
                case 'Histogram'
                        app.ContrastMinSpinner.Value = app.SliderMin.Value;
                        app.ContrastMaxSpinner.Value = app.SliderMax.Value;
                case 'Manual'
            end


            if app.ContrastMinSpinner.Value<app.ContrastMaxSpinner.Value
            zcont = [app.ContrastMinSpinner.Value app.ContrastMaxSpinner.Value];
            else
                zcont =[0 1];
            end

            if strcmp(app.PlotTypeDropDown.Value,'2D surface')
               if ~app.MultiReferenceCheckBox.Value
                    hold(ax,'on')
                   im = imagesc(ax,single(prev),zcont);
                    view(ax,2)
               else
                   hold(ax, 'on')
                   im = findobj(app.UIAxes, 'type', 'image');
                   view(ax,2)
               end
                if strcmp(app.AspectRatioSwitch.Value, '1:1')
                      axis(ax,'normal');
                    pbaspect(ax,[1 1 1])
                else
                    axis(ax,'tight','equal');
                end

                if strcmp(app.ViewpixelsDropDown.Value,'Original')
                    im.Interpolation= 'nearest';
                else
                    im.Interpolation= 'bilinear';
                end


                if app.ScalebarCheckBox.Value ==1
                    [r, cs, ~] = size(img(:,:,1));
                    sb = cs./app.ImageInfo.PixelPerNm;
                    try
                        scale_bar = round(sb/5,1,"significant");
                        scale_bar_pix = scale_bar.*app.ImageInfo.PixelPerNm;

                        switch app.label.ScaleBar.position
                            case 'Top Right'
                                xpos = [round(cs.*0.95)-scale_bar_pix, round(cs.*0.95)];
                                ypos = round([r*.05, r*.05]);
                            case 'Top Left'
                                xpos = [round(cs.*0.05), round(cs.*0.05)+scale_bar_pix];
                                ypos = round([r*.05, r*.05]);
                            case 'Bottom Left'
                                xpos = [round(cs.*0.05), round(cs.*0.05)+scale_bar_pix];
                                ypos = round([r*.95, r*.95]);
                            case 'Bottom Right'
                                xpos = [round(cs.*0.95)-scale_bar_pix, round(cs.*0.95)];
                                ypos = round([r*.95, r*.95]);
                        end

                        line(ax,xpos,ypos,'LineWidth',2,'Color',app.label.ScaleBar.color);
                        if scale_bar >1000
                    
                        text(ax, xpos(1)+scale_bar_pix/2, round(ypos(1) - r*.03), [num2str(scale_bar/1000) char(181),'m'],...
                            'FontWeight','bold','FontSize', 15,'Color', app.label.ScaleBar.color,'HorizontalAlignment','center');
                        else
                        text(ax, xpos(1)+scale_bar_pix/2, round(ypos(1) - r*.03), [num2str(scale_bar) 'nm'],...
                            'FontWeight','bold','FontSize', 15,'Color', app.label.ScaleBar.color,'HorizontalAlignment','center');
                        end
                    catch
                    end
                end
      
                if app.TimescaleCheckBox.Value==1
                    [r, cs, ~] = size(img(:,:,1));
                    try
                            time = round((frame(iii)-1)/app.ImageInfo.ScanSpeed,4,"significant");

                        switch app.label.TimeStamp.position
                            case 'Top Right'
                                xpos = round(cs*.90);
                                ypos = round(r*.05);
                            case 'Top Left'
                                xpos = round(cs*.05);
                                ypos = round(r*.05);
                            case 'Bottom Left'
                                xpos = round(cs*.05);
                                ypos = round(r*.95);
                            case 'Bottom Right'
                                xpos = round(cs*.90);
                                ypos = round(r*.95);
                        end
                        text(ax,xpos(1),ypos(1),[num2str(time) 's'],'FontWeight','bold','FontSize', 17,'Color',app.label.TimeStamp.color);
                    catch
                    end
                end
          
                if app.PreviewPeaks.Value ==1
                    hold(ax,'on')
                    if app.FilterImgEditField_Detect.Value >0
                        prev = imgaussfilt(prev,app.FilterImgEditField_Detect.Value);
                    end
                    locs = peaks2D(prev, app.Min_h_Edit.Value, app.Peaks_minSep.Value);
                    s = any(locs);
                    if s(1)==0
                    else
                        plot(ax,locs(:,1),locs(:,2), 'cx','MarkerSize',7,'LineWidth',1)
                    end
                    hold(ax,'off')
                end

                switch app.OverlayDropDown.Value
                    case 'None'
                         hold(ax,'off')
                         app.PreviewThresholdCheck.Value = 0;
                    case 'Detections'
                        hold(ax,'on')
                        app.PreviewThresholdCheck.Value = 0;

                        pos = app.Part.Locs(:,5) == frame(iii);
                        pos = (pos.*app.Part.IncludeImages)>0;

                        if app.MarkersCheckBox.Value == 1
                            if app.MultiReferenceCheckBox.Value
                                for i = 1:app.RefNo
                                    colourmapReferences = hsv(app.RefNo); 
                                    colour = colourmapReferences(i, :);
                                    plot(ax,app.Part.Locs(pos,1),app.Part.Locs(pos,2),...
                                        'go','MarkerSize',8,'LineWidth',2,...
                                        'MarkerFaceColor',colour)
                                end
                            else
                                plot(ax,app.Part.Locs(pos,1),app.Part.Locs(pos,2),...
                                    'go','MarkerSize',8,'LineWidth',2,...
                                    'MarkerFaceColor','r')
                            end
                        end
                       
                        
                        if app.BoxesCheckBox.Value == 1
                            if app.MultiReferenceCheckBox.Value
                                for i = 1:app.RefNo
                                    % Get the position array for the current reference
                                    positionArray = app.ref.positions{i};
                                    
                                    % Extract the frame width and height from the position array
                                    current_frame_width = positionArray(3);
                                    current_frame_height = positionArray(4);
                                    
                                    % Calculate the vertices for the current reference
                                    vertices = [current_frame_width/2, current_frame_height/2;    % top right
                                                -current_frame_width/2, current_frame_height/2;   % top left
                                                -current_frame_width/2, -current_frame_height/2;  % bottom left
                                                current_frame_width/2, -current_frame_height/2];  % bottom right
        
                                    % Store the vertices for the current reference in the cell array
                                    verticesCellArray{i} = vertices;
                                end
    
                                for pointIdx = 1:app.RefNo
                                    x = app.Part.Locs(pointIdx, 1);
                                    y = app.Part.Locs(pointIdx, 2);
                                    
                                    % Find the reference index with the maximum correlation for each point
                                    [~, maxCorrRefs] = max(app.Part.Locs, [], 2);
                                    % Get the frame width and height for the current reference
                                    refIndex = maxCorrRefs(pointIdx);

                                    angle_rad = app.Part.Locs(pointIdx, 8) * pi / 180;
                                    
                                    vertices = verticesCellArray{refIndex};
                                   
                                    R = [cos(angle_rad), -sin(angle_rad); sin(angle_rad), cos(angle_rad)];
                                    vertices_rot = (R * vertices')';
                                    vertices_trans = vertices_rot + [x, y];

                                    colourIndex = refIndex;
                                    colourmapReferences = hsv(app.RefNo); 
                                    colour = colourmapReferences(colourIndex, :);
                                    
                                    % Has an issue when trying to change the limits of the correlation 
                                    % Also need to find a way the user can identify which reference is which colour
                              
                                    patch(ax, 'vertices', vertices_trans, 'faces', [1, 2, 3, 4], 'EdgeColor', colour, 'FaceColor', 'w', 'FaceAlpha', 0.15);
                                end
                            else
                                x = app.Part.Locs(pos,1);
                                y = app.Part.Locs(pos,2);
                                frame_width = app.ref.position(3);
                                frame_height = app.ref.position(4);
                                angle_rad = app.Part.Locs(pos,8) * pi / 180;
                                vertices = [frame_width/2, frame_height/2;  % top right
                                    -frame_width/2, frame_height/2; % top left
                                    -frame_width/2, -frame_height/2; % bottom left
                                    frame_width/2, -frame_height/2]; % bottom right
    
                                for i = 1:numel(x)
                                   cent = [x(i), y(i)];
                                   R = [cos(angle_rad(i)), -sin(angle_rad(i)); sin(angle_rad(i)), cos(angle_rad(i))];
                                   vertices_rot = (R * vertices')';
                                   vertices_trans = vertices_rot + cent;
                                   patch(ax,'vertices',vertices_trans,'faces',[1,2,3,4],'EdgeColor','g','FaceColor','w','FaceAlpha',0.15 )
                                end
                            end
                        end
                        
                    
                       switch app.OverlayValues.Value
                           case 'None'
                           case 'Height'
                                p = round(app.Part.Locs(pos,3),1);
                           case 'CCR'
                                p = round(app.Part.Locs(pos,4),2);
                           case 'Angle'
                               p = round(app.Part.Locs(pos,8),1);
                           case 'Track Number'
                              p = app.Part.Locs(pos,7);
                       end

                       switch app.OverlayValues.Value
                           case 'None'
                           otherwise
                               x = app.Part.Locs(pos,1);
                               y = app.Part.Locs(pos,2);
                               for i = 1:numel(x)
                                   text(ax,x(i)+4,y(i),num2str(p(i)),'Color','r','FontSize',12)
                               end
                       end

                        if app.TrackLengthEditField.Value>0 && numel(app.Part.Locs(1,:))>6
                   
                            x = app.Part.Locs(pos,1);
                            p = app.Part.Locs(pos,7);

                            if frame(iii)<app.TrackLengthEditField.Value+1
                                for j = 1:numel(x)
                                    pos2 = app.Part.Locs(:,7)==p(j);
                                    xtemp = app.Part.Locs(pos2,1);
                                    ytemp = app.Part.Locs(pos2,2);
                                    pos3 = app.Part.Locs(pos2,5)<=frame(iii);
                                    plot(ax,xtemp(pos3),ytemp(pos3),'o-')
                                end
                            else
                                for j = 1:numel(x)
                                    pos2 = app.Part.Locs(:,7)==p(j);
                                    xtemp = app.Part.Locs(pos2,1);
                                    ytemp = app.Part.Locs(pos2,2);
                                    pos3 = app.Part.Locs(pos2,5)<=frame(iii) & app.Part.Locs(pos2,5)>=frame(iii)-app.TrackLengthEditField.Value;
                                    plot(ax,xtemp(pos3),ytemp(pos3),'o-')
                                end
                            end
                        end
                        

                        if ~app.MultiReferenceCheckBox.Value
                            hold(ax,'off')
                        end

                    case 'Line Profile'
                        app.PreviewThresholdCheck.Value = 0;
                     C = hsv(8);
                     C = [C ;   jet(8)];
                     C = [C ;   parula(8)];
                     hold(ax,'on')
                     for jj=1:numel(app.LineROI)
                         xpos = app.LineROI(jj).Position(:,1);
                         ypos = app.LineROI(jj).Position(:,2);
                         line(ax,xpos,ypos,'LineWidth',1,'Color',C(jj,:));
                     end
                     hold(ax,'off')


                    case 'Threshold'
                      app.PreviewThresholdCheck.Value = 1;
                               high_thresh = app.SliderMax.Value;%/100.*(max_all-min_all)+min_all;
                               low_thresh = app.SliderMin.Value;%/100.*(max_all-min_all)+min_all;
                               prev = app.ImageTarget(:,:,frame(iii));

                               imgt = thresholder(prev,app.ThresholdMethod.Value,[low_thresh,high_thresh],app.InvertSelected.Value);
                               s = any(app.ThresholdROI);
                               if app.ROIThresholdButton.Value == 1 && s(1)==1
                                   imgt = thresholder(app.ThresholdROI.*imgt,'selection',[low_thresh,high_thresh],app.InvertSelected.Value);
                               end
                               hold(ax,'on')
                               try
                                   visboundaries(ax,isnan(imgt));
                               catch
                               end
                               hold(ax,'off')

                    case 'Localizations'
                        app.PreviewThresholdCheck.Value = 0;
                        hold(ax,'on')
                        if app.LoczImagepeaksCheckBox.Value==1
                            if app.LoczShowfilterCheckBox.Value==1

                            else
                                if frame(iii) <= app.Spinner.Limits(2)
                                    prev = img(:,:,frame(iii));
                                else
                                    prev = img(:,:,1);
                                end

                                if strcmp(app.LoczHighpassDropDown.Value,'-Average')
                                    d_av = mean(img,3);
                                    prev = filter_movie(prev, app.LoczLowpassDropDown.Value, app.LoczLowpass.Value, app.LoczHighpassDropDown.Value,  app.LoczHighpass.Value,d_av);
                                else
                                    prev = filter_movie(prev, app.LoczLowpassDropDown.Value, app.LoczLowpass.Value, app.LoczHighpassDropDown.Value,  app.LoczHighpass.Value);
                                end
                            end

                            locs = peaks2D(prev,app.LoczHeightSpinner.Value,app.LoczMinSep.Value,app.LoczProminenceSpinner.Value);
                            s = any(locs);
                            if s(1)==0
                            else
                                plot(ax,locs(:,1),locs(:,2), 'cx','MarkerSize',7,'LineWidth',1)
                            end
                            hold(ax,'off')
                        end
                end
            elseif strcmp(app.PlotTypeDropDown.Value,'3D surface')
                set(ax,'visible','on')
                surf(ax,prev)
                shading(ax,'interp')
                axis(ax,'normal');

            elseif strcmp(app.PlotTypeDropDown.Value,'Coordinates')
                set(ax,'visible','on')
                sd=size(prev);
                [x, y]=find(prev(1:sd(1),1:sd(2)));
                for i = 1:numel(x)
                    z(i) = prev(y(i),x(i));
                end
                scatter3(ax,x,y,z,10,z,'filled')
                axis(ax,'normal');
            end


            switch app.ColourmapDropDown.Value
                case 'AFM brown'
                    colormap(ax,app.cmap.AFM_brown)
                case 'AFM gold'
                    colormap(ax,app.cmap.AFM_orange)
                case'fire'
                    colormap(ax,app.cmap.AFM_fire)
                otherwise
                    colormap(ax,app.ColourmapDropDown.Value)
            end

            switch  app.LeftPlotList.Value
                case 'Preview'
                    [r, cs, ~] = size(img(:,:,1));
                    xpos(1) = round(cs*.05);
                    ypos(1) = round(r*.95);
                    text(ax,xpos(1),ypos(1),'PREVIEW','FontWeight','bold','FontSize', 24,'Color',[0.5 0.5 0.5]);
            end

set(ax,'visible','off','YDir','reverse')
            switch varargin{1}
                case {'export video','export frame'}
                  hold(ax,'on')
                    if iii == 1
                        namesplit = split(app.ImageName,'.');
                        namesuggest = join(namesplit,"_");
                        filetype = app.ExportFileFormat.Value;
                        [outputFileName,folder] = uiputfile([namesuggest{1},filetype]);
                        fullFileName = fullfile(folder, outputFileName);
                        set(figure(1),'color',app.ExportSettings.color)
                        if app.ColorBarCheckBox.Value==1
                            if strcmp(app.ExportSettings.color,'white')
                                colorbar(ax,'Color','k','Box','off','TickDirection','out')
                            else
                                colorbar(ax,'Color','w','Box','off','TickDirection','out')
                            end
                        end
                        
                    end

                    if app.ColorBarCheckBox.Value==1
                        im = getframe(figure(1));
                    else
                        im = getframe(gca);
                    end
                    
                    switch varargin{2}
                        case '.avi'
                            if iii == 1
                                v = VideoWriter(fullFileName,'Motion JPEG AVI');
                                v.FrameRate  = app.fps.Value;
                            end
                            open(v);
                            writeVideo(v,im);
                        case '.gif'
                            [imind,cm] = rgb2ind(im.cdata,256);
                            if iii == 1
                                imwrite(imind,cm,fullFileName,'gif', 'DelayTime',1/app.fps.Value,'Loopcount',inf);
                            else
                                imwrite(imind,cm,fullFileName,'gif','WriteMode','append', 'DelayTime',1/app.fps.Value);
                            end
                        case {'.png','.jpeg','.pdf','.svg'}
                            exportgraphics(gcf,fullFileName,'BackgroundColor','current', 'Resolution',app.ExportSettings.resolution);
                    end
                     cla(ax)
            end


            end % end of for loop for export movie
            if numel(varargin)>1
                switch varargin{2}
                    case '.avi'
                        close(v)
                    otherwise 
                        close
                end
            end

            end

%end of updatePlot 1 -------------------------------------

function updateRightPlot(app)
    switch app.RightPlotList.Value
        case 'Off'
            updatePlot2_type(app,'image')
        case 'Line Profile'
            updatePlot2_type(app,'plot')
        case 'Ref Image'
            updatePlot2_type(app,'image')
        case 'Localizations'
            updatePlot2_type(app,'image')
        case {'LAFM','LAFM sym'}
            updatePlot2_type(app,'image')
    end

    updatePlot2(app,'normal')
end

        function updatePlot2_type(app,type)
            switch type
                case 'image'
                    set(app.UIAxes_2,'visible','off')
                    axis(app.UIAxes_2,'tight','equal');
                    set(app.UIAxes_2,'Color','k')
                    app.UIAxes_2.XTick = [];
                    app.UIAxes_2.XTickLabelRotation = 0;
                    app.UIAxes_2.XTickLabel = '';
                    app.UIAxes_2.YTick = [];
                    app.UIAxes_2.YTickLabelRotation = 0;
                    app.UIAxes_2.YTickLabel = '';
                    grid(app.UIAxes_2,'off')
                    app.UIAxes_2.XLabel = [];
                    app.UIAxes_2.YLabel = [];
                    app.UIAxes_2.Position =  [app.UIAxes_2.Position(1),  app.UIAxes.Position(2), app.UIAxes.Position(3),app.UIAxes.Position(3)];
           
 

                case 'plot'
                    axis(app.UIAxes_2, 'normal');
                    set(app.UIAxes_2,'YDir','normal');
                    set(app.UIAxes_2,'Color','k')
                    colorbar(app.UIAxes_2,'off')
                    set(app.UIAxes_2,'visible','on')
                    set(app.UIAxes_2,'fontname','Ariel','fontsize', 14,'TickDir','out')
                    app.UIAxes_2.YColor = 'w';
                    app.UIAxes_2.XColor = 'w';
                    app.UIAxes_2.XTickMode = 'auto';
                    app.UIAxes_2.XTickLabelMode = 'auto';
                    app.UIAxes_2.YTickMode = 'auto';
                    app.UIAxes_2.YTickLabelMode = 'auto';
                    grid(app.UIAxes_2,'on')
                    grid(app.UIAxes_2,'minor')
                    app.UIAxes_2.MinorGridLineStyle = '-';
                    app.UIAxes_2.MinorGridAlpha = 0.05;
                    app.UIAxes_2.GridAlpha = 0.2;
                    app.UIAxes_2.GridColor = 'k';
                    if app.UIAxes_2.Position(4) == app.UIAxes_2.Position(3)
                    dh = app.UIAxes_2.Position(4)/3.5;
                app.UIAxes_2.Position =  [app.UIAxes_2.Position(1),  app.UIAxes.Position(2) + dh, app.UIAxes.Position(3),app.UIAxes.Position(4)-dh];
                    end
            end

        end

 % Update Plot 2 -------------------------------------

        function updatePlot2(app,varargin)
            switch app.RightPlotList.Value
                case 'Line Profile'
                    switch  app.FramePartSwitch.Value
                        case 'Frames'
                            switch  app.LeftPlotList.Value
                                case 'Target'
                                    img = app.ImageTarget;
                                case 'Preview'
                                    img = app.ImagePreview;
                            end
                        case 'Particles'
                            img = app.Part.Image(:,:,app.Part.IncludeImages);
                    end
                    
            end

            switch varargin{1}
                case {'popout','export frame'}
                    frame = round(app.Spinner.Value);
                    figure(1)
                    ax = gca;
                case 'export video'
                    frame = 1:numel(img(1,1,:));
                    figure(1)
                    ax = gca;
 
                case {'normal','live'}
                    ax = app.UIAxes_2;
                    frame = round(app.Spinner.Value);
                    cla(ax);
            end

            for iii = frame
                if numel(frame) < 2
                    iii=1;
                end

            switch app.RightPlotList.Value
                case 'Hist'
                otherwise
                    app.HistPlot.Value =0;
                    app.HistBin.Visible = 0;
                    app.HistValue.Visible = 0;
            end

            switch app.RightPlotList.Value
                case 'Off'
                    colorbar(ax,'off')
                     app.LAFMPanel.Visible = 0;
                     app.UITable2.Visible = 0;
                     app.LineProfilePanel.Visible = 0;
                case 'Line Profile'
                    app.LAFMPanel.Visible = 0;
                     app.UITable2.Visible = 1;
                     app.LineProfilePanel.Visible = 1;
                     prev = img(:,:,frame(iii));

                   %  try
                        
                     C = hsv(8);
                     C = [C ;   jet(8)];
                     C = [C ;   parula(8)];
                     currentmin = Inf;
                     currentmax = -Inf;
                     for jj=1:numel(app.LineROI)
                        
                             [cx,cy,ch] = improfile(prev,app.LineROI(jj).Position(:,1),app.LineROI(jj).Position(:,2));
                             try
                                 if app.ImageInfo.PixelPerNm>0
                                     dist = (((cx(1)-cx(end))^2 + (cy(1)-cy(end))^2)^0.5)./app.ImageInfo.PixelPerNm;
                                 else
                                     dist = ((cx(1)-cx(end))^2 + (cy(1)-cy(end))^2)^0.5;
                                 end

                             catch
                                 dist = ((cx(1)-cx(end))^2 + (cy(1)-cy(end))^2)^0.5;
                             end

                             if  app.Live.Value==1
                                 app.LineROI(jj).Profile =[];
                                 app.LineROI(jj).Profile(:,1)= linspace(0,dist,numel(ch))';
                                 app.LineROI(jj).Profile(:,2) = ch;

                             elseif ~isfield(app.LineROI(jj),'Profile') ||  strcmp(varargin{1},'live')
                                 app.LineROI(jj).Profile =[];
                                 app.LineROI(jj).Profile(:,1)= linspace(0,dist,numel(ch))';
                                 app.LineROI(jj).Profile(:,2) = ch;
                             end

                         plot(ax,app.LineROI(jj).Profile(:,1),app.LineROI(jj).Profile(:,2),'-','LineWidth',1.5,'Color',C(jj,:))
                         hold(ax,'on')
                         currentmin = min([min(ch); currentmin]);
                         currentmax = max([max(ch); currentmax]);
                     end
                        hold(ax,'off')
                        increase = 0.05 * range([currentmin, currentmax]);
                        newLimits = [currentmin - increase, currentmax + increase];
                        if  strcmp(varargin{1},'live') || app.Live.Value==1
                            ylim(ax, newLimits);
                        end
                        xlabel(ax,'Distance (nm)')
                        ylabel(ax,'Height (nm)')
                    % catch
                    % 
                    % end


                case 'Ref Image'
                     app.LAFMPanel.Visible = 0;
                     app.UITable2.Visible = 0;
                     app.LineProfilePanel.Visible = 0;
                     app.RefCropButton.Visible = 1;
                     app.MultiReferenceCheckBox.Visible = 1;
                     if app.MultiReferenceCheckBox.Value == 1
                         app.ReferenceButtonGroup.Visible = 1;
                         app.DropDown.Visible = 0;
                         num = app.ReferenceButtonGroup.SelectedObject.Text;
                         index = str2double(num);
                         if isfield(app.ref, 'crop') == 1
                             try
                                app.ref.image = app.ref.croppedimg{index};
                                clim = [min(app.ref.image(:)),max(app.ref.image(:))];    
                                imagesc(ax,single(app.ref.image),clim)
                             catch
                                 app.ref.image = app.ref.images(index);
                                 clim = [min(app.ref.image{1}(:)),max(app.ref.image{1}(:))];    
                                imagesc(ax,single(app.ref.image{1}),clim)
                             end
                         else
                            app.ref.image = app.ref.images(index);
                            clim = [min(app.ref.image{1}(:)),max(app.ref.image{1}(:))];    
                            imagesc(ax,single(app.ref.image{1}),clim)
                         end 
                         
                     else
                         app.ReferenceButtonGroup.Visible = 0;
                         app.DropDown.Visible = 1;
                         switch app.DropDown.Value
                            case 'ROI Reference'
                                if ~isempty(app.ref.ROIimage)
                                    app.ref.image = app.ref.ROIimage;
                                end    
                            case 'Simulated Reference'  
                                if ~isempty(app.ref.simImage) || isvalid(app.ref.simImage)
                                    app.ref.image = app.ref.simImage;
                                end 
                            case 'LAFM Reference'  
                                if ~isempty(app.ref.LAFM) || isvalid(app.ref.LAFM)
                                    app.ref.image = imresize(app.ref.LAFM,[100,100]);
                                end
                            case 'Averaged Reference'
                                app.ref.image = app.ref.av;
                         end
                         clim = [min(app.ref.image(:)),max(app.ref.image(:))];
                         imagesc(ax,single(app.ref.image),clim)
                     end

                    switch app.ColourmapDropDown.Value
                        case 'AFM brown'
                            colormap(ax,app.cmap.AFM_brown)
                        case 'AFM gold'
                            colormap(ax,app.cmap.AFM_orange)
                        case'fire'
                            colormap(ax,app.cmap.AFM_fire)
                        otherwise
                            colormap(ax,app.ColourmapDropDown.Value)
                    end
                case 'Hist'
                    app.LAFMPanel.Visible = 0;
                    app.UITable2.Visible = 0;
                    app.LineProfilePanel.Visible = 0;
                    bins = str2num(app.HistBin.Value);
                    try
                        switch app.HistValue.Value
                            case 'Particle Height'
                                histogram(ax,app.Part.Locs(app.Part.IncludeImages,3),bins)
                                    
                        xlabel(ax,'Height (nm)')
                            case 'Particle CCR'
                                histogram(ax,app.Part.Locs(app.Part.IncludeImages,4),bins)
                                 xlabel(ax,'Correlation Coefficient')
                            case 'Particle Angle'
                                histogram(ax,app.Part.Locs(app.Part.IncludeImages,8),bins)
                               xlabel(ax,'Particle Angle (degrees)')
                            case 'Radial distribution'
                                histogram(ax,app.RadialDist ,bins)
                                xlabel(ax,'Distance (nm)')
                        end
                    catch 
                    end

                case 'Localizations'
                    app.LAFMPanel.Visible = 0;
                    hold(ax,'on')
                    s = any(app.LAFM.Locs);
                    if s(1)==0
                    else
                        plot(ax,app.LAFM.Locs(:,1),app.LAFM.Locs(:,2),'r.')
                        %  h=  (app.LAFM.Locs(:,3)-min(app.LAFM.Locs(:,3)))/(max(app.LAFM.Locs(:,3))-min(app.LAFM.Locs(:,3)));
                        scatter(ax,app.LAFM.Locs(:,1),app.LAFM.Locs(:,2),'r','filled','MarkerFaceAlpha',0.1)
                        % ylim(ax,[1 size(img,1)])
                        % xlim(ax,[1 size(img,2)])
                    end
                    hold(ax,'off')

                case 'LAFM'
                     app.LAFMPanel.Visible = 1;
                     app.UITable2.Visible = 0;
                     app.LineProfilePanel.Visible = 0;
                    t = app.LAFM.Image;
                    if strcmp(app.LAFM_LUT.Value,'LAFM')
                        scaledImage = (t-app.LAFMMinSlider.Value)/(app.LAFMMaxSlider.Value - app.LAFMMinSlider.Value);
                        imagesc(ax, scaledImage)
                    else

                        clim = [app.LAFMMinSlider.Value, app.LAFMMaxSlider.Value];
                        imagesc(ax, t,clim)
                        colormap(ax,app.LAFM_LUT.Value)
                    end

                    set(ax,'visible','off')
                    axis(ax,'tight','equal');

                case 'LAFM sym'  
                     app.LAFMPanel.Visible = 1;
                     app.UITable2.Visible = 0;
                     app.LineProfilePanel.Visible = 0;
                      t = app.LAFM.Image_sym;
                  if strcmp(app.LAFM_LUT.Value,'LAFM')
                      scaledImage = (t-app.LAFMMinSlider.Value)/(app.LAFMMaxSlider.Value - app.LAFMMinSlider.Value);
                      imagesc(ax, scaledImage)
                  else
                      clim = [app.LAFMMinSlider.Value, app.LAFMMaxSlider.Value];
                      imagesc(ax, t, clim)
                      colormap(ax,app.LAFM_LUT.Value)
                  end

                     set(ax,'visible','off')
                     axis(ax,'tight','equal');

                case 'x & y Align'
                     app.LAFMPanel.Visible = 0;
                    updatePlot2_type(app,'plot')
                    if any(app.img_locs)
                        plot(ax,app.img_locs(:,1),'x-')
                        hold(ax,'on')
                        plot(ax,app.img_locs(:,2),'v-')
                        hold(ax,'off')
                    end

                case 'Time Profile'
                    switch  app.FramePartSwitch.Value
                        case 'Frames'
                            switch  app.LeftPlotList.Value
                                case 'Target'
                                    img = app.ImageTarget;
                                case 'Preview'
                                    img = app.ImagePreview;
                            end
                        case 'Particles'
                            img = app.Part.Image(:,:,app.Part.IncludeImages);
                    end

                    sd = size(img);
                    [x, y] = meshgrid(1:sd(2), 1:sd(1));
                    distances = sqrt((x - app.CircleROI.Position(2)).^2 + (y - app.CircleROI.Position(3)).^2);
                    inside_circle = distances <= app.CircleROI.Position(1);
                
         
                    for k = 1:sd(3)
                        temp = img(:,:,k);
                        roi_pixels = temp(inside_circle);
                        app.CircleROI.Profile(k) = mean(roi_pixels);
                    end
                    plot(ax, app.CircleROI.Profile)

                case 'Kymograph'
                    app.LAFMPanel.Visible = 0;
                    app.UITable2.Visible = 0;
                    app.LineProfilePanel.Visible = 0;

                    imagesc(ax, app.LineROI(1).kymo, [app.ContrastMinSpinner.Value app.ContrastMaxSpinner.Value])
                    switch app.ColourmapDropDown.Value
                        case 'AFM brown'
                            colormap(ax,app.cmap.AFM_brown)
                        case 'AFM gold'
                            colormap(ax,app.cmap.AFM_orange)
                        case'fire'
                            colormap(ax,app.cmap.AFM_fire)
                        otherwise
                            colormap(ax,app.ColourmapDropDown.Value)
                    end
                    axis(ax,'normal');
            end

            switch app.RightPlotList.Value
                case {'LAFM sym', 'LAFM'}
                    if app.LAFMScalebarCheckBox.Value ==1
                         if strcmp(app.LAFM_LUT.Value,'LAFM')
                          t = rgb2gray(t);
                         end           
                        [r, cs] = size(t);
                        sb = cs./app.ImageInfo.PixelPerNm/app.LAFM_exp.Value;
                        try
                            scale_bar = round(sb/5,1,"significant");
                            scale_bar_pix = scale_bar.*app.ImageInfo.PixelPerNm*app.LAFM_exp.Value;

                            switch app.label.LAFMScaleBar.position
                                case 'Top Right'
                                    xpos = [round(cs.*0.95)-scale_bar_pix, round(cs.*0.95)];
                                    ypos = round([r*.05, r*.05]);
                                case 'Top Left'
                                    xpos = [round(cs.*0.05), round(cs.*0.05)+scale_bar_pix];
                                    ypos = round([r*.05, r*.05]);
                                case 'Bottom Left'
                                    xpos = [round(cs.*0.05), round(cs.*0.05)+scale_bar_pix];
                                    ypos = round([r*.95, r*.95]);
                                case 'Bottom Right'
                                    xpos = [round(cs.*0.95)-scale_bar_pix, round(cs.*0.95)];
                                    ypos = round([r*.95, r*.95]);
                            end

                            line(ax,xpos,ypos,'LineWidth',2,'Color',app.label.LAFMScaleBar.color);
                            if scale_bar >1000

                                text(ax, xpos(1)+scale_bar_pix/2, round(ypos(1) - r*.03), [num2str(scale_bar/1000) char(181),'m'],...
                                    'FontWeight','bold','FontSize', 15,'Color', app.label.LAFMScaleBar.color,'HorizontalAlignment','center');
                            else
                                text(ax, xpos(1)+scale_bar_pix/2, round(ypos(1) - r*.03), [num2str(scale_bar) 'nm'],...
                                    'FontWeight','bold','FontSize', 15,'Color', app.label.LAFMScaleBar.color,'HorizontalAlignment','center');
                            end
                        catch
                        end
                    end
            end



            switch varargin{1}
                case {'export video','export frame'}
                    hold(ax,'on')
                    if iii == 1
                        namesplit = split(app.ImageName,'.');
                        namesuggest = join(namesplit,"_");
                        filetype = app.ExportFileFormat.Value;
                        [outputFileName,folder] = uiputfile([namesuggest{1},filetype]);
                        fullFileName = fullfile(folder, outputFileName);
                        set(figure(1),'color',app.ExportSettings.color)
                    end

                    switch varargin{3}
                        case 'plot'
                            axis tight
                            if strcmp(app.ExportSettings.color,'white')
                                set(figure(1),'color','w')
                                set(gca,'Tickdir','out','fontsize',12,'YDir','normal','XColor','k','YColor','k')
                            else
                                set(figure(1),'color','k')
                                set(gca,'Tickdir','out','fontsize',12,'YDir','normal','XColor','w','YColor','w')
                            end
                            im = getframe(figure(1));

                        case 'image'
                             set(ax,'visible','off')
                            if app.ColorBarCheckBox.Value==1
                                im = getframe(figure(1));
                            else
                                im = getframe(gca);
                            end
                    end


                    switch varargin{2}
                        case '.avi'
                            if iii == 1
                                v = VideoWriter(fullFileName,'Motion JPEG AVI');
                                v.FrameRate  = app.fps.Value;
                            end
                            open(v);
                            writeVideo(v,im);
                        case '.gif'
                            [imind,cm] = rgb2ind(im.cdata,256);
                            if iii == 1
                                imwrite(imind,cm,fullFileName,'gif', 'DelayTime',1/app.fps.Value,'Loopcount',inf);
                            else
                                imwrite(imind,cm,fullFileName,'gif','WriteMode','append', 'DelayTime',1/app.fps.Value);
                            end
                        case {'.png','.jpeg','.pdf','.svg'}
                            exportgraphics(gcf,fullFileName,'BackgroundColor','current', 'Resolution',app.ExportSettings.resolution);
                    end
            end
            end % end of for loop for export movie
            if numel(varargin)>1
                switch varargin{2}
                    case '.avi'
                        close(v)
                end
            end

        end

%
        function updateHist(app)
           
            if app.Hist_excludeOut.Value ==1
                T = reshape(app.ImageTarget(:,:,:),1,[]);
               T = rmoutliers(T,"percentiles",[5 95]);
            else
                T = app.ImageTarget(:,:,:);
            end
            histogram(app.Hist_Axes,T,100,'EdgeColor','None','FaceColor',[0.5 0.5 0.5]);
            if app.LogYHist.Value==1
                set(app.Hist_Axes, 'YScale', 'log')
            else
                set(app.Hist_Axes, 'YScale', 'linear')
            end
            app.patches.histup = patch(app.Hist_Axes,[app.SliderMax.Limits(2) app.SliderMax.Value app.SliderMax.Value app.SliderMax.Limits(2)], [app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(1),  app.Hist_Axes.YLim(2)  app.Hist_Axes.YLim(2)],...
                'r', 'FaceAlpha', 0.5,'EdgeColor','none');
            app.patches.histdown = patch(app.Hist_Axes,[app.SliderMin.Value app.SliderMin.Limits(1) app.SliderMin.Limits(1) app.SliderMin.Value], [app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(1),  app.Hist_Axes.YLim(2)  app.Hist_Axes.YLim(2)],...
                'r', 'FaceAlpha', 0.5,'EdgeColor','none');
        end

        function updateCCRHist(app)

            switch app.Height_corr_switch.Value
                case 'Height'
                    histogram(app.HeightCCRHist, app.Part.Locs(:,3) ,50,'EdgeColor','None','FaceColor',[0.5 0.5 0.5]);
                    app.CCRSliderMax.Limits = [min(app.Part.Locs(:,3)), max(app.Part.Locs(:,3))];
                    app.CCRSliderMin.Limits = [min(app.Part.Locs(:,3)), max(app.Part.Locs(:,3))];
                    app.CCRSliderMin.Value = [app.Min_h_Edit.Value];
                    app.CCRSliderMax.Value = [app.Max_h_Edit.Value];
                     app.CCRSliderMax.Value = [app.CCRSliderMax.Limits(2)];
                          xlim(app.HeightCCRHist,app.CCRSliderMin.Limits)
                case 'Correlation'
                    histogram(app.HeightCCRHist, app.Part.Locs(:,4)  ,50,'EdgeColor','None','FaceColor',[0.5 0.5 0.5]);
                     if any(app.Part.Locs(1,4))
                     app.CCRSliderMax.Limits = [app.Min_CCR_Edit.Value, app.Max_CCR_Edit.Value];
                    app.CCRSliderMin.Limits = [app.Min_CCR_Edit.Value, app.Max_CCR_Edit.Value];
                     end
                     app.CCRSliderMin.Value = [app.Min_CCR_Edit.Value];
                     app.CCRSliderMax.Value = [app.Max_CCR_Edit.Value];
                     xlim(app.HeightCCRHist,app.CCRSliderMin.Limits)
            end
           

            app.patches.ccrhistup = patch(app.HeightCCRHist,[app.CCRSliderMax.Limits(2) app.CCRSliderMax.Value app.CCRSliderMax.Value app.CCRSliderMax.Limits(2)], [app.HeightCCRHist.YLim(1), app.HeightCCRHist.YLim(1),  app.HeightCCRHist.YLim(2)  app.HeightCCRHist.YLim(2)],...
                'r', 'FaceAlpha', 0.5,'EdgeColor','none');
            app.patches.ccrhistdown = patch(app.HeightCCRHist,[app.CCRSliderMin.Value app.CCRSliderMin.Limits(1) app.CCRSliderMin.Limits(1) app.CCRSliderMin.Value], [app.HeightCCRHist.YLim(1), app.HeightCCRHist.YLim(1),  app.HeightCCRHist.YLim(2)  app.HeightCCRHist.YLim(2)],...
                'r', 'FaceAlpha', 0.5,'EdgeColor','none');

          
        end


        function im = Open_files(app)
            %check if edited image stored
            app.CancelButton.Visible = 1;
            app.stop = 0;
            imageName = [app.OpenFolder '/' app.FilesListBox.Value];           

            updateInterval = 5;
            cla(app.loadbar)

            rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
            progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', 'green');
            progressText = text(app.loadbar, 0.5, 0.5, '0%', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

            if isfolder(imageName)
                data = dir(fullfile(imageName));
                data = data(~ismember({data(:).name},{'.','..','.DS_Store'}));

                fileNames     = {data.name};
                pos = ~isfolder(fullfile(imageName,fileNames));
                fileNames = (fileNames(pos));

                if numel(fileNames)>0
                    namesplit = split(fileNames{1},'.');
                    filetype = namesplit{end};
                    if strcmp(filetype,'jpk')
                        ImageType = 'jpk';
                        if length(fileNames)>1
                            app.ImageInfo.n = length(fileNames)-1;
                        else
                            app.ImageInfo.n = length(fileNames);
                        end

                        if app.View1stCheckBox.Value ==1 && app.View1st.Value < app.ImageInfo.n
                            loadn = app.View1st.Value;
                        else
                            loadn = app.ImageInfo.n;
                        end
                        stepsPerUpdate = ceil(loadn * (updateInterval / 100));
                        updateVideoTools(app)

                        for ii = 1:loadn
                            if ii ==1
                                if app.stop == 1
                                    return
                                end
                                [info, ch] = open_JPK_info(fullfile(imageName,fileNames{ii}),'Height','ReTrace');
                                im = zeros(info.y_scan_pixels,info.x_scan_pixels,loadn);
                                im(:,:,ii) = 10*flip(-open_JPK_image(fullfile(imageName,fileNames{ii}),ch+1));
                                app.ImageTarget = im;
                                app.ImageInfo.LineSpeed = info.Scan_Rate;
                                app.ImageInfo.ScanSize = round(info.x_scan_length*1e9);
                                app.ImageInfo.yPixels = info.y_scan_pixels;
                                app.ImageInfo.xPixels = info.x_scan_pixels;
                                app.ImageInfo.PixelPerNm = app.ImageInfo.xPixels./app.ImageInfo.ScanSize;
                                app.ImageInfo.ScanSpeed = app.ImageInfo.LineSpeed./app.ImageInfo.yPixels.*(1.*(app.BidirectionaldataCheckBox.Value)+1);
                                updateTable(app)
                                updatePlot(app,'normal')
                                pause(0.001)
                                if app.ImageInfo.n == 1
                                    try
                                        if mod(ii, stepsPerUpdate) == 0 || ii == loadn
                                            progressBar.Position(3) = ii / loadn;
                                            progressText.String = sprintf('%d of %d images loaded', ii , loadn);
                                            drawnow;
                                        end
                                    catch
                                    end
                                end
                            else
                                try
                                if mod(ii, stepsPerUpdate) == 0 || ii == loadn
                                    progressBar.Position(3) = ii / loadn;
                                    progressText.String = sprintf('%d of %d images loaded', ii , loadn);
                                    drawnow;
                                end
                                catch
                                end
                                im(:,:,ii) = 10*flip(-open_JPK_image(fullfile(imageName,fileNames{ii}),ch+1));

                        
                            end
                        end
                    else

                        %open nanoSCOPE

                        fid = fopen(fullfile(imageName,fileNames{1}),'r');
                        line = fgets(fid);
                        fclose(fid);
                        if      length(strfind(line,'\*File list'))>=1
                            ImageType = 'NanoScope';
                            app.ImageInfo.n = length(fileNames);
                            updateVideoTools(app)
                        if app.View1stCheckBox.Value ==1 && app.View1st.Value < app.ImageInfo.n
                            loadn = app.View1st.Value;
                        else
                            loadn = app.ImageInfo.n;
                        end

                            for ii = 1:loadn
                                if ii ==1
                                    [im(:,:,ii), info] = open_nanoscope(fullfile(imageName,fileNames{ii}),app.BidirectionaldataCheckBox.Value);
                                    app.ImageInfo.ScanSize = info.ScanSize;
                                    app.ImageInfo.yPixels = info.line_no;
                                    app.ImageInfo.xPixels = size(im,2);
                                    app.ImageInfo.PixelPerNm = app.ImageInfo.yPixels./app.ImageInfo.ScanSize;
                                    app.ImageInfo.ScanSpeed = 1/(info.line_no.*info.Scan_Rate);
                                    app.ImageInfo.LineSpeed = 1/info.Scan_Rate;
                                    updateTable(app)
                                    updatePlot(app,'normal')
                                    pause(0.001)

                                else
                                    im(:,:,ii) = open_nanoscope(fullfile(imageName,fileNames{ii}),app.BidirectionaldataCheckBox.Value);
                                end
                            end

                        else
                            ImageType = 'Unknown';
                        end

                    end
                else
                    ImageType = 'Unknown';
                end

            else %it is a file
                namesplit = split(imageName,'.');
                filetype = namesplit{end};

                if strcmp(filetype,'tif') || strcmp(filetype,'tiff')
                    ImageType = 'Tiff';
                    info = imfinfo(imageName);   app.ImageInfo.n = numel(info);
                    if any(info(1).XResolution)
                        app.ImageInfo.PixelPerNm =  info(1).XResolution;
                    else
                        app.ImageInfo.PixelPerNm =  0;
                    end
                    app.ImageInfo.xPixels = info(1).Width;
                    app.ImageInfo.yPixels  = info(1).Height;

                    if app.ImageInfo.PixelPerNm >0
                        app.ImageInfo.ScanSize = app.ImageInfo.xPixels/app.ImageInfo.PixelPerNm;
                    else
                        app.ImageInfo.ScanSize = 0;
                    end
                    app.ImageInfo.LineSpeed = 0;
                    app.ImageInfo.ScanSpeed = 0;


                        if app.View1stCheckBox.Value ==1 && app.View1st.Value < app.ImageInfo.n
                            loadn = app.View1st.Value;
                        else
                            loadn = app.ImageInfo.n;
                        end

                    im = zeros(app.ImageInfo.yPixels ,app.ImageInfo.xPixels, loadn);

                    for ii = 1:loadn
                        im(:,:,ii) = imread(imageName,ii);
                    end
                    im = double(im);
                    updateTable(app)

                elseif strcmp(filetype,'asd')
                    ImageType = 'RIBM';
                    [im, info] = read_asd(imageName);
                    app.ImageInfo.ScanSize = info.xScanRange;
                    app.ImageInfo.yPixels = info.yPixel;
                    app.ImageInfo.xPixels = info.xPixel;
                    app.ImageInfo.PixelPerNm = app.ImageInfo.xPixels./app.ImageInfo.ScanSize;
                    app.ImageInfo.ScanSpeed = 1000/info.frameAcqTime;
                    app.ImageInfo.LineSpeed = info.yPixel.*app.ImageInfo.ScanSpeed;
                    app.ImageInfo.n = info.numberFramesCurrent;
                    updateTable(app)

                elseif strcmp(filetype,'ARIS')
                    ImageType = 'ARIS';
                    [im, info] = open_ARIS(imageName);
                    app.ImageInfo.ScanSize = info.ScanSize/1e-9;
                    app.ImageInfo.yPixels = info.yPixel;
                    app.ImageInfo.xPixels = info.xPixel;
                    app.ImageInfo.PixelPerNm = app.ImageInfo.xPixels./app.ImageInfo.ScanSize;
                    app.ImageInfo.ScanSpeed = 1/info.frameAcqTime;
                    app.ImageInfo.LineSpeed = info.yPixel.*app.ImageInfo.ScanSpeed;
                    app.ImageInfo.n = info.numberofFrames;
                    updateTable(app)
                    im = im.*1e9;
                  

                elseif strcmp(filetype,'ibw')
                    ImageType = 'ibw';
                    app.ImageInfo.n = 1;
                    updateVideoTools(app)

                    [im, info] = OpenIBW(imageName);
                    app.ImageInfo.ScanSize = info.ScanSize./1e-9;
                    app.ImageInfo.yPixels = info.yPixel;
                    app.ImageInfo.xPixels = info.xPixel;
                    app.ImageInfo.PixelPerNm = app.ImageInfo.xPixels./app.ImageInfo.ScanSize;
                    app.ImageInfo.ScanSpeed = 1/info.frameAcqTime;
                    app.ImageInfo.LineSpeed = info.yPixel.*app.ImageInfo.ScanSpeed;
                    updateTable(app)
                    im = im.*1e9;
                    im = flip(im);

                elseif strcmp(filetype,'jpk')
                    ImageType = 'jpk';
                    app.ImageInfo.n = 1;
                    updateVideoTools(app)

                    [info, ch] = open_JPK_info(imageName,'Height','Trace');
                    im = zeros(info.y_scan_pixels,info.x_scan_pixels,app.ImageInfo.n);
                    im(:,:,:) = 10*flip(-open_JPK_image(imageName,ch+1));
                    app.ImageTarget = im;
                    app.ImageInfo.LineSpeed = info.Scan_Rate;
                    app.ImageInfo.ScanSize = round(info.x_scan_length*1e9);
                    app.ImageInfo.yPixels = info.y_scan_pixels;
                    app.ImageInfo.xPixels = info.x_scan_pixels;
                    app.ImageInfo.PixelPerNm = app.ImageInfo.xPixels./app.ImageInfo.ScanSize;
                    app.ImageInfo.ScanSpeed = app.ImageInfo.LineSpeed./app.ImageInfo.yPixels.*(1.*(app.BidirectionaldataCheckBox.Value)+1);
                    updateTable(app)
                else
                    fid = fopen(imageName,'r');
                    line = fgets(fid);
                    fclose(fid);
                    if      length(strfind(line,'\*File list'))>=1
                        ImageType = 'NanoScope';
                        [im, info] = open_nanoscope(imageName,app.BidirectionaldataCheckBox.Value);
                        app.ImageInfo.ScanSize = info.ScanSize;
                        app.ImageInfo.xPixels = size(im,2);
                        app.ImageInfo.yPixels = info.line_no;
                        app.ImageInfo.PixelPerNm = app.ImageInfo.xPixels./app.ImageInfo.ScanSize;
                        app.ImageInfo.ScanSpeed = 1/(info.line_no.*info.Scan_Rate);
                        app.ImageInfo.LineSpeed = 1/info.Scan_Rate;
                        app.ImageInfo.n = 1;
                        updateTable(app)
                    else
                        ImageType = 'Unknown';
                    end
                end

            end
            if strcmp(ImageType,'Unknown')
                 im = [];
                 app.ImageInfo.n = 0;
            else
                updateVideoTools(app)
                app.ImageName = app.FilesListBox.Value;
              
                 im = single(im - mean(im(:),'omitnan'));
            end

            app.stop =1;
            app.CancelButton.Visible = 0;
        end

            function run_filter(app)
                app.filter_full=0;
                app.ImagePreview = filter(app);
                updatePlot(app,'normal')
                updatePlot2(app,'normal')
            end

            function result = filter(app)
                if app.filter_already == 0
                    frame = round(app.Spinner.Value);
                    switch  app.FramePartSwitch.Value
                        case 'Frames'
                             img = app.ImageTarget;
                        case 'Particles'
                            img = app.Part.Image;
                    end
                    result = img(:,:,frame);
                    if app.filter_full==1
                        loadn = numel(img(1,1,:));
                        filter_frames = 1:loadn;
                        app.filter_already =1;
                    else
                        filter_frames = frame;
                    end

                    sw = app.AutoflattenDropDown.Value;
                    switch sw
                        case 'Simple'
                           for i = filter_frames
                                prev = img(:,:,i);
                                prev = filter_img_v2(prev,1,1,'plane');
                                prev = filter_img_v2(prev,0,0,'med_line');
                                result(:,:,i) = prev;
                           end
                        
                        case 'Simple + fit'
                           for i = filter_frames
                                prev = img(:,:,i);
                                prev= filter_img_v2(prev,1,1,'plane');
                                prev= filter_img_v2(prev,0,0,'med_line');
                                result(:,:,i) = prev;
                           end
                           fo = fitoptions('method','NonlinearLeastSquares');
                           t = result(:,:,:);
                           [hy, x]=  hist(double(t(:)),100);
                           gfit  = fit(double(x'),hy','gauss1',fo);
                           max = gfit.b1 +1.5*gfit.c1;
                           min = gfit.b1 -1.5*gfit.c1;
                           
                           for i = filter_frames
                               imgt = thresholder(result(:,:,i),'histogram',[min, max],app.InvertSelected.Value);
                               result(:,:,i) = filter_img_v2(result(:,:,i) ,2,0,'line',imgt);
                           end
                      
                        
                        case 'Plane + Otsu Plane'
                            for i = filter_frames
                                prev = img(:,:,i);
                                prev = filter_img_v2(prev,1,1,'plane');
                                imgt = thresholder(prev,'otsu',[],app.InvertSelected.Value);
                                prev = filter_img_v2(prev,2,2,'plane',imgt);
                                result(:,:,i) = prev;
                            end
                        case 'Line + Otsu Line'
                            for i = filter_frames
                                prev = img(:,:,i);
                                prev = filter_img_v2(prev,1,0,'line');
                                imgt = thresholder(prev,'otsu',[],app.InvertSelected.Value);
                                prev = filter_img_v2(prev,2,0,'line',imgt);
                                result(:,:,i) = prev;
                            end
                        case 'Off'
                            for i = filter_frames
                            prev = img(:,:,i);
                            result(:,:,i) = prev;
                            end
                    end
                    polyx = app.XPlaneSpinner.Value;
                    polyy = app.YPlaneSpinner.Value;
                    xline = app.XLineSpinner.Value;
                    yline = app.YLineSpinner.Value;

                    switch app.ThresholdContrastSwitch.Value
                        case 'Contrast'
                            high_thresh = app.SliderMax.Limits(2);
                             low_thresh = app.SliderMin.Limits(1);
                        case 'Threshold'
                            high_thresh = app.SliderMax.Value;%/100.*(max_all-min_all)+min_all;
                            low_thresh = app.SliderMin.Value;%/100.*(max_all-min_all)+min_all;
                    end

                    for i = filter_frames
                        prev = result(:,:,i);           
                                imgt = thresholder(prev,app.ThresholdMethod.Value,[low_thresh,high_thresh],app.InvertSelected.Value);
                                   s = any(app.ThresholdROI);
                 
                                if app.ROIThresholdButton.Value == 1 && s(1)==1
                                    imgt = thresholder(app.ThresholdROI.*imgt,'selection',[low_thresh,high_thresh],app.InvertSelected.Value);
                                end
                        

                        if  polyx > 0 || polyy > 0
                            prev = filter_img_v2(prev,polyx,polyy,'plane',imgt);
                        end

                        if  xline > 0  || yline > 0   %x y line noise removal
                            prev = filter_img_v2(prev,xline,yline,'line', imgt);
                        end

                        if app.MedianCheckBox.Value==1
                            prev = filter_img_v2(prev,0,0,'med_line',imgt);
                        end

                        if app.MeanPlaneCheckBox.Value ==1
                            prev = filter_img_v2(prev,0,0,'mean_plane',imgt);
                        end

                        if  app.FixLineShift.Value > 0
                            switch app.FixShiftMethod.Value
                                case 'Line peaks'
                                    [app.FixShiftValue.Value, prev] = LineShift(prev,'peaks');
                                case 'Line correlation'
                                    [app.FixShiftValue.Value, prev] = LineShift(prev,'ccr');
                                case 'Manual Shift'
                                    [app.FixShiftValue.Value, prev] = LineShift(prev,app.FixShiftValue.Value);
                            end
                        end

%                         if  app.TopHatEditField.Value > 0 
%                             se = strel('disk',app.TopHatEditField.Value);
%                             prev = imtophat(prev,se);
%                         end

                        if  app.GaussianEditField.Value > 0
                            prev = imgaussfilt(prev,app.GaussianEditField.Value);
                        end

                        if  app.HighpassEditField.Value > 0
                            [mx, ny] =size(prev);
                            ft = fft2(prev);
                            f_shift = fftshift(ft);
                            ps = mx/2;
                            qs = ny/2;
                            for ii=1:mx
                                for jj=1:ny
                                    distance = sqrt((ii-ps)^2+(jj-qs)^2);
                                    low_filter(ii,jj) = 1-exp(-(distance)^2/(2*(app.HighpassEditField.Value.^2)));
                                end
                            end
                            filter_apply = f_shift.*low_filter;
                            image_orignal = ifftshift(filter_apply);
                            prev = abs(ifft2(image_orignal));
                        end

                        result(:,:,i) = prev;

                    end

                else
                    result = app.ImagePreview;
                end
            end

            function updateTable(app)
                app.UITable.Data(1,2) = num2cell(app.ImageInfo.n);
                app.UITable.Data(2,2) = num2cell(app.ImageInfo.ScanSize);
                app.UITable.Data(3,2) = num2cell(app.ImageInfo.ScanSpeed);
                app.UITable.Data(4,2) = num2cell(app.ImageInfo.LineSpeed);
                app.UITable.Data(5,2) = num2cell(round(app.ImageInfo.yPixels));
                app.UITable.Data(6,2) = num2cell(app.ImageInfo.PixelPerNm);
            end


            function updateResultsTable(app,type)
                switch type
                    case 'Line Profile'
                        Parameter =  {'Length','PeakHeight','FWHM','Max z','Min z','diff z','RMS'};
                        Value = [num2cell([0, 0, 0, 0, 0 ,0,0])];
                            app.UITable2.Data = [Parameter; Value];
                            app.UITable2.ColumnWidth = 'auto';

                            for jj=1:numel(app.LineROI)
                                x = single(app.LineROI(jj).Profile(:,1));
                                z = single(app.LineROI(jj).Profile(:,2));
                                  app.UITable2.Data(jj+1,1) = num2cell(round(app.LineROI(jj).Profile(end,1),2));
                                if numel(z)>4 && app.FWHMCheckBox.Value ==1
                                    [~, ~, wds, p] = findpeaks(z,x,'MinPeakProminence',0.1);
                                    if any(p)
                                        [p,ID] = max(p);
                                        w = wds(ID);
                                        app.UITable2.Data(jj+1,2) = num2cell(round(p,2));
                                        app.UITable2.Data(jj+1,3) = num2cell(round(w,2));
                                    else
                                        app.UITable2.Data(jj+1,2) = num2cell(0);
                                        app.UITable2.Data(jj+1,3) = num2cell(0);
                                    end
                                end
                                if numel(z)>4
                                    app.UITable2.Data(jj+1,4) = num2cell(round(max(z),2));
                                    app.UITable2.Data(jj+1,5) = num2cell(round(min(z),2));
                                    app.UITable2.Data(jj+1,6) = num2cell(round(max(z)-min(z),2));
                                    app.UITable2.Data(jj+1,7) = num2cell(round(std(z),5));
                                end
                            end
                end
            end

            

            function TurnOffButtons(app,type)
                buttons = {'app.Point_roi_Button', 'app.Line_roi_Button', 'app.Sq_roi_Button', 'app.Sq_roi_Button_2','app.Circ_roi_Button',  'app.ROIThresholdButton','app.ZoomIn'};
                numButtons = numel(buttons);
                for i = 1:numButtons
                    if strcmp(type,buttons{i})
                    else
                        f = eval(buttons{i});
                        f.Value=0;
                    end
                end

                if app.Line_roi_Button.Value ==1
                    app.UITable2.Visible = 1;
                    app.LineProfilePanel.Visible = 1;
                else
                    app.UITable2.Visible = 0;
                    app.LineProfilePanel.Visible = 0;
                end

                if app.ZoomIn.Value ==1
                    zoom(app.UIAxes,'on');
                else
                    zoom(app.UIAxes,'off');
                end
            end

            function loading(app)
                app.stop = 0;
                    app.ProcessingImage.Visible = 1;
                 %   app.NanoLocz1_02Pre.Pointer = 'watch';
            end

            function finished(app)
                app.stop = 1;
                app.ProcessingImage.Visible = 0;
               % app.NanoLocz1_02Pre.Pointer = 'arrow';
            end


        function storedata(app)

            ch = contains({app.stored.ImageName},app.FilesListBox.Value);
            field1 = 'ImageName';  value1 = app.ImageName;
            field2 = 'Imagedata';  value2 = app.ImageTarget;
            field3 = 'ImageInfo';  value3 = app.ImageInfo;
            if isfield(app.Part,'Locs')
                field4 = 'ImageLocs';  value4 = app.Part;
            else
                field4 = 'ImageLocs';  value4 = [];
            end
            if isfield(app.ref,'position')
                field5 = 'ref';  value5 = app.ref;
            else
                field5 = 'ref';  value5 = [];
            end

            if    isfield(app.LAFM,'Locs')
                field6 = 'LAFMLocs';  value6 = app.LAFM;
            else
                field6 = 'LAFMLocs';
                value6 = [];
            end
            if sum(ch)==1
                if ~app.MultiReferenceCheckBox.Value
                    app.stored(ch) = struct(field1,value1,field2,value2,field3, value3, field4, value4, field5, value5, field6, value6);
                else
                    s = struct(field1,value1,field2,value2,field3, value3, field4, value4, field5, value5, field6, value6);
                    app.stored(ch) = s(ch);
                end
            else
                pos = numel(app.stored)+1;
                app.stored(pos) = struct(field1,value1,field2,value2,field3, value3, field4, value4, field5, value5, field6, value6);
                
            end
        end
        
        function importSimulation(app,image)
            app.ref.simImage = image/10;
            app.ref.position = [0 0 20 20]; 
            app.ref.type = 'Simulated';
            if sum(strcmp(app.RightPlotList.Items,'Ref Image')) <1
                            app.RightPlotList.Items = [app.RightPlotList.Items , {'Ref Image'}];
            end
            app.RightPlotList.Value = 'Ref Image';
            if sum(strcmp(app.DropDown.Items,'Simulated Reference')) <1
                app.DropDown.Items = [app.DropDown.Items , {'Simulated Reference'}];
            end
            app.DropDown.Value = 'Simulated Reference';
            updateRightPlot(app);
            drawnow;
        end
        
        
        function import_tiff(app,filename,folder)
            app.OpenFolder = folder;
            app.FilesListBox.Value = filename;
            updateFolder(app);
            
            im = Open_files(app);
            

            updatePlot2_type(app,'image')
            pause(0.000001)
            if any(im)
                app.Hist_excludeOut.Value=0;
                app.FrameSlider.Value = 1;
                app.Spinner.Value = 1;
                app.ImageTarget = single(im);
                min_all = double(min(app.ImageTarget,[],'all'));
                max_all = double(max(app.ImageTarget,[],'all'));
                app.SliderMax.Limits = [min_all, max_all];
                app.SliderMin.Limits = [min_all, max_all];
                app.SliderMax.Value = max_all;
                app.SliderMin.Value = min_all;
                app.filter_full=0;
                app.ImagePreview = filter(app);

                updatePlot(app,'normal')
                updateHist(app)
                updatePlot2(app,'normal')

                if app.View1stCheckBox.Value ==1 && app.View1st.Value < app.ImageInfo.n
                    loadn = app.View1st.Value;
                else
                    loadn = app.ImageInfo.n;
                end

                app.Max_h_Edit.Value =50;
                app.Min_h_Edit.Value =2;
                app.Peaks_minHeight.Value = app.Min_h_Edit.Value;

            end
            finished(app)
            set(app.UIAxes,'xlimMode', 'auto','ylimMode', 'auto')
      
            if app.AutoplayCheckBox.Value==1 && loadn>1
                PlayImageClicked(app, event)
            end
            
        end
        
            
      end

    


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
             %Sets table values

           addpath('./scripts');
           addpath('./icons'); 
           addpath('./Mat_SimAFM')
            app.ImageInfo=[];  app.Part.Image =[]; app.rect = []; app.ref = [];  app.img_locs = []; 
            app.LAFM= []; app.PointROI=[]; app.LineROI=[];app.SquareROI=[];  app.patches.histup =[]; app.patches.histdown =[];
           
            Parameter = {'Number of Images';'X-Range, nm'; 'Speed, fps';'Lines/s'; 'Lines #'; 'Pixel/nm'};
            Value = [num2cell([0; 0; 0; 0; 0; 0])];
            app.UITable.Data = [Parameter Value];
            app.cmap = load('AFM_luts.mat');

            axis(app.UIAxes_2, 'tight','equal');
            axis(app.UIAxes, 'tight','equal');

            set(app.UIAxes_2,'visible','off')
            set(app.UIAxes,'visible','off')
            set(app.loadbar,'visible','off')
            set(app.UIAxes_2,'Color','k')
            set(app.UIAxes,'Color','k')
            app.HeightCCRHist.Toolbar.Visible = 'off';
            app.Hist_Axes.Toolbar.Visible = 'off';
            app.loadbar.Toolbar.Visible = 'off';

              xlim(app.loadbar,[0 1])

            app.UIAxes_2.Toolbar.Visible = 'off';
            app.UIAxes.Toolbar.Visible = 'off';
            colorbar(app.UIAxes_2,'off')
            colorbar(app.UIAxes,'off')
            A = randn(200,200,10);
            for i=1:10
                A(94+i:104+i,94+i:104+i,i) = 5;
                for ii = 1:size(A,1)
                    A(ii,:,i) = A(ii,:,i)+ (randn(1,1));
                    A(ii,:,i) = A(ii,:,i)+ +ii/5;
                    A(:,ii,i) = A(:,ii,i)+ +ii.^2/700;
                end
            end
            app.ImageTarget = A;
            app.ImageName = 'startup image';
            app.ImageInfo.ScanSize = 100;
            app.ImageInfo.xPixels = 200;
            app.ImageInfo.PixelPerNm = app.ImageInfo.xPixels./app.ImageInfo.ScanSize;
            app.ImageInfo.ScanSpeed = 10;
            app.ImageInfo.n = 10;

           % app.ImagePreview =  app.ImageTarget;

            min_all = double(min(app.ImageTarget,[],'all'));
            max_all = double(max(app.ImageTarget,[],'all'));
            app.SliderMax.Limits = [min_all, max_all];
            app.SliderMin.Limits = [min_all, max_all];
            app.SliderMax.Value = max_all;
            app.SliderMin.Value = min_all;
            updateHist(app)

            app.Spinner.Limits = [1 app.ImageInfo.n];
            app.FrameSlider.Limits = [1 app.ImageInfo.n];
            updatePlot(app,'normal')
            app.OpenFolder =pwd;
            updateFolder(app)
            app.PauseImage.Visible = 0;
            app.stop = 0;
            app.RightPlotList.Items = {'Off'};

            app.label.ScaleBar.color = 'w';
            app.label.ScaleBar.position = 'Bottom Right';
            app.label.LAFMScaleBar.color = 'w';
            app.label.LAFMScaleBar.position = 'Bottom Right';
            app.label.TimeStamp.color = 'w';
            app.label.TimeStamp.position = 'Top Left';
            app.LAFMPanel.Visible = 0;
            app.ExportSettings.color = 'black';
            app.ExportSettings.resolution = 300;
            app.FixLineShift.Visible = "off";
            app.FixShiftMethod.Visible = "off";
            app.FixShiftValue.Visible = "off";

            field1 = 'ImageName';  value1 = 'startup image';
            field2 = 'Imagedata';  value2 = app.ImageTarget;
            field3 = 'ImageInfo';  value3 = app.ImageInfo;
            field4 = 'ImageLocs';  value4 = [];
            field5 = 'ref';        value5 = [];
            field6 = 'LAFMLocs';   value6 = [];

            app.stored = struct(field1,value1,field2,value2,field3, value3, field4, value4, field5, value5, field6, value6);
            
        end

        % Key press function: NanoLocz1_00Pre
        function NanoLocz1_00PreKeyPress(app, event)

            switch  event.Key
                  case 'return'
                      AcceptButtonImageClicked(app, event)
                case 'rightarrow'
                    if app.VideoPanel.Visible ==1
                        f = app.FrameSlider.Value+1;
                        if f >app.FrameSlider.Limits(2)
                            app.FrameSlider.Value = 1;
                        else
                            app.FrameSlider.Value = app.FrameSlider.Value+1;
                        end
                        app.Spinner.Value = round(app.FrameSlider.Value);
                        app.ImagePreview = filter(app);
                        updatePlot(app,'normal')
                        updatePlot2(app,'normal')
                    end
                case'leftarrow'
                    if app.VideoPanel.Visible ==1
                        f = app.FrameSlider.Value-1;
                        if f <1
                            app.FrameSlider.Value = app.FrameSlider.Limits(2);
                        else
                            app.FrameSlider.Value = app.FrameSlider.Value-1;
                        end
                        app.Spinner.Value = round(app.FrameSlider.Value);
                        app.ImagePreview = filter(app);
                        updatePlot(app,'normal')
                         updatePlot2(app,'normal')
                    end
                case'downarrow'
                    app.ZScaleDropBox.Value = 'Manual';
                    range = app.ContrastMaxSpinner.Value - app.ContrastMinSpinner.Value;
                    if strcmp(event.Key, 'downarrow') && ismember('shift', event.Modifier)
                        app.ContrastMaxSpinner.Value = app.ContrastMaxSpinner.Value+0.05*range;
                        app.ContrastMinSpinner.Value = app.ContrastMinSpinner.Value-0.05*range;
                    else
                        app.ContrastMinSpinner.Value = app.ContrastMinSpinner.Value-0.05*range;
                        app.ContrastMaxSpinner.Value = app.ContrastMaxSpinner.Value-0.05*range;
                    end
                    updatePlot(app,'normal')

                case'uparrow'
                    app.ZScaleDropBox.Value = 'Manual';
                     range = app.ContrastMaxSpinner.Value - app.ContrastMinSpinner.Value;
                    if strcmp(event.Key, 'uparrow') && ismember('shift', event.Modifier)
                    app.ContrastMaxSpinner.Value = app.ContrastMaxSpinner.Value-0.05*range;
                    app.ContrastMinSpinner.Value = app.ContrastMinSpinner.Value+0.05*range;
                    else
                        app.ContrastMinSpinner.Value = app.ContrastMinSpinner.Value+0.05*range;
                        app.ContrastMaxSpinner.Value = app.ContrastMaxSpinner.Value+0.05*range;
                    end 
                    updatePlot(app,'normal')

                case'x'
                    if strcmp(event.Key, 'x') && ismember('shift', event.Modifier)
                        CropImageClicked(app, event)
                    end

            end
            
        end

        % Callback function: RestoreButton, View1st, View1stCheckBox
        function Reload(app, event)
            ch = contains({app.stored.ImageName},app.FilesListBox.Value);
            if sum(ch)==1
                app.stored(ch) = [];
            end
            FilesListBoxValueChanged(app, event)
            updatePlot(app,'normal')
            app.filter_already =0;
            app.MultiReferenceCheckBox.Value = 0;
        end

        % Value changed function: AutoflattenDropDown, FixLineShift, 
        % ...and 12 other components
        function Refresh_Filter(app, event)
            app.filter_already =0;
            app.LeftPlotList.Value='Preview';
            app.PreviewonoffButton.Value =1;
            run_filter(app)
        end

        % Value changed function: Spinner
        function SpinnerValueChanged(app, event)
            app.FrameSlider.Value = round(app.Spinner.Value);
            app.filter_full=0;
            switch app.LeftPlotList.Value
                case 'Preview'
            app.ImagePreview = filter(app);
            end
            updatePlot(app,'normal')
             updatePlot2(app,'normal')
        end

        % Button pushed function: Forceto11Button
        function Forceto11ButtonPushed(app, event)

            sz = size(app.ImageTarget);
            newSz = max(sz(1:2));
            app.ImageTarget = imresize(app.ImageTarget, [newSz, newSz], 'bicubic');
            updatePlot(app,'normal')
            updatePlot2(app,'normal')
        end

        % Value changed function: FilesListBox
        function FilesListBoxValueChanged(app, event)
            loading(app)
         
            app.Spinner.Value = 1;
            app.FrameSlider.Value = 1;
            reset_defaults(app)     
            ch = contains({app.stored.ImageName},app.FilesListBox.Value);
            if sum(ch)==1
                im = app.stored(ch).Imagedata;
                app.ImageTarget = single(im);
                app.ImageName = app.stored(ch).ImageName;
                app.ImageInfo = app.stored(ch).ImageInfo;
                s = any(app.stored(ch).ImageLocs.Locs);
                if s(1)~=0
                    app.Part = app.stored(ch).ImageLocs;
                    filter_Partlocs(app) 
                    updateCCRHist(app)
                end

                if isfield(app.stored(ch).ref,'position')
                    app.ref = app.stored(ch).ref;
                    app.Part.Image  = ConstructParticleStack2(app, app.ImageTarget, app.ref, app.Part);
                    if sum(strcmp(app.RightPlotList.Items,'Ref Image')) <1
                        app.RightPlotList.Items = [app.RightPlotList.Items , {'Ref Image'}];
                    end
                end

                if isfield(app.stored(ch).LAFMLocs,'Locs')
                    app.LAFM.Locs = app.stored(ch).LAFMLocs.Locs;
                    if sum(strcmp(app.RightPlotList.Items,'Localizations')) <1
                        app.RightPlotList.Items = [app.RightPlotList.Items , {'Localizations'}];
                    end
                end
                if isfield(app.stored(ch).LAFMLocs,'Image')
                    app.LAFM.Image = app.stored(ch).LAFMLocs.Image;
                    if sum(strcmp(app.RightPlotList.Items,'LAFM')) <1
                        app.RightPlotList.Items = [app.RightPlotList.Items , {'LAFM'}];
                    end
                end
                updateVideoTools(app)
            else
                im = Open_files(app);
            end

            updatePlot2_type(app,'image')
            pause(0.000001)
            if any(im)
                app.Hist_excludeOut.Value=0;
                app.FrameSlider.Value = 1;
                app.Spinner.Value = 1;
                app.ImageTarget = single(im);
                min_all = double(min(app.ImageTarget,[],'all'));
                max_all = double(max(app.ImageTarget,[],'all'));
                app.SliderMax.Limits = [min_all, max_all];
                app.SliderMin.Limits = [min_all, max_all];
                app.SliderMax.Value = max_all;
                app.SliderMin.Value = min_all;
                app.filter_full=0;
                app.ImagePreview = filter(app);

                updatePlot(app,'normal')
                updateHist(app)
                updatePlot2(app,'normal')

                if app.View1stCheckBox.Value ==1 && app.View1st.Value < app.ImageInfo.n
                    loadn = app.View1st.Value;
                else
                    loadn = app.ImageInfo.n;
                end

                app.Max_h_Edit.Value =50;
                app.Min_h_Edit.Value =2;
                app.Peaks_minHeight.Value = app.Min_h_Edit.Value;

            end
            finished(app)
            set(app.UIAxes,'xlimMode', 'auto','ylimMode', 'auto')
      
            if app.AutoplayCheckBox.Value==1 && loadn>1
                PlayImageClicked(app, event)
            end
            
        end

        % Button pushed function: ZeroallButton
        function ZeroallButtonPushed(app, event)
                       
            app.filter_already =0;
            app.FixLineShift.Value = 0;
            app.GaussianEditField.Value = 0;
            app.HighpassEditField.Value = 0;
            app.XLineSpinner.Value = 0;
            app.YLineSpinner.Value = 0;
            app.ThresholdMethod.Value = 'histogram';
            app.MedianCheckBox.Value = 0;
            app.XPlaneSpinner.Value = 0;
            app.YPlaneSpinner.Value = 0;
            app.SliderMax.Value = app.SliderMax.Limits(2);
            app.SliderMin.Value = app.SliderMax.Limits(1);

            app.filter_full=0;
            app.ImagePreview = filter(app);

            updatePlot(app,'normal')
            updatePlot2(app,'normal')
        end

        % Value changed function: AspectRatioSwitch, BoxesCheckBox, 
        % ...and 19 other components
        function UpdatePlots(app, event)
            updatePlot(app,'normal')
             updatePlot2(app,'normal')
        end

        % Value changed function: PreviewThresholdCheck
        function PreviewThresholdCheckValueChanged(app, event)
            if app.PreviewThresholdCheck.Value ==1 
            app.OverlayDropDown.Value = 'Threshold';
            else
            app.OverlayDropDown.Value = 'None';
            end
            updatePlot(app,'normal')
        end

        % Button pushed function: AverageRefButton
        function AverageRefButtonPushed(app, event)
            try
            app.ref.image = mean(app.Part.Image(:,:,app.Part.IncludeImages),3);
            storedata(app)
             updatePlot2(app,'normal')
            catch
            end
        end

        % Button pushed function: RotationalAvgButton
        function RotationalAvgButtonPushed(app, event)
            try
                app.ref.image = rotation_sym( app.ref.image,app.Symmetry_detect.Value);
                storedata(app)
                updatePlot2(app,'normal')
            catch
            end
        end

        % Value changed function: LogYHist
        function LogYHistValueChanged(app, event)
        updateHist(app)
        end

        % Value changing function: SliderMax
        function SliderMaxValueChanging(app, event)
           delete(app.patches.histup)
            app.SliderMax.Value = event.Value;
            app.filter_already =0;
            run_filter(app)
  app.patches.histup = patch(app.Hist_Axes,[app.SliderMax.Limits(2) app.SliderMax.Value app.SliderMax.Value app.SliderMax.Limits(2)], [app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(1),  app.Hist_Axes.YLim(2)  app.Hist_Axes.YLim(2)],...
         'r', 'FaceAlpha', 0.5,'EdgeColor','none');
            switch app.ThresholdContrastSwitch.Value
                case 'Contrast'
                    app.ZScaleDropBox.Value = 'Histogram';
                case 'Threshold'
            end
        end

        % Value changing function: SliderMin
        function SliderMinValueChanging(app, event)
            delete(app.patches.histdown)
            app.SliderMin.Value = event.Value;
            app.filter_already =0;
            run_filter(app)
            app.patches.histdown = patch(app.Hist_Axes,[app.SliderMin.Value app.SliderMin.Limits(1) app.SliderMin.Limits(1) app.SliderMin.Value], [app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(1),  app.Hist_Axes.YLim(2)  app.Hist_Axes.YLim(2)],...
                'r', 'FaceAlpha', 0.5,'EdgeColor','none');
            switch app.ThresholdContrastSwitch.Value
                case 'Contrast'
                    app.ZScaleDropBox.Value = 'Histogram';
                case 'Threshold'
            end
        end

        % Image clicked function: PlayImage
        function PlayImageClicked(app, event)
            app.PlayImage.Visible=0;
            app.PauseImage.Visible=1;
            app.stop=0;
            currentFrame = round(app.FrameSlider.Value);

            if strcmp(app.PlotTypeDropDown.Value,'3D surface') || strcmp(app.PlotTypeDropDown.Value,'Coordinates')
                [app.viewangle(1), app.viewangle(2)]= view(app.UIAxes);
            end

            while true
                tic;
                if app.stop == 1
                    return
                end

                if currentFrame == app.FrameSlider.Limits(2) + 1
                    currentFrame = 1;
                end

                app.FrameSlider.Value = currentFrame;
                app.Spinner.Value = currentFrame;
                app.filter_full=0;

                switch app.LeftPlotList.Value
                    case 'Preview'
                        app.ImagePreview = filter(app);
                end

                updatePlot(app,'normal')

                if strcmp(app.PlotTypeDropDown.Value,'3D surface') || strcmp(app.PlotTypeDropDown.Value,'Coordinates')
                    view(app.UIAxes,app.viewangle(1), app.viewangle(2));
                end

                 updatePlot2(app,'normal')

                playtime = toc;
                pause(1/app.fps.Value-playtime)
                drawnow

                currentFrame = currentFrame + 1;
            end

            app.PauseImage.Visible=0;
            app.PlayImage.Visible=1;
        end

        % Image clicked function: PauseImage
        function PauseImageClicked(app, event)
            app.PlayImage.Visible=1;
            app.PauseImage.Visible=0;
            app.stop = 1;
        end

        % Image clicked function: StartImage
        function StartImageClicked(app, event)
                        app.FrameSlider.Value = 1;
             app.Spinner.Value = app.FrameSlider.Value;
            app.filter_full=0;
            switch app.LeftPlotList.Value
                case 'Preview'
                    app.ImagePreview = filter(app);
            end
            updatePlot(app,'normal')
             updatePlot2(app,'normal')
        end

        % Image clicked function: EndImage
        function EndImageClicked(app, event)
                        app.FrameSlider.Value = app.FrameSlider.Limits(2);
            app.Spinner.Value = app.FrameSlider.Value;
            app.filter_full=0;
            switch app.LeftPlotList.Value
                case 'Preview'
                    app.ImagePreview = filter(app);
            end
            updatePlot(app,'normal')
             updatePlot2(app,'normal')
        end

        % Image clicked function: BinRangeImage
        function BinRangeImageClicked(app, event)
            RemoveFrames = app.RemoveframesEditField.Value;
            RemoveFrames = strrep(RemoveFrames,'-',':');
            RemoveFrames = str2num(RemoveFrames);

            switch  app.FramePartSwitch.Value
                case 'Frames'
                    app.ImageTarget(:,:,RemoveFrames) = [];
                    app.ImageInfo.n = app.ImageInfo.n - size(RemoveFrames,2);
                case 'Particles'
                    pos = ismember(app.Part.Locs(:,6), RemoveFrames);
                    app.Part.Locs(pos,3:4) = nan;
                    filter_Partlocs(app)
            end
        
                updateVideoTools(app)

                updatePlot(app,'normal')
                updatePlot2(app,'normal')
     
  
        end

        % Image clicked function: BinImage
        function BinImageClicked(app, event)

            RemoveFrames = round(app.FrameSlider.Value);
            switch  app.FramePartSwitch.Value
                case 'Frames'
                    app.ImageTarget(:,:,RemoveFrames) = [];
                    app.ImageInfo.n = app.ImageInfo.n - 1;
                case 'Particles'
                    pos = app.Part.Locs(:,6)==RemoveFrames;
                    app.Part.Locs(pos,3:4) = nan;
                    filter_Partlocs(app)
            end
            updateVideoTools(app)
            app.Spinner.Value = round(app.FrameSlider.Value);
            updatePlot(app,'normal')
            updatePlot2(app,'normal')
        end

        % Value changing function: FrameSlider
        function FrameSliderValueChanging(app, event)

            app.Spinner.Value = round(event.Value);
            app.filter_full=0;
            switch app.LeftPlotList.Value
                case 'Preview'
            app.ImagePreview = filter(app);
            end
            updatePlot(app,'normal')
             updatePlot2(app,'normal')
        end

        % Image clicked function: AcceptButtonImage
        function AcceptButtonImageClicked(app, event)
              app.filter_full=1;
            loading(app)
            pause(0.000001)
            app.ImagePreview = filter(app);
            switch  app.FramePartSwitch.Value
                case 'Frames'
                  app.ImageTarget = app.ImagePreview;
                case 'Particles'
                    app.Part.Image = app.ImagePreview;
            end

            app.LeftPlotList.Value = 'Target';
            updatePlot(app,'normal')
            app.filter_already =0;
            app.GaussianEditField.Value = 0;
            app.HighpassEditField.Value = 0;
            app.XLineSpinner.Value = 0;
            app.YLineSpinner.Value = 0;
            app.ThresholdMethod.Value = 'histogram';
            app.AutoflattenDropDown.Value = 'Off';
            app.MedianCheckBox.Value = 0;
            app.FixLineShift.Value = 0;
            app.XPlaneSpinner.Value = 0;
            app.YPlaneSpinner.Value = 0;
            if app.Hist_excludeOut.Value==1
                T = reshape(app.ImageTarget(:,:,:),1,[]);
                T = rmoutliers(T,"percentiles",[5 95]);
            else
                T = app.ImageTarget;
            end
            min_all = double(min(T,[],'all'));
            max_all = double(max(T,[],'all'));
            app.SliderMax.Limits = [min_all(1), max_all(1)];
            app.SliderMin.Limits = [min_all(1), max_all(1)];
            app.SliderMax.Value = max_all;
            app.SliderMin.Value = min_all;
            updateHist(app)
             finished(app)
             storedata(app)
           
        end

        % Value changed function: PreviewonoffButton
        function PreviewonoffButtonValueChanged(app, event)

           if    app.PreviewonoffButton.Value ==1
                app.ImagePreview = filter(app);
                app.LeftPlotList.Value = 'Preview';
            else
                app.LeftPlotList.Value = 'Target';
            end
            updatePlot(app,'normal')
        end

        % Image clicked function: FolderUp
        function FolderUpImageClicked(app, event)
            
            app.OpenFolder = fileparts(app.OpenFolder);
            imageFiles = dir([app.OpenFolder]);
            imageFiles = imageFiles(~ismember({imageFiles(:).name},{'.','..','.DS_Store'}));
            app.FilesListBox.Items = {imageFiles.name};
        end

        % Image clicked function: FolderDown
        function FolderDownImageClicked(app, event)
            app.OpenFolder = [app.OpenFolder '/' app.FilesListBox.Value];
            imageFiles = dir([app.OpenFolder]);
            imageFiles = imageFiles(~ismember({imageFiles(:).name},{'.','..','.DS_Store'}));
            app.FilesListBox.Items = {imageFiles.name};
        end

        % Callback function
        function FilesListBoxDoubleClicked(app, event)
            app.OpenFolder = [app.OpenFolder '/' app.FilesListBox.Value];
            imageFiles = dir([app.OpenFolder]);
            imageFiles = imageFiles(~ismember({imageFiles(:).name},{'.','..','.DS_Store'}));
            app.FilesListBox.Items = {imageFiles.name};
            
        end

        % Value changed function: ColorBarCheckBox
        function ColorBarCheckBoxValueChanged(app, event)

            if app.ColorBarCheckBox.Value==1
                colorbar(app.UIAxes,'Color','w','Box','off','TickDirection','out')
                switch app.RightPlotList.Value
                    case 'Off'
                        colorbar(app.UIAxes_2,'off')
                    otherwise
                        colorbar(app.UIAxes_2,'Color','w','Box','off','TickDirection','out')
                end
            else
                colorbar(app.UIAxes,'off')
                colorbar(app.UIAxes_2,'off')
            end
        end

        % Button pushed function: AutoButton
        function AutoButtonPushed(app, event)
            switch app.ZScaleDropBox.Value
                case 'Max Min'
                    app.ZScaleDropBox.Value = 'Exc outliers';
                otherwise
                    app.ZScaleDropBox.Value = 'Max Min';
            end
            updatePlot(app,'normal')
            updatePlot2(app,'normal')
        end

        % Callback function: ContrastMaxSpinner, ContrastMinSpinner, 
        % ...and 1 other component
        function HoldButtonPushed(app, event)
            app.ZScaleDropBox.Value = 'Manual';
            updatePlot(app,'normal')
            updatePlot2(app,'normal')
        end

        % Button pushed function: ClearButton
        function ClearButtonPushed(app, event)
            
            app.LineROI = findobj(app.UIAxes, 'Tag', 'MyDrawPolygon'); %Find the Polygon currntly drawn.
            app.SquareROI= findobj(app.UIAxes, 'Tag', 'MyDrawPolygon'); %Find the Polygon currntly drawn.
            if ~isempty(app.PointROI)
                app.PointROI = [];
            end
            
            if ~isempty(app.LineROI)
                app.LineROI.delete();
            end

            if ~isempty(app.SquareROI)
                app.SquareROI.delete();
            end
            app.RightPlotList.Value='Off';
            RightPlotListValueChanged(app, event)
            if strcmp(app.AspectRatioSwitch.Value, '1:1')
                axis(app.UIAxes,'normal');
                pbaspect(app.UIAxes,[1 1 1])
            else
                axis(app.UIAxes,'tight','equal');
            end
            app.LineROI = [];
             updatePlot2(app,'normal')
            updatePlot(app,'normal')
        end

        % Value changed function: RightPlotList
        function RightPlotListValueChanged(app, event)

            switch app.RightPlotList.Value
                case {'Off','Ref Image','Localizations','LAFM', 'LAFM_sym','Kymograph'}
                    updatePlot2_type(app,'image')
                case 'Line Profile'
                    updatePlot2_type(app,'plot')
            end

            switch app.RightPlotList.Value
                case {'LAFM'}
                    if strcmp(app.LAFM_LUT.Value,'LAFM')
                        app.LAFMMinSlider.Limits = [0,1];
                        app.LAFMMinSlider.Value = 0;
                        app.LAFMMaxSlider.Limits = [0,1];
                        app.LAFMMaxSlider.Value = 1;

                    else
                        app.LAFMMinSlider.Limits = [0, max(app.LAFM.Image(:))];
                        app.LAFMMinSlider.Value = 0;
                        app.LAFMMaxSlider.Limits =  app.LAFMMinSlider.Limits;
                        app.LAFMMaxSlider.Value = app.LAFMMaxSlider.Limits(2);
                    end

            end

            switch app.RightPlotList.Value
                case 'Ref Image'
                    app.RefCropButton.Visible = 1;
                    app.MultiReferenceCheckBox.Visible = 1;
                    if app.MultiReferenceCheckBox.Value == 1
                        app.DropDown.Visible = 0;
                        app.ReferenceButtonGroup.Visible = 1;
                    else
                        app.DropDown.Visible = 1;
                        app.ReferenceButtonGroup.Visible = 0;
                    end    
                otherwise
                    app.DropDown.Visible = 0;
                    app.RefCropButton.Visible = 0;
                    app.MultiReferenceCheckBox.Visible = 0;
            end 

             updatePlot2(app,'normal')
        end

        % Button pushed function: RunAlignButton
        function RunAlignButtonPushed(app, event)
            loading(app)
            app.img_locs = [];
            if app.View1stCheckBox.Value ==1 && app.View1st.Value < app.ImageInfo.n
                loadn = app.View1st.Value;
            else
                loadn = app.ImageInfo.n;
            end
         
            if isfield(app.ref,'position')
            else
                app.ref.position = [1, 1, size(app.ImageTarget,1),size(app.ImageTarget,2)];
                p =app.ref.position;
                app.ref.image =  imcrop(app.ImageTarget(:,:,round(app.FrameSlider.Value)), [p(1), p(2), p(3)-1, p(4)-1]);
            end

            refimg = app.ref;
            full_image = 0;

            if app.FilterImgEditField.Value >0
                T = imgaussfilt(app.ImageTarget,app.FilterImgEditField.Value);
            else
                T = app.ImageTarget;
            end
  
            [x, y] = Align_Frames(app, T,refimg,app.MaxdriftEditField.Value,full_image, app.SubPixCheckBox.Value,  app.FilterCCREditField.Value);

            app.img_locs(:,1) = x;
            app.img_locs(:,2) = y;

            updatePlot2_type(app,'plot')
            plot(app.UIAxes_2,x,'x-')
            hold(app.UIAxes_2,'on')
            plot(app.UIAxes_2,y,'v-')
            hold(app.UIAxes_2,'off')

            sz = size(app.ImageTarget);
            ty = app.ViewSwitch.Value;
            switch ty
                case 'Expand'
                    if min(y)<0
                        miny = round(min(y));
                    else
                        miny = 0;
                    end

                    if min(x)<0
                        minx = round(min(x));
                    else
                        minx = 0;
                    end

                    if max(y)>0
                        maxy = round(max(y));
                    else
                        maxy = 0;
                    end

                    if max(x)>0
                        maxx = round(max(x));
                    else
                        maxx = 0;
                    end
                    app.ImagePreview = zeros(sz(1)+maxy-miny,sz(2)+ maxx-minx,sz(3));
                    D = padarray(app.ImageTarget,[maxy maxx],0,'pre');
                    D = padarray(D,[-miny -minx],0,'post');
                    for i = 1:loadn
                        app.ImagePreview(:,:,i) = imtranslate(D(:,:,i), [-x(i), -y(i)] );
                    end

                case 'Crop'
                    app.ImagePreview = zeros(sz(1),sz(2), sz(3));
                    for i = 1:loadn
                        app.ImagePreview(:,:,i) = imtranslate(app.ImageTarget(:,:,i), [-x(i), -y(i)] );
                    end

            end
            app.img_locs(:,1) = x;
            app.img_locs(:,2) = y;
            app.filter_already = 1;
            app.LeftPlotList.Value='Preview';
            app.PreviewonoffButton.Value =1;
            updatePlot(app,'normal')
            finished(app)
            

        end

        % Button pushed function: UpdateRefwithAverageButton
        function UpdateRefwithAverageButtonPushed(app, event)
            try

                ty = app.ViewSwitch.Value;
                switch ty
                    case 'Expand'
                        p = round(app.ref.position);
                        p(1) = p(1) + max(app.img_locs(:,1));
                        p(2) = p(2) + max(app.img_locs(:,2));
                        app.ref.image = mean(app.ImagePreview(p(2):(p(2)+p(4)),p(1):(p(1)+p(3)),:),3);
                    case 'Crop'
                        p = round(app.ref.position);
                        app.ref.image = mean(app.ImagePreview(p(2):(p(2)+p(4)),p(1):(p(1)+p(3)),:),3);
                end
            catch
                app.ref.image = mean(app.ImagePreview(:,:,:),3);
                app.ref.position(1) = 0; app.ref.position(3) = 0;
                app.ref.position(2) = size(app.ImagePreview,1);
                app.ref.position(4) = size(app.ImagePreview,2);
                app.UseAvgrefCheckBox.Value=1;
                app.UseAvgrefCheckBox.Visible=1;
            end
            app.RightPlotList.Items = [app.RightPlotList.Items , {'Ref Image'}];
            app.RightPlotList.Value = 'Ref Image';
            app.RefCropButton.Visible = 1;
            RightPlotListValueChanged(app, event)
           
            % app.ref.image = mean(app.ImagePreview,3);
            % app.RightPlotList.Items = [app.RightPlotList.Items , {'Ref Image'}];
            % app.RightPlotList.Value = 'Ref Image';
            % RightPlotListValueChanged(app, event)
        end

        % Value changed function: PeaksRegionsSwitch
        function PeaksRegionsSwitchValueChanged(app, event)

            switch app.PeaksRegionsSwitch.Value
                case 'Regions'
                    app.Peaks_minSep.Visible = "off";     app.MinseparationLabel.Visible = 'off';
                    app.Peaks_minHeight.Visible = "off";  app.MinheightLabel.Visible = 'off';
                     
                 app.Panel_4.Visible = 1;
                 app.Panel_5.Visible = 1;
                 app.PreviewpeaksLabel.Visible=0;
                 app.PreviewPeaks.Visible=0;
                 app.FilterCCREditField_Detect.Visible = 1;
                 app.FilterxcorimageLabel.Visible =1;
                 app.BoxSizeEditField.Visible = 0;
                 app.BoxSizeEditFieldLabel.Visible = 0;
                 app.Height_corr_switch.Visible = 1;
                 app.Height_corr_switch.Value = 'Correlation';
                 app.HeightCheckBox.Value=0;
                 app.CorrelationCheckBox.Value=1;
                 app.CorrelationCheckBox.Visible=1;
                 app.Max_CCR_Edit.Visible = 1;
                 app.Min_CCR_Edit.Visible = 1;

                case 'Peaks'
                    app.Peaks_minSep.Visible = "on";  app.MinseparationLabel.Visible = 'on';
                    app.Peaks_minHeight.Visible = "on";  app.MinheightLabel.Visible = 'on';
                        
                    app.Peaks_minHeight.Visible = 1;
                    app.Panel_4.Visible = 0;
                    app.Panel_5.Visible=0;
                    app.PreviewpeaksLabel.Visible=1;
                    app.PreviewPeaks.Visible=1;
                    app.FilterCCREditField_Detect.Visible = 0;
                    app.FilterxcorimageLabel.Visible =0;
                    app.BoxSizeEditField.Visible = 1;
                    app.BoxSizeEditFieldLabel.Visible = 1;
                    app.Height_corr_switch.Value = 'Height';
                    app.Height_corr_switch.Visible = 0;
                    app.HeightCheckBox.Value=1;
                    app.CorrelationCheckBox.Value=0;
                    app.CorrelationCheckBox.Visible=0;
                    app.Max_CCR_Edit.Visible = 0;
                    app.Min_CCR_Edit.Visible = 0;


            end
        end

        % Button pushed function: RunTrackingButton
        function RunTrackingButtonPushed(app, event)
            loading(app)
            tracking = track_particles(app.Part.Locs(app.Part.IncludeImages,:), app.MaxstepEditField.Value, app.MaxmissingEditField.Value);
            counter=0;
            for i = 1:numel(app.Part.Locs(:,1))
                if ~isnan(app.Part.Locs(i,6))
                    counter=counter+1;
                    app.Part.Locs(i,7)= tracking(counter,7);
                else
                    app.Part.Locs(i,7)  = NaN;
                end
            end
            updatePlot(app,'normal')
            app.TrackLengthEditField.Value = 20;
            app.OverlayValues.Value = 'Track Number';
             finished(app)
             storedata(app)
        end

        % Value changed function: Height_corr_switch
        function Height_corr_switchValueChanged(app, event)
            switch app.Height_corr_switch.Value
                case 'Height'
                    app.HeightCheckBox.Value=1;
                    app.CorrelationCheckBox.Value=0;
                    app.CorrelationCheckBox.Visible=0;
                case 'Correlation'
                    app.HeightCheckBox.Value=0;
                    app.CorrelationCheckBox.Value=1;
                    app.CorrelationCheckBox.Visible=1;
            end

        end

        % Value changing function: CCRSliderMax
        function CCRSliderMaxValueChanging(app, event)
            delete(app.patches.ccrhistup)
            app.CCRSliderMax.Value = event.Value;

            switch app.Height_corr_switch.Value
                case 'Height'
                    app.Max_h_Edit.Value = event.Value;
                case 'Correlation'
                    app.Max_CCR_Edit.Value = event.Value;
            end
            filter_Partlocs(app)
            updateVideoTools(app)
            updatePlot(app,'normal')
              updatePlot2(app,'normal')
            app.patches.ccrhistup = patch(app.HeightCCRHist,[app.CCRSliderMax.Limits(2) app.CCRSliderMax.Value app.CCRSliderMax.Value app.CCRSliderMax.Limits(2)], [app.HeightCCRHist.YLim(1), app.HeightCCRHist.YLim(1),  app.HeightCCRHist.YLim(2)  app.HeightCCRHist.YLim(2)],...
                'r', 'FaceAlpha', 0.5,'EdgeColor','none');
            
        end

        % Value changing function: CCRSliderMin
        function CCRSliderMinValueChanging(app, event)

            delete(app.patches.ccrhistdown )
            app.CCRSliderMin.Value = event.Value;
            switch app.Height_corr_switch.Value
                case 'Height'
                    app.Min_h_Edit.Value = event.Value;
                    app.Peaks_minHeight.Value = app.Min_h_Edit.Value;
                case 'Correlation'
                    app.Min_CCR_Edit.Value = event.Value;
            end
            filter_Partlocs(app)
            updateVideoTools(app)
            updatePlot(app,'normal')
            updatePlot2(app,'normal')
            app.patches.ccrhistdown = patch(app.HeightCCRHist,[app.CCRSliderMin.Limits(1) app.CCRSliderMin.Value app.CCRSliderMin.Value app.CCRSliderMin.Limits(1)], [app.HeightCCRHist.YLim(1), app.HeightCCRHist.YLim(1),  app.HeightCCRHist.YLim(2)  app.HeightCCRHist.YLim(2)],...
                'r', 'FaceAlpha', 0.5,'EdgeColor','none');

        end

        % Button pushed function: CenterrefButton
        function CenterrefButtonPushed(app, event)
            
            center_translation = FindCenterPositions(app.Symmetry_detect.Value, app.ref.image, 10);
            app.ref.image = imtranslate(app.ref.image, -center_translation);

             updatePlot2(app,'normal')

        end

        % Button pushed function: RunFineAlignButton
        function RunFineAlignButtonPushed(app, event)
           app.CancelButton.Visible = 1;
            loading(app)
            app.Part.FineAlign = [];
            app.ImagePreview=[];
            tran_count = 0;
            rot_count = 0;
            total_count = 0;
    
            img = app.Part.Image(:,:,app.Part.IncludeImages);
            cla(app.loadbar);
            n = numel(img(1,1,:));
            updateInterval = 5;
            %iterative loop starts
            while tran_count < app.Tran_IterationsEditField.Value || rot_count < app.Rot_IterationsEditField.Value

                if app.ThresholdwithminheightCheckBox.Value ==1
                    img = img.*(img>app.ContrastMinSpinner.Value);
                    rf = app.ref.image.*(app.ref.image>app.ContrastMinSpinner.Value);
                else
                    rf = app.ref.image;
                end


                if tran_count < app.Tran_IterationsEditField.Value
                    total_count = total_count +1;
                    tran_count = tran_count + 1;
                                  [app.Part.FineAlign.x, app.Part.FineAlign.y] = FineAlign_Frames(app, img,rf, app.MaxdriftEditField_2.Value,1,1);
                    for i = 1:n
                        img(:,:,i) = imtranslate(img(:,:,i), [-app.Part.FineAlign.x(i), -app.Part.FineAlign.y(i)] );
                    end
                    app.Part.Locs(app.Part.IncludeImages,1) = app.Part.Locs(app.Part.IncludeImages,1) + app.Part.FineAlign.x;
                    app.Part.Locs(app.Part.IncludeImages,2) = app.Part.Locs(app.Part.IncludeImages,2) + app.Part.FineAlign.y;
                end


                if rot_count < app.Rot_IterationsEditField.Value
                    total_count = total_count +1;
                    rot_count = rot_count + 1;
                     cla(app.loadbar);
                    stepsPerUpdate = ceil(n * (updateInterval / 100));
                    rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
                    progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', 'green');
                    progressText = text(app.loadbar, 0.5, 0.5, '0%', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

                    for i = 1:numel(img(1,1,:))
                        if app.stop == 1
                            return
                        end
                        app.Part.FineAlign.rot_ang(i,:) = ccr_rot_align(rf, img(:,:,i), [-app.searchangleEditField.Value, app.searchangleEditField.Value] ,1);
                        img(:,:,i)  = imrotate(img(:,:,i), app.Part.FineAlign.rot_ang(i), 'crop');
                       
                        if mod(i, stepsPerUpdate) == 0 || i == n
                            progressBar.Position(3) = i / n;
                            progressText.String = sprintf([num2str(i),' frames rotated']);
                            drawnow;
                        end
                    end

                    app.Part.Locs(app.Part.IncludeImages,8) = app.Part.Locs(app.Part.IncludeImages,8) + app.Part.FineAlign.rot_ang;

                end


                app.ImagePreview =  ConstructParticleStack2(app, app.ImageTarget, app.ref, app.Part);
                img = app.ImagePreview(:,:,app.Part.IncludeImages);

                if app.AutoupdatereferenceimageCheckBox.Value ==1
                    app.ref.image = mean(img,3);   %update ref image
                end
            end
            %iterative loop ends

            app.LeftPlotList.Value='Preview';
            app.PreviewonoffButton.Value =1;
            app.filter_already = 1;
            updatePlot(app,'normal')
            if sum(strcmp(app.DropDown.Items,'Averaged Reference')) <1
                app.DropDown.Items = [app.DropDown.Items , {'Averaged Reference'}];
            end
            app.DropDown.Value = 'Averaged Reference';
             updatePlot2(app,'normal')
            finished(app)
            storedata(app)
            app.CancelButton.Visible = 0;
        end

        % Button down function: FineAlignTab
        function FineAlignTabButtonDown(app, event)
            app.LeftPlotList.Value = 'Target';
            app.PreviewonoffButton.Value=0;
            app.LoczImagepeaksCheckBox.Value =0;
            app.MarkersCheckBox.Value = 0;
            app.BoxesCheckBox.Value = 0;
            app.OverlayValues.Value = 'None';
            app.TrackLengthEditField.Value = 0;
            if isfield(app.Part,'IncludeImages')
            else
                sz = size(app.ImageTarget);
                if numel(sz)>2
                    app.Part.Locs(1:sz(3),1) = sz(2)/2;
                    app.Part.Locs(1:sz(3),2) = sz(1)/2;
                    app.Part.Locs(:,4) = ones(numel(app.Part.Locs(:,1)),1);
                    app.Part.Locs(1:sz(3),5) = 1:sz(3);
                    app.Part.Locs(1:sz(3),8) = 0;

                    app.ref.position(3) = sz(2);
                    app.ref.position(4) = sz(1);

                    app.Part.IncludeImages = app.Part.Locs(:,4) >0;
                    app.Part.Image  = ConstructParticleStack2(app, app.ImageTarget, app.ref, app.Part);
                end
            end


            if isfield(app.ref,'image')
            else
                if isfield(app.Part,'IncludeImages')
                    app.ref.image = app.Part.Image(:,:,round(app.FrameSlider.Value));
                    app.ref.frame = app.FrameSlider.Value;
                end
            end
            if isfield(app.Part,'IncludeImages')
                app.FramePartSwitch.Value = 'Particles';

                if sum(strcmp(app.RightPlotList.Items,'Ref Image')) <1
                    app.RightPlotList.Items = [app.RightPlotList.Items , {'Ref Image'}];
                end
                app.RightPlotList.Value='Ref Image';
                app.RefCropButton.Visible = 1;
                updatePlot2(app,'normal')
                updatePlot(app,'normal')
            end
            updateVideoTools(app)
        end

        % Button pushed function: FindallpeaksButton
        function FindallpeaksButtonPushed(app, event)
            app.LAFM.Locs = [];
            app.CancelButton.Visible = 1;
            loading(app)
            pause(0.000001)

            switch  app.FramePartSwitch.Value
                case 'Frames'
                    img = app.ImageTarget;
                case 'Particles'
                    img = app.Part.Image(:,:,app.Part.IncludeImages);
            end
            n = numel(img(1,1,:));
            if strcmp(app.LoczHighpassDropDown.Value,'-Average')
                d_av = mean(img,3);
                for i = 1:n
                    prev(:,:,i) = filter_movie(img(:,:,i) , app.LoczLowpassDropDown.Value, app.LoczLowpass.Value, app.LoczHighpassDropDown.Value,  app.LoczHighpass.Value,d_av);
                end
            else
                for i = 1:n
                    prev(:,:,i) = filter_movie(img(:,:,i) , app.LoczLowpassDropDown.Value, app.LoczLowpass.Value, app.LoczHighpassDropDown.Value,  app.LoczHighpass.Value);
                end
            end

            updateInterval = 5;
            cla(app.loadbar)
            stepsPerUpdate = ceil(n * (updateInterval / 100));
            rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
            progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', 'green');
            progressText = text(app.loadbar, 0.5, 0.5, '0%', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
            for i = 1:numel(img(1,1,:))
                if app.stop == 1
                    return
                end
                locs = peaks2D( prev(:,:,i),app.LoczHeightSpinner.Value,app.LoczMinSep.Value,app.LoczProminenceSpinner.Value);
                s = any(locs);
                if s(1)==0
                else
                    locs_full = [locs,i*ones(numel(locs(:,1)),1)];
                    app.LAFM.Locs = [app.LAFM.Locs; locs_full];
                end

                if mod(i, stepsPerUpdate) == 0 || i == n
                    progressBar.Position(3) = i / n;
                       s = any(app.LAFM.Locs);
                if s(1)==0
                    progressText.String = sprintf([0,' peaks detected']);
                else
                    progressText.String = sprintf([num2str(numel(app.LAFM.Locs(:,1))),' peaks detected']);
                end
                drawnow;
                end
            end
            finished(app)
            loading(app)
            pause(0.000001)

            app.LAFM.Locs  = localize(app, prev, app.LAFM.Locs);

            if sum(strcmp(app.RightPlotList.Items,'Localizations')) <1
                app.RightPlotList.Items = [app.RightPlotList.Items , {'Localizations'}];
            end
            app.RightPlotList.Value = 'Localizations';
            RightPlotListValueChanged(app, event)
            finished(app)
            app.CancelButton.Visible = 0;
        end

        % Value changed function: LoczImagepeaksCheckBox
        function LoczImagepeaksCheckBoxValueChanged(app, event)
            app.OverlayDropDown.Value = 'Localizations';
            updatePlot(app,'normal')
        end

        % Button pushed function: ExportButton
        function ExportButtonPushed(app, event)
           
            switch app.ExportSelect.Value
                case 'data'
                    switch app.ExportFileFormat.Value
                      case 'Matlab workspace'
                    assignin('base','ImageTarget', app.ImageTarget);
                    assignin('base','ImagePreview', app.ImagePreview);
                    assignin('base','ImageInfo', app.ImageInfo);
                    assignin('base','ref', app.ref);
                    assignin('base','img_locs', app.img_locs);
                    assignin('base','Part', app.Part);                   
                    assignin('base','LineROI',app.LineROI);
                    assignin('base','LAFM',app.LAFM);
                    end
                case 'Plot 1'
                    switch app.ExportFileFormat.Value
                        case '.tiff'
                            switch app.FramePartSwitch.Value
                                case 'Frames'
                                    Out{1} = app.ImageTarget;
                                case 'Particles'
                                    Out{1} = app.Part.Image(:,:,app.Part.IncludeImages);
                            end
                            namesplit = split(app.ImageName,'.');
                            namesuggest = join(namesplit,"_");
                            export_tiffs(Out{1},namesuggest{1})
                        case {'.gif','.avi'}
                            updatePlot(app,'export video',app.ExportFileFormat.Value)
                        case {'.png','.jpeg','.pdf','.svg'}
                            updatePlot(app,'export frame',app.ExportFileFormat.Value)
                        case {'.txt', '.xls', '.csv'}
                            namesplit = split(app.ImageName,'.');
                            namesuggest = join(namesplit,"_");
                            [outputFileName,folder] = uiputfile([namesuggest{1},app.ExportFileFormat.Value;]);
                            fullFileName = fullfile(folder, outputFileName);
                            switch app.FramePartSwitch.Value
                                case 'Frames'
                                    Out{1} = app.ImageTarget;
                                case 'Particles'
                                    Out{1} = app.Part.Image(:,:,app.Part.IncludeImages);
                            end
                            N = numel(Out{1}(1,1,:));
                            img = Out{1};
                            Out = cell(1,N);
                            for k = 1:N
                                Out{k}=img(:,:,k);
                            end

                            switch app.ExportFileFormat.Value
                                case {'.txt','.csv'}
                                    for jj=1:numel(Out)
                                        if jj==1
                                            writematrix(Out{1},fullFileName);
                                        else
                                            writematrix(Out{jj},fullFileName,'WriteMode','append');
                                        end
                                    end

                                case '.xls'

                                    for jj=1:numel(Out)
                                        if jj==1
                                            writematrix(Out{1},fullFileName);
                                        else
                                            writematrix(Out{jj},fullFileName,'Sheet',jj,'WriteMode','append');
                                        end
                                    end
                            end
                    end

                        case 'Plot 2'
                           
                            switch app.RightPlotList.Value
                                case 'Line Profile'
                                    imagetype = 'plot';
                                    for jj = 1:numel(app.LineROI)
                                        Out{jj} = [app.LineROI(jj).Profile(:,1),app.LineROI(jj).Profile(:,2)];
                                    end
                                case 'Ref Image'
                                    imagetype = 'image';
                                    Out{1} = app.ref.image;
                                case 'Localizations'
                                    imagetype = 'plot';
                                    Out{1} = app.LAFM.Locs;
                                case 'LAFM'
                                    imagetype = 'image';
                                    Out{1} = app.LAFM.Image;
                                case 'LAFM sym'
                                    imagetype = 'image';
                                    Out{1} = app.LAFM.Image_sym;
                                case 'x & y Align'
                                    imagetype = 'plot';
                                    Out{1} = app.img_locs;
                                case 'Time Profile'
                                    imagetype = 'plot';
                                    Out{1} = app.CircleROI.Profile;
                                case 'Hist'
                                  imagetype = 'plot';
                                case 'Kymograph'
                                    imagetype = 'image';
                                    Out{1} = app.LineROI(1).kymo;
                            end
                            
                            
                            switch app.ExportFileFormat.Value
                                case '.tiff'
                                    namesplit = split(app.ImageName,'.');
                                    namesuggest = join(namesplit,"_");
                                    export_tiffs(Out{1},namesuggest{1})
                                case {'.gif','.avi'}
                                    updatePlot2(app,'export video',app.ExportFileFormat.Value,imagetype)
                                case {'.png','.jpeg','.pdf','.svg'}
                                    updatePlot2(app,'export frame',app.ExportFileFormat.Value,imagetype)
                                case {'.txt', '.xls', '.csv'}
                                    namesplit = split(app.ImageName,'.');
                                    namesuggest = join(namesplit,"_");
                                    [outputFileName,folder] = uiputfile([namesuggest{1},app.ExportFileFormat.Value;]);
                                    fullFileName = fullfile(folder, outputFileName);
                                    switch app.ExportFileFormat.Value
                                        case {'.txt','.csv'}
                                            for jj=1:numel(Out)
                                                if jj==1
                                                    writematrix(Out{1},fullFileName);
                                                else
                                                    writematrix(Out{jj},fullFileName,'WriteMode','append');
                                                end
                                            end

                                        case '.xls'

                                            for jj=1:numel(Out)
                                                if jj==1
                                                    writematrix(Out{1},fullFileName);
                                                else
                                                    writematrix(Out{jj},fullFileName,'Sheet',jj,'WriteMode','append');
                                                end
                                            end
                                    end
                            end
            end


        end

        % Button pushed function: FindParticlesButton
        function FindParticlesButtonPushed(app, event)
            app.CancelButton.Visible = 1;
               loading(app)
            app.Part.Image = [];
            app.Part.Locs = nan;
            filt_img = app.FilterImgEditField_Detect.Value;
            filt_ccr = app.FilterCCREditField_Detect.Value;

            switch app.PeaksRegionsSwitch.Value
                case 'Regions'
                    method = 'ccr';
                    if isfield(app.ref,'image')
                        if app.AutocentrereCheckBox.Value ==1
                            center_translation = FindCenterPositions(app.Symmetry_detect.Value, app.ref.image, 10);
                            app.ref.image = imtranslate(app.ref.image, -center_translation);
                        end
                        if ~app.MultiReferenceCheckBox.Value
                            refimg = app.ref.image;
                        else
                            refimg = app.ref.images;
                        end
                         angles = -str2num(app.SearchanglesEditField.Value);
                        [app.Part.Locs] = Detector(app, app.ImageTarget, method, refimg, filt_img, filt_ccr, app.Min_CCR_Edit.Value, app.ExcludeEdgeCheckBox.Value,...
                            app.RotationalFreedom.Value,angles);

                    if ~app.MultiReferenceCheckBox.Value
                        if isnan(app.Part.Locs)
                        else
                            app.Max_h_Edit.Value = max(app.Part.Locs(:,3));
                            app.Min_h_Edit.Value = min(app.Part.Locs(:,3));
                            app.Peaks_minHeight.Value = app.Min_h_Edit.Value;
                        end
                        if isnan(app.Part.Locs)
                             progressText.String = sprintf('0 particles detected');
                        else
            
                            %construct Particle image stack:
                            app.Part.IncludeImages = ones(numel(app.Part.Locs(:,3)),1);
                            app.Part.Image  = ConstructParticleStack2(app, app.ImageTarget, app.ref, app.Part);
                            app.BoxesCheckBox.Value=1;
                            app.OverlayDropDown.Value = 'Detections';
                            updatePlot(app,'normal')
                            updatePlot2(app,'normal')
                            switch app.Height_corr_switch.Value
                                case 'Height'
                                    app.CCRSliderMax.Limits = [app.Min_h_Edit.Value, app.Max_h_Edit.Value];
                                    app.CCRSliderMin.Limits =  app.CCRSliderMax.Limits;
                                case 'Correlation'
                                    app.CCRSliderMax.Limits = [min(app.Part.Locs(:,4)), 1];
                                    app.CCRSliderMin.Limits = [min(app.Part.Locs(:,4)), 1];
                            end
            
                            updateCCRHist(app)
                        end
                        filter_Partlocs(app)
                        finished(app)
                        storedata(app)
                         app.CancelButton.Visible = 0;

                    else
                        numPoints = size(app.Part.Locs{1}, 1);
                        maxCorrRefs = zeros(numPoints, 1);
                        maxCorrData = cell(numPoints, 1);
                        
                        for i = 1:numPoints % only currently works for same size locs arrays
                            maxCorrValue = -Inf; 
                            maxCorrRefData = [];

                            for j = 1:app.RefNo
                                corrValue = app.Part.Locs{j}(i, 4);

                                if corrValue > maxCorrValue
                                    maxCorrValue = corrValue; 
                                    maxCorrRefData = app.Part.Locs{j}(i, :);  % Store the data for the reference with the maximum correlation
                                end
                            end
                           
                            % Store the data for the reference with the maximum correlation value for the current point
                            maxCorrData{i} = maxCorrRefData;
                        end
                        locs = cell2mat(maxCorrData);
                        app.Part.Locs = locs;
                        if isnan(locs)
                        else 
                            app.Max_h_Edit.Value = max(locs(:,3));
                            app.Min_h_Edit.Value = min(locs(:,3));
                            app.Peaks_minHeight.Value = app.Min_h_Edit.Value;
                        end

                        if isnan(locs)
                             progressText.String = sprintf('0 particles detected');
                        else
                            for i = 1:app.RefNo

                                %construct Particle image stack:
                                app.Part.IncludeImages = ones(numel(locs(:,3)),1);
                                app.Part.Image  = ConstructParticleStack2(app, app.ImageTarget, {app.ref.images{i}; app.ref.positions{i}}, locs);
                                app.BoxesCheckBox.Value=1;
                                app.OverlayDropDown.Value = 'Detections';
                                updatePlot(app,'normal')
                                updatePlot2(app,'normal')
                                switch app.Height_corr_switch.Value
                                    case 'Height'
                                        app.CCRSliderMax.Limits = [app.Min_h_Edit.Value, app.Max_h_Edit.Value];
                                        app.CCRSliderMin.Limits =  app.CCRSliderMax.Limits;
                                    case 'Correlation'
                                        app.CCRSliderMax.Limits = [min(locs(:,4)), 1];
                                        app.CCRSliderMin.Limits = [min(locs(:,4)), 1];
                                end

                                updateCCRHist(app)
                            end
                            filter_Partlocs(app)
                            finished(app)
                            storedata(app)
                            app.CancelButton.Visible = 0;
                        end
                    end
                        
                    else
                         msgbox('Select an image reference by drawing an ROI');
                        return;
    
                    end
                case 'Peaks' % same method as above for multiref needs to be implimented
                    app.PreviewPeaks.Value =0;
                    app.ref.position(3) = app.BoxSizeEditField.Value;
                    app.ref.position(4) = app.ref.position(3);
                    refimg = [];
                    method = 'Peak picker';
                    [app.Part.Locs] = Detector(app, app.ImageTarget, method, app.Peaks_minSep.Value , filt_img, filt_ccr, app.Min_h_Edit.Value, app.ExcludeEdgeCheckBox.Value);
                    if isnan(app.Part.Locs)
                    else
                        app.Max_h_Edit.Value = double(max(app.Part.Locs(:,3)));
                        app.Min_h_Edit.Value = double(min(app.Part.Locs(:,3)));
                        app.Peaks_minHeight.Value = app.Min_h_Edit.Value;
                    end
                    if isnan(app.Part.Locs)
                         progressText.String = sprintf('0 particles detected');
                    else
        
                        %construct Particle image stack:
                        app.Part.IncludeImages = ones(numel(app.Part.Locs(:,3)),1);
                        app.Part.Image  = ConstructParticleStack2(app, app.ImageTarget, app.ref, app.Part);
                        app.BoxesCheckBox.Value=1;
                        app.OverlayDropDown.Value = 'Detections';
                        updatePlot(app,'normal')
                        updatePlot2(app,'normal')
                        switch app.Height_corr_switch.Value
                            case 'Height'
                                app.CCRSliderMax.Limits = [app.Min_h_Edit.Value, app.Max_h_Edit.Value];
                                app.CCRSliderMin.Limits =  app.CCRSliderMax.Limits;
                            case 'Correlation'
                                app.CCRSliderMax.Limits = [min(app.Part.Locs(:,4)), 1];
                                app.CCRSliderMin.Limits = [min(app.Part.Locs(:,4)), 1];
                        end
        
                        updateCCRHist(app)
                    end
                    filter_Partlocs(app)
                    finished(app)
                    storedata(app)
                     app.CancelButton.Visible = 0;
                end

        end

        % Value changed function: FramePartSwitch
        function FramePartSwitchValueChanged(app, event)
            if isfield(app.Part,'IncludeImages')
                app.Spinner.Value=1;
                app.FrameSlider.Value =1;
                updateVideoTools(app)
                app.MarkersCheckBox.Value = 0;
                app.BoxesCheckBox.Value = 0;
                app.OverlayValues.Value = 'None';
                app.TrackLengthEditField.Value = 0;
                if strcmp(app.FramePartSwitch.Value,'Particles')
                    filter_Partlocs(app)
                else
                end
                updatePlot(app,'normal')
                set(app.UIAxes,'xlimMode', 'auto','ylimMode', 'auto')
            else
                app.FramePartSwitch.Value = 'Frames';
                updateVideoTools(app)
            end

        end

        % Value changed function: Peaks_minHeight
        function Peaks_minHeightValueChanged(app, event)
            app.Min_h_Edit.Value= app.Peaks_minHeight.Value;
            updatePlot(app,'normal')
        end

        % Value changed function: Min_h_Edit
        function Min_h_EditValueChanged(app, event)
            app.Peaks_minHeight.Value = app.Min_h_Edit.Value;
            updatePlot(app,'normal')
        end

        % Window button down function: NanoLocz1_00Pre
        function NanoLocz1_00PreWindowButtonDown(app, event)
            img = hittest(app.NanoLocz1_00Pre);
             
            if isa(img, 'matlab.graphics.primitive.Rectangle')
                type = 'rectHandle';
                ax = app.UIAxes;
                fig = ancestor(img, 'figure');
                props.WindowButtonMotionFcn = get(fig, 'WindowButtonMotionFcn');
                props.WindowButtonUpFcn = get(fig, 'WindowButtonUpFcn');
                setappdata(fig, 'TestGuiCallbacks', props);
                set(fig, 'WindowButtonMotionFcn', @(src, evt) dragging_sq(src, evt, ax,type));
                set(fig, 'WindowButtonUpFcn', @(src, evt) mouseup_sq(src, evt, ax));

                ax.UserData.startPos = [ax.UserData.rectHandle.Position(1),ax.UserData.rectHandle.Position(2)];
                ax.UserData.points = [];
            end

            %  if isa(img, 'matlab.graphics.primitive.Line')
            %     type = 'lineHandle';
            %      set(app.UIAxes_2,'fontname','Ariel','fontsize', 14,'TickDir','out')
            %         k = numel(app.LineROI);
            %          C = hsv(8);
            %          C = [C ;   jet(8)];
            %          C = [C ;   parula(8)];
            %     ax = app.UIAxes;
            %     fig = ancestor(img, 'figure');
            %     props.WindowButtonMotionFcn = get(fig, 'WindowButtonMotionFcn');
            %     props.WindowButtonUpFcn = get(fig, 'WindowButtonUpFcn');
            %     setappdata(fig, 'TestGuiCallbacks', props);
            %     set(fig, 'WindowButtonMotionFcn', @(src, evt) dragging_sq(src, evt, ax,type));
            %     set(fig, 'WindowButtonUpFcn', @(src, evt) mouseup_sq(src, evt, ax));
            % 
            %     ax.UserData.startPos = [img.XData(1),img.YData(1)];
            %     ax.UserData.points = [];
            % 
            % end
            % 

            if isa(img, 'matlab.graphics.primitive.Image') && (app.ROIThresholdButton.Value==1  || app.Sq_roi_Button.Value==1 || app.Line_roi_Button.Value==1 || ...
                    app.Point_roi_Button.Value==1 || app.Circ_roi_Button.Value==1)
                if app.MultiReferenceCheckBox.Value == 0
                    if app.Sq_roi_Button.Value==1
                        type = 'rectHandle';
                        app.SquareROI = [];
                    elseif app.Line_roi_Button.Value==1
                        type = 'lineHandle';
                        set(app.UIAxes_2,'fontname','Ariel','fontsize', 14,'TickDir','out')
                        k = numel(app.LineROI)+1;
                         C = hsv(8);
                         C = [C ;   jet(8)];
                         C = [C ;   parula(8)];
                    elseif app.Point_roi_Button.Value==1
                        type = 'markerHandle';
                        k = numel(app.PointROI)+1;
                        C = hsv(8);
                        C = [C ;   jet(8)];
                        C = [C ;   parula(8)];
                    elseif app.Circ_roi_Button.Value==1
                        type = 'circleHandle';
                    elseif app.ROIThresholdButton.Value==1
                        type = 'scribble';
                    end

                else
                    type = 'rectHandle';
                end

                ax = app.UIAxes;
                fig = ancestor(img, 'figure');
                props.WindowButtonMotionFcn = get(fig, 'WindowButtonMotionFcn');
                props.WindowButtonUpFcn = get(fig, 'WindowButtonUpFcn');
                setappdata(fig, 'TestGuiCallbacks', props);
                set(fig, 'WindowButtonMotionFcn', @(src, evt) dragging_sq(src, evt, ax,type));
                set(fig, 'WindowButtonUpFcn', @(src, evt) mouseup_sq(src, evt, ax));

                if isfield(ax.UserData, type)
                    if app.MultiReferenceCheckBox.Value == 0
                        delete(ax.UserData.(type));
                        ax.UserData = rmfield(ax.UserData, type);
                        % Remove any previously drawn rectangle
                    else
                        app.ROIs{end+1} = ax.UserData.(type);
                    end

                end

                ax.UserData.startPos = ax.CurrentPoint(1, 1:2);
                ax.UserData.points = [];
            end


            function dragging_sq(~, ~, ax, type)
                ax.XLim = ax.XLim;   ax.YLim = ax.YLim ;
                startPos = ax.UserData.startPos;
                currentPos = ax.CurrentPoint(1, 1:2);

                % Remove any previously drawn 
                if ~app.MultiReferenceCheckBox.Value && isfield(ax.UserData, type)
                    delete(ax.UserData.(type));
                    ax.UserData = rmfield(ax.UserData, type);
                end

                switch type
                    case 'rectHandle'
                        if ~app.MultiReferenceCheckBox.Value
                            % Draw the Rectangle
                            WidthHeight = abs(currentPos - startPos);
                            rect4 = [min(startPos(1), currentPos(1)), min(startPos(2), currentPos(2)), WidthHeight];
                            ax.UserData.rectHandle = rectangle('Parent', ax, 'Position', rect4, 'EdgeColor', 'w', 'LineWidth', 1);
                                p = round(ax.UserData.rectHandle.Position);
                                switch  app.FramePartSwitch.Value
                                    case 'Frames'
                                        img = app.ImageTarget;
                                    case 'Particles'
                                        img = app.Part.Image(:,:,app.Part.IncludeImages);
                                end
                                app.ref.ROIimage =  imcrop(img(:,:,round(app.FrameSlider.Value)), [p(1), p(2), p(3)-1, p(4)-1]);
                                app.ref.position = p;
                                app.SquareROI.Position = p;
                        end    

                        
                        
                        if sum(strcmp(app.RightPlotList.Items,'Ref Image')) <1
                            app.RightPlotList.Items = [app.RightPlotList.Items , {'Ref Image'}];
                        end
                        app.RightPlotList.Value = 'Ref Image';
                        app.RefCropButton.Visible = 1;
                        if sum(strcmp(app.DropDown.Items,'ROI Reference')) <1
                            app.DropDown.Items = [app.DropDown.Items , {'ROI Reference'}];
                        end
                        app.DropDown.Value = 'ROI Reference';
                        if p(3)>1 && p(4)>1
                        updateRightPlot(app)
                        end
                        drawnow;
                       
                        
                    case 'lineHandle'
                        if isfield(ax.UserData, 'textHandle')
                            prevTextHandle = ax.UserData.textHandle;
                            delete(prevTextHandle);  % Delete the previous text
                        end
                       
                        %plot lineprofile
                        app.LineROI(k).Position(:,1) = [startPos(1), currentPos(1)];
                        app.LineROI(k).Position(:,2) = [startPos(2), currentPos(2)];
                        if abs(startPos(1)-currentPos(1)) > 2 || abs(startPos(2)-currentPos(2)) > 2
                            if sum(strcmp(app.RightPlotList.Items,'Line Profile')) <1
                                app.RightPlotList.Items = [app.RightPlotList.Items , {'Line Profile'}];
                            end
                            app.RightPlotList.Value = 'Line Profile';
                            updatePlot2_type(app,'plot')
                            app.OverlayDropDown.Value = 'Line Profile';
                            updatePlot2(app,'live')
                            updateResultsTable(app,'Line Profile')
                        end

                        % Draw the Line
                        ax.UserData.lineHandle = line(ax, [startPos(1), currentPos(1)], [startPos(2), currentPos(2)], ...
                            'Color', C(k,:), 'LineWidth', 2);
                        dx = startPos(1)- currentPos(1);
                        dy = startPos(2)- currentPos(2);
                        angle_rad = atan2(dx, dy); angle_deg = -rad2deg(angle_rad);
                        if abs(angle_deg) <20  || abs(angle_deg) >160
                            py = app.UIAxes.XLim(2)/50; px = 0;
                        elseif abs(angle_deg)>70  && abs(angle_deg)<110
                            px = app.UIAxes.YLim(2)/50; py = -app.UIAxes.XLim(2)/50;
                        else
                            px = 0; py = 0;
                        end

                        dist = round( ((dx^2 + dy^2)^0.5)./app.ImageInfo.PixelPerNm, 1);

                        textHandle = text(app.UIAxes, mean([startPos(1), currentPos(1)])+py, mean([startPos(2), currentPos(2)])+px, [num2str(dist) 'nm'],'Color',C(k,:),'FontSize',12);
                        ax.UserData.textHandle = textHandle;
                        drawnow;

                    case 'circleHandle'
                        radius = norm(currentPos - startPos) / 2;
                        center = (currentPos + startPos) / 2;
                        angle = atan2(currentPos(2) - center(2), currentPos(1) - center(1));
                        startAngle = angle;
                        % Draw the circle
                        theta = linspace(startAngle, startAngle + 2 * pi, 100);
                        x = center(1) + radius * cos(theta);
                        y = center(2) + radius * sin(theta);
                        ax.UserData.circleHandle = line(ax, x, y, 'Color', 'w', 'LineWidth', 1);
                        drawnow;
                        app.CircleROI.Position = [radius,center(1), center(2)];
                       
                        if sum(strcmp(app.RightPlotList.Items,'Time Profile')) <1
                            app.RightPlotList.Items = [app.RightPlotList.Items , {'Time Profile'}];
                        end
                        app.RightPlotList.Value = 'Time Profile';
                        updatePlot2_type(app,'plot')
                        updatePlot2(app,'normal')

                    case 'markerHandle'
                        % 
                         if isfield(ax.UserData, 'textHandle')
                             prevTextHandle = ax.UserData.textHandle;
                             delete(prevTextHandle);  % Delete the previous text
                         end
                        hold(app.UIAxes,'on')
                        ax.UserData.markerHandle = plot(ax, currentPos(1), currentPos(2), ...
                           'Marker', 'o', 'MarkerSize', 4, 'MarkerFaceColor', C(k,:));

                        frame = round(app.Spinner.Value);

                        switch  app.FramePartSwitch.Value
                            case 'Frames'
                                switch  app.LeftPlotList.Value
                                    case 'Target'
                                        img = app.ImageTarget;
                                    case 'Preview'
                                        img = app.ImagePreview;
                                end
                            case 'Particles'
                                switch  app.LeftPlotList.Value
                                    case 'Target'
                                        img = app.Part.Image(:,:,app.Part.IncludeImages);
                                    case 'Preview'
                                        img = app.ImagePreview(:,:,app.Part.IncludeImages);
                                end
                        end
                        if frame <= app.Spinner.Limits(2)
                            prev = img(:,:,frame);
                        else
                            prev = img(:,:,1);
                        end
                        app.PointROI(k).Position = [currentPos(1), currentPos(2)];
       
                        app.PointROI(k).h = round(prev(round( app.PointROI(k).Position(2)),round( app.PointROI(k).Position(1))),2);
                        textHandle = text(app.UIAxes, app.PointROI(k).Position(1)+5, app.PointROI(k).Position(2),num2str( app.PointROI(k).h ),'Color',C(k,:),'FontSize',16,'FontWeight','bold');
                         ax.UserData.textHandle = textHandle;
                        drawnow;     

                    case 'scribble'
                        ax.UserData.points = [ax.UserData.points; ax.CurrentPoint(1, 1:2)];
                        % Draw the line connecting the current and previous points
                        line(app.UIAxes,ax.UserData.points(:, 1), ax.UserData.points(:, 2), 'Color', 'r', 'LineWidth', 2);
                        drawnow;
                end
            end

            function mouseup_sq(~, ~, ax)
                fig = ancestor(ax, 'figure');
                % Restore the original callbacks
                props = getappdata(fig, 'TestGuiCallbacks');
                set(fig, props);
                setappdata(fig, 'TestGuiCallbacks', []);
                ax.UserData.startPos = [];

                switch type
                    case 'lineHandle'
                        ax.UserData.lineHandle = line(ax, app.LineROI(k).Position(:,1), app.LineROI(k).Position(:,2), ...
                            'Color', C(k,:), 'LineWidth', 2);
                        drawnow;

                    case 'markerHandle'
                        hold(app.UIAxes,'on')
                        plot(ax, app.PointROI(k).Position(1), app.PointROI(k).Position(2), 'Marker', 'o', 'MarkerSize', 4, 'MarkerFaceColor', C(k,:));
                        text(ax, app.PointROI(k).Position(1)+5, app.PointROI(k).Position(2),num2str(app.PointROI(k).h),'Color',C(k,:),'FontSize',16,'FontWeight','bold');
                          drawnow;
                        hold(app.UIAxes,'off')
                    case 'scribble'
                        points = ax.UserData.points;
                        if size(points, 1) >= 2
                            % Connect the start point to the end point
                            line(app.UIAxes, [points(1, 1), points(end, 1)], [points(1, 2), points(end, 2)], ...
                                'Color', 'r', 'LineWidth', 2);
                            x = points(:, 1);
                            y = points(:, 2);
                            mask = freehandROItoLogicMatrix(x, y, size(ax.Children(end).CData));
                            s = any(app.ThresholdROI);

                            if s(1) ==1
                                app.ThresholdROI = app.ThresholdROI.*(mask< 1);
                            else
                                app.ThresholdROI =  mask< 1;
                            end
                        end
                        app.filter_already =0;
                        app.LeftPlotList.Value='Preview';
                        app.PreviewonoffButton.Value =1;
                        run_filter(app)
                         updatePlot2(app,'normal')
                        ax.UserData.points = [];
                end


            end

            function mask = freehandROItoLogicMatrix(x, y, imageSize)
                [X, Y] = meshgrid(1:imageSize(2), 1:imageSize(1));
                warning('off');
                polygon = polyshape(x, y);
                warning('on');
                mask = inpolygon(X(:), Y(:), polygon.Vertices(:, 1), polygon.Vertices(:, 2));
                mask = reshape(mask, imageSize);
            end
        end

        % Value changed function: Point_roi_Button
        function Point_roi_ButtonValueChanged(app, event)
            TurnOffButtons(app,'app.Point_roi_Button')
        end

        % Value changed function: Sq_roi_Button
        function Sq_roi_ButtonValueChanged(app, event)
            TurnOffButtons(app,'app.Sq_roi_Button')
        end

        % Value changed function: Circ_roi_Button
        function Circ_roi_ButtonValueChanged(app, event)
            TurnOffButtons(app,'app.Circ_roi_Button')
        end

        % Value changed function: Line_roi_Button
        function Line_roi_ButtonValueChanged(app, event)
            TurnOffButtons(app,'app.Line_roi_Button')
        end

        % Button pushed function: RenderLAFMButton
        function RenderLAFMButtonPushed(app, event)
            loading(app)
            pause(0.000001)

            switch  app.FramePartSwitch.Value
                case 'Frames'
                    img = app.ImageTarget;
                case 'Particles'
                    img = app.Part.Image(:,:,app.Part.IncludeImages);
            end
            try
                app.LAFM.Image = LAFM_render(img, app.LAFM.Locs, app.LAFM_gus.Value,  app.LAFM_LUT.Value, app.LAFM_exp.Value);
            catch
                app.FramePartSwitch.Value = 'Particles';
                img = [];
                  img = app.Part.Image(:,:,app.Part.IncludeImages);
                app.LAFM.Image = LAFM_render(img, app.LAFM.Locs, app.LAFM_gus.Value,  app.LAFM_LUT.Value, app.LAFM_exp.Value);

            end
            
            if sum(strcmp(app.RightPlotList.Items,'LAFM')) <1
                app.RightPlotList.Items = [app.RightPlotList.Items , {'LAFM'}];
            end
             set(app.UIAxes_2,'xlimMode', 'auto','ylimMode', 'auto')
    

             app.RightPlotList.Value = 'LAFM';
             RightPlotListValueChanged(app, event)
             finished(app)
             storedata(app)

             if  app.ViewSymmetrizedButton.Value ==1 && app.LAFM_sym_2.Value > 1
                   ViewSymmetrizedButtonValueChanged(app,event)
             end

        end

        % Callback function: CropButton, CropMenu
        function CropButtonPushed(app, event)
            if isfield(app.SquareROI,'Position')
                switch  app.FramePartSwitch.Value
                    case 'Frames'
                        img = app.ImageTarget;
                    case 'Particles'
                        img = app.Part.Image;
                end

                for i = 1:numel(img(1,1,:))
                    img_c(:,:,i) = imcrop(img(:,:,i),app.SquareROI.Position);
                end

                switch  app.FramePartSwitch.Value
                    case 'Frames'
                        app.ImageTarget = img_c;
                    case 'Particles'
                        app.Part.Image = img_c;
                end
            end
            set(app.UIAxes,'xlimMode', 'auto','ylimMode', 'auto')
            updatePlot(app,'normal')
            updatePlot2(app,'normal')
            storedata(app)
        end

        % Value changed function: Sq_roi_Button_2
        function Sq_roi_Button_2ValueChanged(app, event)
            if app.Sq_roi_Button_2.Value ==1
                app.Sq_roi_Button.Value =1;
                TurnOffButtons(app,'app.Sq_roi_Button')
                app.Sq_roi_Button_2.Value =1;
            else
                app.Sq_roi_Button.Value =0;
            end
           
        end

        % Value changed function: ROIThresholdButton
        function ROIThresholdButtonValueChanged(app, event)
            TurnOffButtons(app,'app.ROIThresholdButton')
        end

        % Button pushed function: ClearROIButton
        function ClearROIButtonPushed(app, event)
            app.ThresholdROI = [];
            app.filter_already =0;
            app.LeftPlotList.Value='Preview';
            app.PreviewonoffButton.Value =1;
            run_filter(app)
            updatePlot(app,'normal')
             updatePlot2(app,'normal')
           
        end

        % Callback function: FolderMenu, OpenFolderButton
        function OpenFolderButtonClicked(app, event)
            
selection = questdlg('Select a folder or a session file', 'Open', 'Folder', 'Session File', 'Cancel', 'Folder');

if strcmp(selection, 'Folder')
    app.OpenFolder = uigetdir;
    updateFolder(app)
elseif strcmp(selection, 'Session File')
    [filename, pathname] = uigetfile('.mat', 'Select session file');
    if isequal(filename, 0) || isequal(pathname, 0)
    else
        filepath = fullfile(pathname, filename);
        loadedData = load(filepath);
        app.stored = loadedData.Images;
        app.OpenFolder = loadedData.WorkingFolder;
    end
    updateFolder(app)
else
end


        end

        % Callback function: SaveMenu, SaveSession
        function SaveSessionImageClicked(app, event)
            switch app.SaveType.Value
                case 'Current File'
                    ch = contains({app.stored.ImageName},app.FilesListBox.Value);
                    Images = app.stored(ch);
                    namesplit = split(app.stored(ch).ImageName,'.');
                    namesuggest = join(namesplit,"_") + "_edited."+"mat";
                    WorkingFolder = app.OpenFolder;
                case 'All Processed'
                    Images = app.stored;
                    [~, namesplit, ~] = fileparts(app.OpenFolder);
                    namesuggest = join(namesplit,"_") + "_session."+"mat";
                    WorkingFolder = app.OpenFolder;
            end

            [filename, pathname] = uiputfile(namesuggest, 'Save App Data');
            if isequal(filename, 0) || isequal(pathname, 0)
            else
                filepath = fullfile(pathname, filename);
                save(filepath, 'Images','WorkingFolder');
            end
        end

        % Menu selected function: OpenSessionMenu
        function OpenSessionMenuSelected(app, event)
            [filename, pathname] = uigetfile('.mat', 'Load App Data');
            if isequal(filename, 0) || isequal(pathname, 0)
            else
                filepath = fullfile(pathname, filename);
                loadedData = load(filepath);
                app.stored = loadedData.Images;
                app.OpenFolder = loadedData.WorkingFolder;
            end
             updateFolder(app)
        end

        % Button down function: DetectTab
        function DetectTabButtonDown(app, event)
             app.LoczImagepeaksCheckBox.Value =0;
             app.FramePartSwitch.Value = 'Frames';
             updateVideoTools(app)
        end

        % Button down function: AlignTab
        function AlignTabButtonDown(app, event)
             app.LoczImagepeaksCheckBox.Value =0;
              app.FramePartSwitch.Value = 'Frames';
              updateVideoTools(app)

        end

        % Value changed function: HistPlot
        function HistPlotValueChanged(app, event)
            if app.HistPlot.Value ==1
                HistValueValueChanged(app)
                updatePlot2_type(app,'plot')
                if sum(strcmp(app.RightPlotList.Items,'Hist')) <1
                    app.RightPlotList.Items = [app.RightPlotList.Items , {'Hist'}];
                end
                app.RightPlotList.Items = {'Hist'};
                app.HistBin.Visible =1;
                app.HistValue.Visible =1;
            else
                app.HistBin.Visible =0;
                app.HistValue.Visible =0;
                app.RightPlotList.Items = {'Off'};
            end
             updatePlot2(app,'normal')
        end

        % Value changed function: HistValue
        function HistValueValueChanged(app, event)
            try
                switch app.HistValue.Value
                    case 'Particle Height'
                        values = app.Part.Locs(:,3);
                        sf =2;
                    case 'Particle CCR'
                        values = app.Part.Locs(:,4);
                        sf =2;
                    case 'Particle Angle'
                        values = app.Part.Locs(:,8);
                        sf =2;
                    case 'Radial distribution'
                        sf =1;
                        x = app.Part.Locs(app.Part.IncludeImages,1);
                        y = app.Part.Locs(app.Part.IncludeImages,2);
                        t = app.Part.Locs(app.Part.IncludeImages,5);
                       values =[];

                        for i = 1:max(t)
                            per_frame=[];
                            pos = t==i;
                            positions = [x(pos), y(pos)];
                            for j = 1:sum(pos)%for each particle
                                for jj = 1:sum(pos)
                                    distances{j}(jj,:) = norm(positions(j, :) - positions(jj, :));
                                end
                                per_frame = [per_frame; distances{j}] ;
                            end
                            values = [values; per_frame] ;
                        end
                        values = values./app.ImageInfo.PixelPerNm;
                        app.RadialDist = values(values>0);
                end

                bin_mx = round(max(values),sf);
                bin_mn =  round(min(values),sf);
                int = round((bin_mx -bin_mn)/30,sf);
                app.HistBin.Value = sprintf('%g:%g:%g', bin_mn, int, bin_mx);

                 updatePlot2(app,'normal')
            catch
            end
        end

        % Value changed function: HistBin
        function HistBinValueChanged(app, event)
        updatePlot2(app,'normal')
        end

        % Button pushed function: PopAx2
        function PopAx2Pushed(app, event)
            updatePlot2(app,'popout')
        end

        % Button pushed function: PopAx1
        function PopAx1ButtonPushed(app, event)
              updatePlot(app,'popout')
        end

        % Value changed function: PlotTypeDropDown
        function PlotTypeDropDownValueChanged(app, event)

            switch app.PlotTypeDropDown.Value
                case '2D surface'
                    app.UIAxes.Toolbar.Visible = 'off';
                    pan(app.UIAxes,'on')
                    pan(app.UIAxes,'off')
                case '3D surface'
                    app.UIAxes.Toolbar.Visible = 'on';
                case 'Coordinates'
                    app.UIAxes.Toolbar.Visible = 'on';
            end

              updatePlot(app,'normal')
        end

        % Value changed function: ZoomIn
        function ZoomInValueChanged(app, event)
      if app.ZoomIn.Value ==1
           zoom(app.UIAxes,'on')
                app.Point_roi_Button.Value =0;
                app.Line_roi_Button.Value =0;
                app.Sq_roi_Button.Value =0;
                app.Circ_roi_Button.Value =0;
                app.Sq_roi_Button_2.Value =0;
                app.ROIThresholdButton.Value =0;
      else
          zoom(app.UIAxes,'off')
      end

        end

        % Button pushed function: AlignButton
        function AlignButtonPushed(app, event)
            [app.LineROI] = LineAlign(app.LineROI,app.AlignLineType.Value);
            updatePlot2(app,'normal')
        end

        % Value changed function: BidirectionaldataCheckBox
        function BidirectionaldataCheckBoxValueChanged(app, event)
            if app.BidirectionaldataCheckBox.Value == 1
                app.FixShiftValue.Visible = 1;
                app.FixShiftMethod.Visible = 1;
                app.FixLineShift.Visible = 1;
            else
                app.FixShiftValue.Visible = 0;
                app.FixShiftMethod.Visible = 0;
                app.FixLineShift.Visible = 0;
            end
        end

        % Button pushed function: FitButton
        function FitButtonPushed(app, event)

            fo = fitoptions('method','NonlinearLeastSquares');
            t = app.ImageTarget(:,:,:);
            [hy, x]=  hist(t(:),100);
            gfit  = fit(double(x'),hy','gauss1',fo);
            if gfit.b1 +1.5*gfit.c1 <app.SliderMax.Value 
            app.SliderMax.Value = gfit.b1 +1.5*gfit.c1;
            end
            if  gfit.b1 -1.5*gfit.c1 > app.SliderMin.Value
            app.SliderMin.Value = gfit.b1 -1.5*gfit.c1;
            end

            delete(app.patches.histup)
             delete(app.patches.histdown)
             app.filter_already =0;
             run_filter(app)
             app.patches.histup = patch(app.Hist_Axes,[app.SliderMax.Limits(2) app.SliderMax.Value app.SliderMax.Value app.SliderMax.Limits(2)], [app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(1),  app.Hist_Axes.YLim(2)  app.Hist_Axes.YLim(2)],...
                 'r', 'FaceAlpha', 0.5,'EdgeColor','none');
             app.patches.histdown = patch(app.Hist_Axes,[app.SliderMin.Value app.SliderMin.Limits(1) app.SliderMin.Limits(1) app.SliderMin.Value], [app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(1),  app.Hist_Axes.YLim(2)  app.Hist_Axes.YLim(2)],...
                 'r', 'FaceAlpha', 0.5,'EdgeColor','none');
             switch app.ThresholdContrastSwitch.Value
                 case 'Contrast'
                     app.ZScaleDropBox.Value = 'Histogram';
                 case 'Threshold'
             end

        end

        % Value changing function: LAFMMaxSlider
        function LAFMMaxSliderValueChanging(app, event)
            app.LAFMMaxSlider.Value = event.Value;
            updatePlot2(app,'normal')
        end

        % Value changing function: LAFMMinSlider
        function LAFMMinSliderValueChanging(app, event)

            app.LAFMMinSlider.Value = event.Value;
            updatePlot2(app,'normal')
        end

        % Value changed function: ViewSymmetrizedButton
        function ViewSymmetrizedButtonValueChanged(app, event)
       
            if app.ViewSymmetrizedButton.Value ==1 && app.LAFM_sym_2.Value > 1

                if strcmp(app.LAFM_LUT.Value,'LAFM') && app.AutoCenterLAFM.Value == 1
                    t = rgb2gray(app.LAFM.Image);
                else
                    t = app.LAFM.Image;
                end

                if app.AutoCenterLAFM.Value == 1
                    center_translation = FindCenterPositions(app.LAFM_sym_2.Value, t, 100);
                 
                else
                    center_translation = [0 0];
                end

                app.LAFM.Image_sym = rotation_sym(imtranslate(app.LAFM.Image, -center_translation), app.LAFM_sym_2.Value);

                if strcmp(app.LAFM_LUT.Value,'LAFM')
                    app.LAFM.Image_sym =  (app.LAFM.Image_sym-min(app.LAFM.Image_sym(:)))./(max(app.LAFM.Image_sym(:))-min(app.LAFM.Image_sym(:)));
                end


                if sum(strcmp(app.RightPlotList.Items,'LAFM sym')) <1
                    app.RightPlotList.Items = [app.RightPlotList.Items , {'LAFM sym'}];
                end
                app.RightPlotList.Value = 'LAFM sym';
                
            else
                if sum(strcmp(app.RightPlotList.Items,'LAFM')) <1
                    app.RightPlotList.Items = [app.RightPlotList.Items , {'LAFM'}];
                end
                app.RightPlotList.Value = 'LAFM';
               
            end

            set(app.UIAxes_2,'xlimMode', 'auto','ylimMode', 'auto')
            RightPlotListValueChanged(app, event)
        end

        % Value changed function: LAFM_sym_2
        function LAFM_sym_2ValueChanged(app, event)
      ViewSymmetrizedButtonValueChanged(app,event)
            
        end

        % Value changed function: AutoCenterLAFM
        function AutoCenterLAFMValueChanged(app, event)
            ViewSymmetrizedButtonValueChanged(app,event)
        end

        % Button pushed function: ApplyButton
        function ApplyButtonPushed(app, event)
           s = app.RoiareaEditField.Value;
            app.ref.position(3) =  app.ref.position(3) + 2*s;
            app.ref.position(4) =  app.ref.position(4) + 2*s;
               app.Part.Image  = ConstructParticleStack2(app, app.ImageTarget, app.ref, app.Part);
               if s >0
               app.ref.image =  padarray( app.ref.image ,[s, s],0,'both');
               else
                  
                   app.ref.image =  app.ref.image(1-s:end+s, 1-s:end+s);
               end

               updatePlot(app,'normal')
                updatePlot2(app,'normal')

        end

        % Button pushed function: kymo
        function kymoButtonPushed(app, event)

            if numel(app.LineROI) >0  && ~isfield(app.LineROI,'kymo')
               switch  app.FramePartSwitch.Value
                case 'Frames'
                    img = app.ImageTarget;
                case 'Particles'
                    img = app.Part.Image(:,:,app.Part.IncludeImages);
            end

                for i = 1:numel(img(1,1,:))
                    [~,~,ch] = improfile(img(:,:,i),app.LineROI(1).Position(:,1),app.LineROI(1).Position(:,2));
                    app.LineROI(1).kymo(:,i) = ch;
                end
            end

            if isfield(app.LineROI,'kymo')
                if sum(strcmp(app.RightPlotList.Items,'Kymograph')) <1
                    app.RightPlotList.Items = [app.RightPlotList.Items , {'Kymograph'}];
                end
                app.RightPlotList.Value='Kymograph';
            end

            RightPlotListValueChanged(app, event)
            updatePlot2(app,'normal')

        end

        % Button pushed function: CancelButton
        function CancelButtonPushed(app, event)
            app.stop = 1;
             app.CancelButton.Visible = 0;
             finished(app)
        end

        % Value changed function: LAFMScalebarCheckBox
        function LAFMScalebarCheckBoxValueChanged(app, event)
            updatePlot2(app,'normal')
        end

        % Button down function: LevelTab
        function LevelTabButtonDown(app, event)
       app.FramePartSwitch.Value = 'Frames';
       updateVideoTools(app)
        end

        % Value changed function: FilesDropDown
        function FilesDropDownValueChanged(app, event)
            switch app.FilesDropDown.Value
                case 'All files'
                updateFolder(app)
                case 'Processed'
                app.FilesListBox.Items = {app.stored.ImageName};
            end
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)

            switch  app.FramePartSwitch.Value
                case 'Frames'
                    img = app.ImageTarget;
                case 'Particles'
                    img = app.Part.Image(:,:,app.Part.IncludeImages);
            end
            img = padarray(img,[2,2],1000,'both');
            aspectRatio =  16/9;
            numFrames = size(img, 3);
            cols = ceil(sqrt(numFrames * aspectRatio));
            rows = ceil(numFrames / cols);
            imageSize = size(img(:, :, 1));
            montageWidth = cols * imageSize(2);
            montageHeight = rows * imageSize(1);
            montageMatrix = zeros(montageHeight, montageWidth);
            currentRow = 1;
            currentCol = 1;

            for i = 1:numFrames
                rowIndices = currentRow : currentRow + imageSize(1) - 1;
                colIndices = currentCol : currentCol + imageSize(2) - 1;

                montageMatrix(rowIndices, colIndices) = img(:, :, i);
                currentCol = currentCol + imageSize(2);

                if currentCol > montageWidth
                    currentCol = 1;
                    currentRow = currentRow + imageSize(1);
                end
            end
            figure('Position', [100, 100, 1.3*800, 1.3*450]);
            
            try
                imagesc(montageMatrix,clim(app.UIAxes));
            catch
                imagesc(montageMatrix,caxis(app.UIAxes));
            end

            switch app.ColourmapDropDown.Value
                case 'AFM brown'
                    colormap(app.cmap.AFM_brown)
                case 'AFM gold'
                    colormap(app.cmap.AFM_orange)
                case'fire'
                    colormap(app.cmap.AFM_fire)
                otherwise
                    colormap(app.ColourmapDropDown.Value)
            end
           
            axis equal tight off; % Set equal axes and hide axis ticks
            
        end

        % Menu selected function: BottomRightMenu
        function BottomRightMenuSelected(app, event)
            app.label.ScaleBar.position = 'Bottom Right';
            updatePlot(app,'normal')
        end

        % Menu selected function: BottomLeftMenu
        function BottomLeftMenuSelected(app, event)
                  app.label.ScaleBar.position = 'Bottom Left';
            updatePlot(app,'normal')
        end

        % Menu selected function: TopRightMenu
        function TopRightMenuSelected(app, event)
                  app.label.ScaleBar.position = 'Top Right';
            updatePlot(app,'normal')
        end

        % Menu selected function: TopLeftMenu
        function TopLeftMenuSelected(app, event)
                  app.label.ScaleBar.position = 'Top Left';
            updatePlot(app,'normal')
        end

        % Menu selected function: BlackMenu
        function BlackMenuSelected(app, event)
            app.label.ScaleBar.color = 'k';
            updatePlot(app,'normal')
        end

        % Menu selected function: WhiteMenu
        function WhiteMenuSelected(app, event)
                 app.label.ScaleBar.color = 'w';
            updatePlot(app,'normal')
        end

        % Menu selected function: CyanMenu
        function CyanMenuSelected(app, event)
                 app.label.ScaleBar.color = 'c';
            updatePlot(app,'normal')
        end

        % Menu selected function: MagentaMenu
        function MagentaMenuSelected(app, event)
                 app.label.ScaleBar.color = 'm';
            updatePlot(app,'normal')
        end

        % Menu selected function: BlueMenu
        function BlueMenuSelected(app, event)
                 app.label.ScaleBar.color = 'b';
            updatePlot(app,'normal')
        end

        % Menu selected function: GreenMenu
        function GreenMenuSelected(app, event)
                 app.label.ScaleBar.color = 'g';
            updatePlot(app,'normal')
        end

        % Menu selected function: YellowMenu
        function YellowMenuSelected(app, event)
                 app.label.ScaleBar.color = 'y';
            updatePlot(app,'normal')
        end

        % Menu selected function: TopLeftMenu_2
        function TopLeftMenu_2Selected(app, event)
            app.label.TimeStamp.position = 'Top Left';
            updatePlot(app,'normal')
        end

        % Menu selected function: TopRightMenu_2
        function TopRightMenu_2Selected(app, event)
            app.label.TimeStamp.position = 'Top Right';
            updatePlot(app,'normal')
        end

        % Menu selected function: BottomRightMenu_2
        function BottomRightMenu_2Selected(app, event)
            app.label.TimeStamp.position = 'Bottom Right';
            updatePlot(app,'normal')
        end

        % Menu selected function: BottomLeftMenu_2
        function BottomLeftMenu_2Selected(app, event)
            app.label.TimeStamp.position = 'Bottom Left';
            updatePlot(app,'normal')
        end

        % Menu selected function: BlackMenu_2
        function BlackMenu_2Selected(app, event)
            app.label.TimeStamp.color = 'k';
            updatePlot(app,'normal')
        end

        % Menu selected function: WhiteMenu_2
        function WhiteMenu_2Selected(app, event)
            app.label.TimeStamp.color = 'w';
            updatePlot(app,'normal')
        end

        % Menu selected function: CyanMenu_2
        function CyanMenu_2Selected(app, event)
            app.label.TimeStamp.color = 'c';
            updatePlot(app,'normal')
        end

        % Menu selected function: MagentaMenu_2
        function MagentaMenu_2Selected(app, event)
            app.label.TimeStamp.color = 'm';
            updatePlot(app,'normal')
        end

        % Menu selected function: BlueMenu_2
        function BlueMenu_2Selected(app, event)
            app.label.TimeStamp.color = 'b';
            updatePlot(app,'normal')
        end

        % Menu selected function: GreenMenu_2
        function GreenMenu_2Selected(app, event)
                app.label.TimeStamp.color = 'g';
            updatePlot(app,'normal')
        end

        % Menu selected function: YellowMenu_2
        function YellowMenu_2Selected(app, event)
                app.label.TimeStamp.color = 'y';
            updatePlot(app,'normal')
        end

        % Menu selected function: blackMenu
        function blackMenuSelected(app, event)
              app.ExportSettings.color = 'black';
        end

        % Menu selected function: whiteMenu
        function whiteMenuSelected(app, event)
              app.ExportSettings.color = 'white';
        end

        % Menu selected function: dpi75
        function dpi75MenuSelected(app, event)
            app.ExportSettings.resolution = 75;
        end

        % Menu selected function: dpi150
        function dpi150MenuSelected(app, event)
            app.ExportSettings.resolution = 150;
        end

        % Menu selected function: dpi300
        function dpi300MenuSelected(app, event)
            app.ExportSettings.resolution = 300;
        end

        % Menu selected function: dpi450
        function dpi450MenuSelected(app, event)
            app.ExportSettings.resolution = 450;
        end

        % Value changed function: Hist_excludeOut
        function Hist_excludeOutValueChanged(app, event)
            if app.Hist_excludeOut.Value==1
               T = reshape(app.ImageTarget(:,:,:),1,[]);
                T = rmoutliers(T,"percentiles",[5 95]);
            else
                T = app.ImageTarget;
            end
            min_all = double(min(T,[],'all'));
            max_all = double(max(T,[],'all'));
            app.SliderMax.Limits = [min_all(1), max_all(1)];
            app.SliderMin.Limits = [min_all(1), max_all(1)];
            app.SliderMax.Value = max_all;
            app.SliderMin.Value = min_all;
            updateHist(app)
        end

        % Menu selected function: OpenMat_SimAFMMenu
        function OpenMat_SimAFMMenuSelected(app, event)
            app.PopupApp = Mat_SimAFM_v1_5();
        end

        % Button pushed function: ThumbnailViewButton
        function ThumbnailViewButtonPushed(app, event)
            app.ThumbnailApp = thumbnail(app.FilesListBox.Items);
        end

        % Value changed function: DropDown
        function DropDownValueChanged(app, event)
            if app.MultiReferenceCheckBox.Value == 0
            % if ~isempty(app.ref.image)
            %     app.DropDown.Visible = 1;
            %     app.DropDown.Enable = 1;
            % end
                switch app.DropDown.Value
                    case 'ROI Reference'
                        app.ref.image = app.ref.ROIimage;
                        updatePlot2_type(app, 'image')
                        updateRightPlot(app);
                    case 'Simulated Reference'
                        app.ref.image = app.ref.simImage;
                        updatePlot2_type(app, 'image')
                        updateRightPlot(app);
                    case 'LAFM Reference'
                        app.ref.image = app.ref.LAFM;
                        updatePlot2_type(app, 'image')
                        updateRightPlot(app);
                    case 'Averaged Reference'
                       app.ref.image = app.ref.av;
                        updatePlot2_type(app, 'image')
                        updateRightPlot(app); 
                end
            end
        end

        % Button pushed function: RefCropButton
        function RefCropButtonPushed(app, event)
            img = hittest(app.NanoLocz1_00Pre);
            ax = app.UIAxes_2;
            app.ref.crop = 1;
            app.ClearButton_2.Visible = 1;
            Freehandroi = drawfreehand(ax,'Color','r'); 
            ax.UserData.roi = Freehandroi;

            if ~isempty(ax.UserData.roi)
                roiPoints = ax.UserData.roi.Position;
                
                if ~isempty(roiPoints)
                    minX = min(roiPoints(:, 1));
                    maxX = max(roiPoints(:, 1));
                    minY = min(roiPoints(:, 2));
                    maxY = max(roiPoints(:, 2));
                    width = maxX - minX;
                    height = maxY - minY;
            
                    app.ref.orgImage = app.ref.image;
                    image = app.ref.image;

                    if ~app.MultiReferenceCheckBox.Value
                        mask = poly2mask(roiPoints(:, 1), roiPoints(:, 2), size(image, 1), size(image, 2));
                        maskImage = bsxfun(@times, image, cast(mask, 'like', image));
                        croppedImage = imcrop(maskImage, [minX, minY, width, height]);
                        switch app.DropDown.Value
                            case 'ROI Reference'
                                app.ref.ROIimage = croppedImage;   
                            case 'Simulated Reference'
                                app.ref.simImage = croppedImage;     
                            case 'LAFM Reference'
                                app.ref.LAFM = croppedImage;
                            case 'Averaged Reference'
                                app.ref.av = croppedImage;
                        end
                    else
                        mask = poly2mask(roiPoints(:, 1), roiPoints(:, 2), size(image{1}, 1), size(image{1}, 2));
                        maskImage = bsxfun(@times, image{1}, cast(mask, 'like', image{1}));
                        croppedImage = imcrop(maskImage, [minX, minY, width, height]);
                        num = app.ReferenceButtonGroup.SelectedObject.Text;
                        app.ref.croppedimg{str2double(num)} = croppedImage;
                    end

                    app.ref.image = croppedImage;
                    app.ref.position = [minX, minY, width, height];
                    updatePlot2_type(app, 'image')
                    updateRightPlot(app);
                end
            end
        %app.ref = rmfield(app.ref, 'crop');
        end

        % Value changed function: MultiReferenceCheckBox
        function MultiReferenceCheckBoxValueChanged(app, event)
            if app.MultiReferenceCheckBox.Value == 1
                app.RefNo = str2double(inputdlg('How many references would you like to use?'));
                ax = app.UIAxes;
                %button_text = 'Reference ';
                for i = 1:app.RefNo
                    app.ROIs{i} = drawrectangle(ax);
                    p = app.ROIs{i}.Position;
                    switch  app.FramePartSwitch.Value
                        case 'Frames'
                            img = app.ImageTarget;
                        case 'Particles'
                            img = app.Part.Image(:,:,app.Part.IncludeImages);
                    end
                    app.ref.ROIimage =  imcrop(img(:,:,round(app.FrameSlider.Value)), [p(1), p(2), p(3)-1, p(4)-1]);
                    if sum(strcmp(app.RightPlotList.Items,'Ref Image')) < 1
                            app.RightPlotList.Items = [app.RightPlotList.Items , {'Ref Image'}];
                    end
                    app.RightPlotList.Value = 'Ref Image';
                    %text3 = [button_text, num2str(i)];

                    buttonWidth = 150;
                    buttonHeight = 30;
                    totalHeight = app.RefNo * buttonHeight + (app.RefNo - 1) * 10;
                    startY = app.ReferenceButtonGroup.Position(4) - totalHeight - 10;
                    y = startY + (i - 1) * (buttonHeight + 10);
                    uiradiobutton(app.ReferenceButtonGroup, 'Text', num2str(i), 'Position', [10, y, buttonWidth, buttonHeight]);
                   
                    app.ref.images{i} = app.ref.ROIimage;
                    app.ref.positions{i} = p;
                    
                end

                % want to remove the drawn rectangles from the axes

                app.ReferenceButtonGroup.Visible = 1;
                app.DropDown.Visible = 0;
                app.RefCropButton.Visible = 1;
                updatePlot2_type(app, 'image')
                updateRightPlot(app);
                if isprop(app.ref, 'crop')
                    app.ref.images{i} = app.ref.ROIimage;
                end
            else
                app.ReferenceButtonGroup.Visible = 0;
                app.DropDown.Visible = 1;
                buttons = app.ReferenceButtonGroup.Children;
                delete(buttons);
                if isprop(app.ref, 'crop')
                    app.ref.images{i} = app.ref.ROIimage;
                end
                if sum(strcmp(app.RightPlotList.Items,'Ref Image')) == 1
                    indexToDelete = find(strcmp(app.RightPlotList.Items, 'Ref Image'));
                    app.RightPlotList.Items(indexToDelete) = [];
                end
            end    
        end

        % Button pushed function: ClearButton_2
        function ClearButton_2Pushed(app, event)
            if ~app.MultiReferenceCheckBox.Value
                switch app.DropDown.Value
                    case 'ROI Reference'
                        app.ref.ROIimage = app.ref.orgImage;   
                    case 'Simulated Reference'
                        app.ref.simImage = app.ref.orgImage;     
                    case 'LAFM Reference'
                        app.ref.LAFM = app.ref.orgImage;
                    case 'Averaged Reference'
                        app.ref.av = app.ref.orgImage;
                end
            else
                app.ref.image = app.ref.orgImage;
            end
            updatePlot2_type(app, 'image')
            updateRightPlot(app);
        end

        % Selection changed function: ReferenceButtonGroup
        function ReferenceButtonGroupSelectionChanged(app, event)
            updatePlot2_type(app, 'image')
            updateRightPlot(app);  
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create NanoLocz1_00Pre and hide until all components are created
            app.NanoLocz1_00Pre = uifigure('Visible', 'off');
            app.NanoLocz1_00Pre.Color = [1 1 1];
            app.NanoLocz1_00Pre.Position = [100 100 1348 702];
            app.NanoLocz1_00Pre.Name = 'NanoLocz 1.00 PreRelease';
            app.NanoLocz1_00Pre.Icon = fullfile(pathToMLAPP, 'icons', 'NLocz_Logo_b.png');
            app.NanoLocz1_00Pre.WindowButtonDownFcn = createCallbackFcn(app, @NanoLocz1_00PreWindowButtonDown, true);
            app.NanoLocz1_00Pre.KeyPressFcn = createCallbackFcn(app, @NanoLocz1_00PreKeyPress, true);
            app.NanoLocz1_00Pre.HandleVisibility = 'on';

            % Create FileMenu
            app.FileMenu = uimenu(app.NanoLocz1_00Pre);
            app.FileMenu.Text = 'File';

            % Create OpenMenu
            app.OpenMenu = uimenu(app.FileMenu);
            app.OpenMenu.Text = 'Open';

            % Create FolderMenu
            app.FolderMenu = uimenu(app.OpenMenu);
            app.FolderMenu.MenuSelectedFcn = createCallbackFcn(app, @OpenFolderButtonClicked, true);
            app.FolderMenu.Text = 'Folder';

            % Create OpenSessionMenu
            app.OpenSessionMenu = uimenu(app.OpenMenu);
            app.OpenSessionMenu.MenuSelectedFcn = createCallbackFcn(app, @OpenSessionMenuSelected, true);
            app.OpenSessionMenu.Text = 'Session';

            % Create SaveMenu
            app.SaveMenu = uimenu(app.FileMenu);
            app.SaveMenu.MenuSelectedFcn = createCallbackFcn(app, @SaveSessionImageClicked, true);
            app.SaveMenu.Text = 'Save';

            % Create QuitMenu
            app.QuitMenu = uimenu(app.FileMenu);
            app.QuitMenu.Text = 'Quit';

            % Create ImageMenu
            app.ImageMenu = uimenu(app.NanoLocz1_00Pre);
            app.ImageMenu.Text = 'Image';

            % Create CropMenu
            app.CropMenu = uimenu(app.ImageMenu);
            app.CropMenu.MenuSelectedFcn = createCallbackFcn(app, @CropButtonPushed, true);
            app.CropMenu.Accelerator = 'x';
            app.CropMenu.Text = 'Crop';

            % Create HelpMenu
            app.HelpMenu = uimenu(app.NanoLocz1_00Pre);
            app.HelpMenu.Text = 'Help';

            % Create ComingSoonMenu
            app.ComingSoonMenu = uimenu(app.HelpMenu);
            app.ComingSoonMenu.Text = 'Coming Soon...';

            % Create SimulationsMenu
            app.SimulationsMenu = uimenu(app.NanoLocz1_00Pre);
            app.SimulationsMenu.Text = 'Simulations';

            % Create OpenMat_SimAFMMenu
            app.OpenMat_SimAFMMenu = uimenu(app.SimulationsMenu);
            app.OpenMat_SimAFMMenu.MenuSelectedFcn = createCallbackFcn(app, @OpenMat_SimAFMMenuSelected, true);
            app.OpenMat_SimAFMMenu.Text = 'Open Mat_SimAFM';

            % Create loadbar
            app.loadbar = uiaxes(app.NanoLocz1_00Pre);
            title(app.loadbar, 'Title')
            xlabel(app.loadbar, 'X')
            ylabel(app.loadbar, 'Y')
            zlabel(app.loadbar, 'Z')
            app.loadbar.Position = [183 655 194 53];

            % Create CancelButton
            app.CancelButton = uibutton(app.NanoLocz1_00Pre, 'push');
            app.CancelButton.ButtonPushedFcn = createCallbackFcn(app, @CancelButtonPushed, true);
            app.CancelButton.BackgroundColor = [1 0 0];
            app.CancelButton.FontWeight = 'bold';
            app.CancelButton.FontColor = [1 1 1];
            app.CancelButton.Visible = 'off';
            app.CancelButton.Position = [328 653 50 22];
            app.CancelButton.Text = 'Cancel';

            % Create Toolbar
            app.Toolbar = uipanel(app.NanoLocz1_00Pre);
            app.Toolbar.Position = [380 660 970 43];

            % Create ClearButton
            app.ClearButton = uibutton(app.Toolbar, 'push');
            app.ClearButton.ButtonPushedFcn = createCallbackFcn(app, @ClearButtonPushed, true);
            app.ClearButton.BackgroundColor = [1 1 1];
            app.ClearButton.FontWeight = 'bold';
            app.ClearButton.Position = [202 3 38 38];
            app.ClearButton.Text = 'Clear';

            % Create Circ_roi_Button
            app.Circ_roi_Button = uibutton(app.Toolbar, 'state');
            app.Circ_roi_Button.ValueChangedFcn = createCallbackFcn(app, @Circ_roi_ButtonValueChanged, true);
            app.Circ_roi_Button.Tooltip = {'Hieght profile over time'};
            app.Circ_roi_Button.Icon = fullfile(pathToMLAPP, 'icons', 'ZProfile.png');
            app.Circ_roi_Button.IconAlignment = 'top';
            app.Circ_roi_Button.Text = '';
            app.Circ_roi_Button.BackgroundColor = [1 1 1];
            app.Circ_roi_Button.Position = [82 3 38 38];

            % Create Sq_roi_Button
            app.Sq_roi_Button = uibutton(app.Toolbar, 'state');
            app.Sq_roi_Button.ValueChangedFcn = createCallbackFcn(app, @Sq_roi_ButtonValueChanged, true);
            app.Sq_roi_Button.Tooltip = {'Draw reference area'};
            app.Sq_roi_Button.Icon = fullfile(pathToMLAPP, 'icons', 'roi_sq.png');
            app.Sq_roi_Button.IconAlignment = 'top';
            app.Sq_roi_Button.Text = '';
            app.Sq_roi_Button.BackgroundColor = [1 1 1];
            app.Sq_roi_Button.Position = [42 3 38 38];

            % Create Line_roi_Button
            app.Line_roi_Button = uibutton(app.Toolbar, 'state');
            app.Line_roi_Button.ValueChangedFcn = createCallbackFcn(app, @Line_roi_ButtonValueChanged, true);
            app.Line_roi_Button.Tooltip = {'Line Profile'};
            app.Line_roi_Button.Icon = fullfile(pathToMLAPP, 'icons', 'line.png');
            app.Line_roi_Button.IconAlignment = 'top';
            app.Line_roi_Button.Text = '';
            app.Line_roi_Button.BackgroundColor = [1 1 1];
            app.Line_roi_Button.Position = [122 3 38 38];

            % Create Point_roi_Button
            app.Point_roi_Button = uibutton(app.Toolbar, 'state');
            app.Point_roi_Button.ValueChangedFcn = createCallbackFcn(app, @Point_roi_ButtonValueChanged, true);
            app.Point_roi_Button.Tooltip = {'Data tips'};
            app.Point_roi_Button.Icon = fullfile(pathToMLAPP, 'icons', 'multi_point.png');
            app.Point_roi_Button.IconAlignment = 'top';
            app.Point_roi_Button.Text = '';
            app.Point_roi_Button.BackgroundColor = [1 1 1];
            app.Point_roi_Button.Position = [2 3 38 38];

            % Create CropButton
            app.CropButton = uibutton(app.Toolbar, 'push');
            app.CropButton.ButtonPushedFcn = createCallbackFcn(app, @CropButtonPushed, true);
            app.CropButton.Icon = fullfile(pathToMLAPP, 'icons', 'crop.png');
            app.CropButton.Tooltip = {'Crop'};
            app.CropButton.Position = [242 3 38 38];
            app.CropButton.Text = '';

            % Create ZoomIn
            app.ZoomIn = uibutton(app.Toolbar, 'state');
            app.ZoomIn.ValueChangedFcn = createCallbackFcn(app, @ZoomInValueChanged, true);
            app.ZoomIn.Tooltip = {'Zoom'};
            app.ZoomIn.Icon = fullfile(pathToMLAPP, 'icons', 'zoomin.png');
            app.ZoomIn.IconAlignment = 'top';
            app.ZoomIn.Text = '';
            app.ZoomIn.BackgroundColor = [1 1 1];
            app.ZoomIn.Position = [162 3 38 38];

            % Create HistPlot
            app.HistPlot = uibutton(app.Toolbar, 'state');
            app.HistPlot.ValueChangedFcn = createCallbackFcn(app, @HistPlotValueChanged, true);
            app.HistPlot.Tooltip = {'Histogram'};
            app.HistPlot.Icon = fullfile(pathToMLAPP, 'icons', 'hist.png');
            app.HistPlot.IconAlignment = 'top';
            app.HistPlot.Text = '';
            app.HistPlot.BackgroundColor = [1 1 1];
            app.HistPlot.Position = [282 3 38 38];

            % Create AverageRefButton
            app.AverageRefButton = uibutton(app.Toolbar, 'push');
            app.AverageRefButton.ButtonPushedFcn = createCallbackFcn(app, @AverageRefButtonPushed, true);
            app.AverageRefButton.VerticalAlignment = 'bottom';
            app.AverageRefButton.Position = [403 22 86 19];
            app.AverageRefButton.Text = 'Average Ref';

            % Create RotationalAvgButton
            app.RotationalAvgButton = uibutton(app.Toolbar, 'push');
            app.RotationalAvgButton.ButtonPushedFcn = createCallbackFcn(app, @RotationalAvgButtonPushed, true);
            app.RotationalAvgButton.VerticalAlignment = 'bottom';
            app.RotationalAvgButton.Position = [403 2 86 20];
            app.RotationalAvgButton.Text = 'Rotational Avg';

            % Create kymo
            app.kymo = uibutton(app.Toolbar, 'push');
            app.kymo.ButtonPushedFcn = createCallbackFcn(app, @kymoButtonPushed, true);
            app.kymo.Icon = fullfile(pathToMLAPP, 'icons', 'kymo.png');
            app.kymo.Tooltip = {'Kymograph from line profile'};
            app.kymo.Position = [323 3 38 38];
            app.kymo.Text = '';

            % Create Button
            app.Button = uibutton(app.Toolbar, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Icon = fullfile(pathToMLAPP, 'icons', 'montage.png');
            app.Button.Tooltip = {'Image montage'};
            app.Button.Position = [363 3 38 38];
            app.Button.Text = '';

            % Create FilesListBox
            app.FilesListBox = uilistbox(app.NanoLocz1_00Pre);
            app.FilesListBox.Items = {};
            app.FilesListBox.ValueChangedFcn = createCallbackFcn(app, @FilesListBoxValueChanged, true);
            app.FilesListBox.FontSize = 11;
            app.FilesListBox.Position = [14 450 167 183];
            app.FilesListBox.Value = {};

            % Create UITable
            app.UITable = uitable(app.NanoLocz1_00Pre);
            app.UITable.ColumnName = {'Parameter'; 'Value'};
            app.UITable.RowName = {};
            app.UITable.FontSize = 11;
            app.UITable.Position = [190 453 181 180];

            % Create FolderUp
            app.FolderUp = uiimage(app.NanoLocz1_00Pre);
            app.FolderUp.ImageClickedFcn = createCallbackFcn(app, @FolderUpImageClicked, true);
            app.FolderUp.Tooltip = {'Move one folder above current directory'};
            app.FolderUp.Position = [2 669 22 23];
            app.FolderUp.ImageSource = fullfile(pathToMLAPP, 'icons', 'up.png');

            % Create FolderDown
            app.FolderDown = uiimage(app.NanoLocz1_00Pre);
            app.FolderDown.ImageClickedFcn = createCallbackFcn(app, @FolderDownImageClicked, true);
            app.FolderDown.Tooltip = {'Open folder in file list'};
            app.FolderDown.Position = [61 667 21 23];
            app.FolderDown.ImageSource = fullfile(pathToMLAPP, 'icons', 'down.png');

            % Create ChannelDropDown
            app.ChannelDropDown = uidropdown(app.NanoLocz1_00Pre);
            app.ChannelDropDown.Items = {'Height'};
            app.ChannelDropDown.Visible = 'off';
            app.ChannelDropDown.Position = [97 635 83 22];
            app.ChannelDropDown.Value = 'Height';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.NanoLocz1_00Pre);
            app.TabGroup.Position = [9 1 362 387];

            % Create LevelTab
            app.LevelTab = uitab(app.TabGroup);
            app.LevelTab.Title = 'Level';
            app.LevelTab.BackgroundColor = [1 1 1];
            app.LevelTab.ButtonDownFcn = createCallbackFcn(app, @LevelTabButtonDown, true);

            % Create FilteringPanel
            app.FilteringPanel = uipanel(app.LevelTab);
            app.FilteringPanel.Title = 'Filtering';
            app.FilteringPanel.FontWeight = 'bold';
            app.FilteringPanel.Position = [4 70 124 73];

            % Create GaussianEditFieldLabel
            app.GaussianEditFieldLabel = uilabel(app.FilteringPanel);
            app.GaussianEditFieldLabel.HorizontalAlignment = 'right';
            app.GaussianEditFieldLabel.Position = [4 28 56 22];
            app.GaussianEditFieldLabel.Text = 'Gaussian';

            % Create GaussianEditField
            app.GaussianEditField = uieditfield(app.FilteringPanel, 'numeric');
            app.GaussianEditField.Limits = [0 Inf];
            app.GaussianEditField.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.GaussianEditField.Position = [64 28 40 22];

            % Create HighpassEditFieldLabel
            app.HighpassEditFieldLabel = uilabel(app.FilteringPanel);
            app.HighpassEditFieldLabel.HorizontalAlignment = 'right';
            app.HighpassEditFieldLabel.Position = [6 4 55 22];
            app.HighpassEditFieldLabel.Text = 'Highpass';

            % Create HighpassEditField
            app.HighpassEditField = uieditfield(app.FilteringPanel, 'numeric');
            app.HighpassEditField.Limits = [0 Inf];
            app.HighpassEditField.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.HighpassEditField.Position = [64 4 40 22];

            % Create ManualFlattenPanel
            app.ManualFlattenPanel = uipanel(app.LevelTab);
            app.ManualFlattenPanel.Title = 'Manual Flatten';
            app.ManualFlattenPanel.FontWeight = 'bold';
            app.ManualFlattenPanel.FontSize = 13;
            app.ManualFlattenPanel.Position = [4 176 124 117];

            % Create PlaneLabel
            app.PlaneLabel = uilabel(app.ManualFlattenPanel);
            app.PlaneLabel.BackgroundColor = [0.149 0.149 0.149];
            app.PlaneLabel.HorizontalAlignment = 'center';
            app.PlaneLabel.VerticalAlignment = 'top';
            app.PlaneLabel.FontWeight = 'bold';
            app.PlaneLabel.FontAngle = 'italic';
            app.PlaneLabel.FontColor = [1 0.4118 0.1608];
            app.PlaneLabel.Position = [18 11 48 80];
            app.PlaneLabel.Text = 'Plane';

            % Create LineLabel
            app.LineLabel = uilabel(app.ManualFlattenPanel);
            app.LineLabel.BackgroundColor = [0.8 0.8 0.8];
            app.LineLabel.HorizontalAlignment = 'center';
            app.LineLabel.VerticalAlignment = 'top';
            app.LineLabel.FontWeight = 'bold';
            app.LineLabel.FontAngle = 'italic';
            app.LineLabel.FontColor = [1 0 0];
            app.LineLabel.Position = [66 11 52 80];
            app.LineLabel.Text = 'Line';

            % Create XLineSpinner
            app.XLineSpinner = uispinner(app.ManualFlattenPanel);
            app.XLineSpinner.Limits = [0 Inf];
            app.XLineSpinner.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.XLineSpinner.FontWeight = 'bold';
            app.XLineSpinner.FontColor = [1 0 0];
            app.XLineSpinner.Position = [71 53 43 22];

            % Create YLineSpinner
            app.YLineSpinner = uispinner(app.ManualFlattenPanel);
            app.YLineSpinner.Limits = [0 Inf];
            app.YLineSpinner.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.YLineSpinner.FontWeight = 'bold';
            app.YLineSpinner.FontColor = [1 0 0];
            app.YLineSpinner.Position = [71 29 43 22];

            % Create XSpinnerLabel
            app.XSpinnerLabel = uilabel(app.ManualFlattenPanel);
            app.XSpinnerLabel.BackgroundColor = [0.8 0.8 0.8];
            app.XSpinnerLabel.FontSize = 14;
            app.XSpinnerLabel.FontWeight = 'bold';
            app.XSpinnerLabel.Position = [3 53 15 22];
            app.XSpinnerLabel.Text = 'X';

            % Create XPlaneSpinner
            app.XPlaneSpinner = uispinner(app.ManualFlattenPanel);
            app.XPlaneSpinner.Limits = [0 Inf];
            app.XPlaneSpinner.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.XPlaneSpinner.FontWeight = 'bold';
            app.XPlaneSpinner.FontColor = [1 0.4118 0.1608];
            app.XPlaneSpinner.BackgroundColor = [0 0 0];
            app.XPlaneSpinner.Position = [22 53 43 22];

            % Create YSpinnerLabel
            app.YSpinnerLabel = uilabel(app.ManualFlattenPanel);
            app.YSpinnerLabel.BackgroundColor = [0.8 0.8 0.8];
            app.YSpinnerLabel.FontSize = 14;
            app.YSpinnerLabel.FontWeight = 'bold';
            app.YSpinnerLabel.Position = [3 29 15 22];
            app.YSpinnerLabel.Text = 'Y';

            % Create YPlaneSpinner
            app.YPlaneSpinner = uispinner(app.ManualFlattenPanel);
            app.YPlaneSpinner.Limits = [0 Inf];
            app.YPlaneSpinner.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.YPlaneSpinner.FontWeight = 'bold';
            app.YPlaneSpinner.FontColor = [1 0.4118 0.1608];
            app.YPlaneSpinner.BackgroundColor = [0 0 0];
            app.YPlaneSpinner.Position = [22 29 43 22];

            % Create MedianCheckBox
            app.MedianCheckBox = uicheckbox(app.ManualFlattenPanel);
            app.MedianCheckBox.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.MedianCheckBox.Text = '';
            app.MedianCheckBox.Position = [103 8 15 22];

            % Create MeanLabel
            app.MeanLabel = uilabel(app.ManualFlattenPanel);
            app.MeanLabel.FontSize = 11;
            app.MeanLabel.FontWeight = 'bold';
            app.MeanLabel.FontColor = [1 0 0];
            app.MeanLabel.Position = [70 8 37 22];
            app.MeanLabel.Text = '-Mean';

            % Create MeanPlaneCheckBox
            app.MeanPlaneCheckBox = uicheckbox(app.ManualFlattenPanel);
            app.MeanPlaneCheckBox.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.MeanPlaneCheckBox.Text = '';
            app.MeanPlaneCheckBox.Position = [51 8 15 22];

            % Create MeanLabel_2
            app.MeanLabel_2 = uilabel(app.ManualFlattenPanel);
            app.MeanLabel_2.FontSize = 11;
            app.MeanLabel_2.FontWeight = 'bold';
            app.MeanLabel_2.FontColor = [1 0.4118 0.1608];
            app.MeanLabel_2.Position = [18 8 37 22];
            app.MeanLabel_2.Text = '-Mean';

            % Create Panel
            app.Panel = uipanel(app.LevelTab);
            app.Panel.FontWeight = 'bold';
            app.Panel.FontSize = 13;
            app.Panel.Position = [136 41 226 303];

            % Create Hist_Axes
            app.Hist_Axes = uiaxes(app.Panel);
            zlabel(app.Hist_Axes, 'Z')
            app.Hist_Axes.XMinorTick = 'on';
            app.Hist_Axes.YTick = [];
            app.Hist_Axes.TickDir = 'out';
            colormap(app.Hist_Axes, 'hot')
            app.Hist_Axes.Position = [2 62 171 166];

            % Create lowerlimitLabel
            app.lowerlimitLabel = uilabel(app.Panel);
            app.lowerlimitLabel.FontAngle = 'italic';
            app.lowerlimitLabel.FontColor = [1 0 0];
            app.lowerlimitLabel.Position = [14 5 60 22];
            app.lowerlimitLabel.Text = 'lower limit';

            % Create upperlimitLabel
            app.upperlimitLabel = uilabel(app.Panel);
            app.upperlimitLabel.FontAngle = 'italic';
            app.upperlimitLabel.FontColor = [1 0 0];
            app.upperlimitLabel.Position = [109 40 62 22];
            app.upperlimitLabel.Text = 'upper limit';

            % Create ThresholdMethod
            app.ThresholdMethod = uidropdown(app.Panel);
            app.ThresholdMethod.Items = {'histogram', 'otsu', '2 level otsu', 'step detection', 'adaptive'};
            app.ThresholdMethod.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.ThresholdMethod.Position = [136 256 85 22];
            app.ThresholdMethod.Value = 'histogram';

            % Create PreviewThresholdCheck
            app.PreviewThresholdCheck = uicheckbox(app.Panel);
            app.PreviewThresholdCheck.ValueChangedFcn = createCallbackFcn(app, @PreviewThresholdCheckValueChanged, true);
            app.PreviewThresholdCheck.Text = '';
            app.PreviewThresholdCheck.Position = [92 256 25 22];
            app.PreviewThresholdCheck.Value = true;

            % Create PreviewThresholdLabel
            app.PreviewThresholdLabel = uilabel(app.Panel);
            app.PreviewThresholdLabel.FontWeight = 'bold';
            app.PreviewThresholdLabel.FontAngle = 'italic';
            app.PreviewThresholdLabel.Position = [5 256 90 22];
            app.PreviewThresholdLabel.Text = 'View threshold';

            % Create LogYHist
            app.LogYHist = uicheckbox(app.Panel);
            app.LogYHist.ValueChangedFcn = createCallbackFcn(app, @LogYHistValueChanged, true);
            app.LogYHist.Text = '';
            app.LogYHist.Position = [93 221 17 22];

            % Create LogYLabel
            app.LogYLabel = uilabel(app.Panel);
            app.LogYLabel.FontWeight = 'bold';
            app.LogYLabel.FontAngle = 'italic';
            app.LogYLabel.Position = [56 221 38 22];
            app.LogYLabel.Text = 'Log Y';

            % Create SliderMin
            app.SliderMin = uislider(app.Panel);
            app.SliderMin.MajorTicks = [];
            app.SliderMin.MajorTickLabels = {''};
            app.SliderMin.ValueChangingFcn = createCallbackFcn(app, @SliderMinValueChanging, true);
            app.SliderMin.MinorTicks = [];
            app.SliderMin.FontSize = 8;
            app.SliderMin.Position = [10 22 159 3];

            % Create SliderMax
            app.SliderMax = uislider(app.Panel);
            app.SliderMax.MajorTicks = [];
            app.SliderMax.MajorTickLabels = {''};
            app.SliderMax.ValueChangingFcn = createCallbackFcn(app, @SliderMaxValueChanging, true);
            app.SliderMax.MinorTicks = [];
            app.SliderMax.Tag = 'slidermax';
            app.SliderMax.FontSize = 8;
            app.SliderMax.Position = [10 39 159 3];
            app.SliderMax.Value = 100;

            % Create ThresholdContrastSwitch
            app.ThresholdContrastSwitch = uiswitch(app.Panel, 'slider');
            app.ThresholdContrastSwitch.Items = {'Contrast', 'Threshold'};
            app.ThresholdContrastSwitch.FontSize = 14;
            app.ThresholdContrastSwitch.FontWeight = 'bold';
            app.ThresholdContrastSwitch.Position = [80 281 35 16];
            app.ThresholdContrastSwitch.Value = 'Threshold';

            % Create InvertSelected
            app.InvertSelected = uicheckbox(app.Panel);
            app.InvertSelected.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.InvertSelected.Text = '';
            app.InvertSelected.Position = [93 239 17 22];

            % Create InvertselectedLabel
            app.InvertselectedLabel = uilabel(app.Panel);
            app.InvertselectedLabel.FontWeight = 'bold';
            app.InvertselectedLabel.FontAngle = 'italic';
            app.InvertselectedLabel.Position = [5 239 89 22];
            app.InvertselectedLabel.Text = 'Invert selected';

            % Create ROIThresholdButton
            app.ROIThresholdButton = uibutton(app.Panel, 'state');
            app.ROIThresholdButton.ValueChangedFcn = createCallbackFcn(app, @ROIThresholdButtonValueChanged, true);
            app.ROIThresholdButton.Tooltip = {'Draw ROIs to exclude'};
            app.ROIThresholdButton.Icon = fullfile(pathToMLAPP, 'icons', 'scribble.png');
            app.ROIThresholdButton.IconAlignment = 'top';
            app.ROIThresholdButton.Text = '';
            app.ROIThresholdButton.BackgroundColor = [1 1 1];
            app.ROIThresholdButton.Position = [182 212 40 40];

            % Create ClearROIButton
            app.ClearROIButton = uibutton(app.Panel, 'push');
            app.ClearROIButton.ButtonPushedFcn = createCallbackFcn(app, @ClearROIButtonPushed, true);
            app.ClearROIButton.BackgroundColor = [1 1 1];
            app.ClearROIButton.FontWeight = 'bold';
            app.ClearROIButton.Position = [182 185 40 25];
            app.ClearROIButton.Text = 'Clear';

            % Create FitButton
            app.FitButton = uibutton(app.Panel, 'push');
            app.FitButton.ButtonPushedFcn = createCallbackFcn(app, @FitButtonPushed, true);
            app.FitButton.Position = [175 7 47 23];
            app.FitButton.Text = 'Fit';

            % Create Hist_excludeOut
            app.Hist_excludeOut = uibutton(app.Panel, 'state');
            app.Hist_excludeOut.ValueChangedFcn = createCallbackFcn(app, @Hist_excludeOutValueChanged, true);
            app.Hist_excludeOut.VerticalAlignment = 'top';
            app.Hist_excludeOut.Text = {'Exclude '; 'Outliers'};
            app.Hist_excludeOut.FontSize = 10;
            app.Hist_excludeOut.Position = [175 32 47 29];

            % Create ZeroallButton
            app.ZeroallButton = uibutton(app.LevelTab, 'push');
            app.ZeroallButton.ButtonPushedFcn = createCallbackFcn(app, @ZeroallButtonPushed, true);
            app.ZeroallButton.Position = [6 35 55 22];
            app.ZeroallButton.Text = 'Zero all';

            % Create RestoreButton
            app.RestoreButton = uibutton(app.LevelTab, 'push');
            app.RestoreButton.ButtonPushedFcn = createCallbackFcn(app, @Reload, true);
            app.RestoreButton.Position = [67 35 61 22];
            app.RestoreButton.Text = 'Restore';

            % Create AutoFlattenPanel
            app.AutoFlattenPanel = uipanel(app.LevelTab);
            app.AutoFlattenPanel.Title = 'Auto Flatten';
            app.AutoFlattenPanel.FontWeight = 'bold';
            app.AutoFlattenPanel.FontSize = 13;
            app.AutoFlattenPanel.Position = [4 310 124 49];

            % Create AutoflattenDropDown
            app.AutoflattenDropDown = uidropdown(app.AutoFlattenPanel);
            app.AutoflattenDropDown.Items = {'Off', 'Simple', 'Simple + fit', 'Plane + Otsu Plane', 'Line + Otsu Line'};
            app.AutoflattenDropDown.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.AutoflattenDropDown.Position = [6 4 112 21];
            app.AutoflattenDropDown.Value = 'Off';

            % Create FixLineShift
            app.FixLineShift = uicheckbox(app.LevelTab);
            app.FixLineShift.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.FixLineShift.Text = 'Fix bi-directional line shift';
            app.FixLineShift.Position = [8 9 157 22];

            % Create FixShiftMethod
            app.FixShiftMethod = uidropdown(app.LevelTab);
            app.FixShiftMethod.Items = {'Line peaks', 'Line correlation', 'Manual Shift'};
            app.FixShiftMethod.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.FixShiftMethod.Position = [166 11 93 22];
            app.FixShiftMethod.Value = 'Line peaks';

            % Create FixShiftValue
            app.FixShiftValue = uieditfield(app.LevelTab, 'numeric');
            app.FixShiftValue.ValueChangedFcn = createCallbackFcn(app, @Refresh_Filter, true);
            app.FixShiftValue.Position = [255 11 37 22];

            % Create AlignTab
            app.AlignTab = uitab(app.TabGroup);
            app.AlignTab.Title = 'Align';
            app.AlignTab.BackgroundColor = [1 1 1];
            app.AlignTab.ButtonDownFcn = createCallbackFcn(app, @AlignTabButtonDown, true);

            % Create RunAlignButton
            app.RunAlignButton = uibutton(app.AlignTab, 'push');
            app.RunAlignButton.ButtonPushedFcn = createCallbackFcn(app, @RunAlignButtonPushed, true);
            app.RunAlignButton.FontSize = 14;
            app.RunAlignButton.FontWeight = 'bold';
            app.RunAlignButton.Position = [130 322 97 26];
            app.RunAlignButton.Text = 'Run Align';

            % Create FilterCCREditFieldLabel
            app.FilterCCREditFieldLabel = uilabel(app.AlignTab);
            app.FilterCCREditFieldLabel.HorizontalAlignment = 'right';
            app.FilterCCREditFieldLabel.Position = [37 214 61 22];
            app.FilterCCREditFieldLabel.Text = 'Filter CCR';

            % Create FilterCCREditField
            app.FilterCCREditField = uieditfield(app.AlignTab, 'numeric');
            app.FilterCCREditField.Limits = [0 Inf];
            app.FilterCCREditField.Position = [104 214 45 22];
            app.FilterCCREditField.Value = 1;

            % Create SubPixCheckBox
            app.SubPixCheckBox = uicheckbox(app.AlignTab);
            app.SubPixCheckBox.Text = '';
            app.SubPixCheckBox.Position = [121 150 23 22];

            % Create FilterImgEditFieldLabel
            app.FilterImgEditFieldLabel = uilabel(app.AlignTab);
            app.FilterImgEditFieldLabel.HorizontalAlignment = 'right';
            app.FilterImgEditFieldLabel.Position = [42 193 56 22];
            app.FilterImgEditFieldLabel.Text = 'Filter Img';

            % Create FilterImgEditField
            app.FilterImgEditField = uieditfield(app.AlignTab, 'numeric');
            app.FilterImgEditField.Limits = [0 Inf];
            app.FilterImgEditField.Position = [104 193 45 22];
            app.FilterImgEditField.Value = 1;

            % Create MaxdriftEditFieldLabel
            app.MaxdriftEditFieldLabel = uilabel(app.AlignTab);
            app.MaxdriftEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxdriftEditFieldLabel.Position = [45 172 53 22];
            app.MaxdriftEditFieldLabel.Text = 'Max drift';

            % Create MaxdriftEditField
            app.MaxdriftEditField = uieditfield(app.AlignTab, 'numeric');
            app.MaxdriftEditField.Limits = [0 Inf];
            app.MaxdriftEditField.Position = [104 172 45 22];
            app.MaxdriftEditField.Value = 10;

            % Create ViewSwitchLabel
            app.ViewSwitchLabel = uilabel(app.AlignTab);
            app.ViewSwitchLabel.HorizontalAlignment = 'center';
            app.ViewSwitchLabel.Position = [234 214 31 22];
            app.ViewSwitchLabel.Text = 'View';

            % Create ViewSwitch
            app.ViewSwitch = uiswitch(app.AlignTab, 'slider');
            app.ViewSwitch.Items = {'Crop', 'Expand'};
            app.ViewSwitch.Position = [228 198 45 20];
            app.ViewSwitch.Value = 'Expand';

            % Create SubPixelLabel
            app.SubPixelLabel = uilabel(app.AlignTab);
            app.SubPixelLabel.Position = [39 150 64 22];
            app.SubPixelLabel.Text = 'Sub-Pixel?';

            % Create SettingsLabel
            app.SettingsLabel = uilabel(app.AlignTab);
            app.SettingsLabel.HorizontalAlignment = 'center';
            app.SettingsLabel.FontSize = 14;
            app.SettingsLabel.FontWeight = 'bold';
            app.SettingsLabel.FontAngle = 'italic';
            app.SettingsLabel.Position = [56 236 78 22];
            app.SettingsLabel.Text = 'Settings';

            % Create UpdateRefwithAverageButton
            app.UpdateRefwithAverageButton = uibutton(app.AlignTab, 'push');
            app.UpdateRefwithAverageButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateRefwithAverageButtonPushed, true);
            app.UpdateRefwithAverageButton.FontSize = 14;
            app.UpdateRefwithAverageButton.FontWeight = 'bold';
            app.UpdateRefwithAverageButton.Position = [91 289 175 25];
            app.UpdateRefwithAverageButton.Text = 'Update Ref with Average';

            % Create UseAvgrefCheckBox
            app.UseAvgrefCheckBox = uicheckbox(app.AlignTab);
            app.UseAvgrefCheckBox.Text = 'Use Avg ref';
            app.UseAvgrefCheckBox.Position = [40 324 84 22];

            % Create Sq_roi_Button_3
            app.Sq_roi_Button_3 = uibutton(app.AlignTab, 'state');
            app.Sq_roi_Button_3.Icon = fullfile(pathToMLAPP, 'icons', 'roi_sq.png');
            app.Sq_roi_Button_3.IconAlignment = 'top';
            app.Sq_roi_Button_3.Text = '';
            app.Sq_roi_Button_3.BackgroundColor = [1 1 1];
            app.Sq_roi_Button_3.Position = [315 318 40 40];

            % Create DetectTab
            app.DetectTab = uitab(app.TabGroup);
            app.DetectTab.Title = 'Detect';
            app.DetectTab.BackgroundColor = [1 1 1];
            app.DetectTab.ButtonDownFcn = createCallbackFcn(app, @DetectTabButtonDown, true);

            % Create Filter_detections_panel
            app.Filter_detections_panel = uipanel(app.DetectTab);
            app.Filter_detections_panel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.Filter_detections_panel.Position = [1 5 226 201];

            % Create HeightCCRHist
            app.HeightCCRHist = uiaxes(app.Filter_detections_panel);
            zlabel(app.HeightCCRHist, 'Z')
            app.HeightCCRHist.XMinorTick = 'on';
            app.HeightCCRHist.YTick = [];
            app.HeightCCRHist.TickDir = 'out';
            colormap(app.HeightCCRHist, 'hot')
            app.HeightCCRHist.Position = [1 45 138 134];

            % Create Max_h_Edit
            app.Max_h_Edit = uieditfield(app.Filter_detections_panel, 'numeric');
            app.Max_h_Edit.Position = [145 85 41 22];
            app.Max_h_Edit.Value = 100;

            % Create Min_h_Edit
            app.Min_h_Edit = uieditfield(app.Filter_detections_panel, 'numeric');
            app.Min_h_Edit.ValueChangedFcn = createCallbackFcn(app, @Min_h_EditValueChanged, true);
            app.Min_h_Edit.Position = [145 64 41 22];
            app.Min_h_Edit.Value = 2;

            % Create MaxLabel
            app.MaxLabel = uilabel(app.Filter_detections_panel);
            app.MaxLabel.FontAngle = 'italic';
            app.MaxLabel.Position = [189 85 28 22];
            app.MaxLabel.Text = 'Max';

            % Create MinLabel
            app.MinLabel = uilabel(app.Filter_detections_panel);
            app.MinLabel.FontAngle = 'italic';
            app.MinLabel.Position = [188 64 25 22];
            app.MinLabel.Text = 'Min';

            % Create MinLabel_2
            app.MinLabel_2 = uilabel(app.Filter_detections_panel);
            app.MinLabel_2.FontAngle = 'italic';
            app.MinLabel_2.Position = [190 134 25 22];
            app.MinLabel_2.Text = 'Min';

            % Create MaxLabel_2
            app.MaxLabel_2 = uilabel(app.Filter_detections_panel);
            app.MaxLabel_2.FontAngle = 'italic';
            app.MaxLabel_2.Position = [190 155 28 22];
            app.MaxLabel_2.Text = 'Max';

            % Create Max_CCR_Edit
            app.Max_CCR_Edit = uieditfield(app.Filter_detections_panel, 'numeric');
            app.Max_CCR_Edit.Limits = [0 1];
            app.Max_CCR_Edit.Position = [145 155 41 22];
            app.Max_CCR_Edit.Value = 1;

            % Create Min_CCR_Edit
            app.Min_CCR_Edit = uieditfield(app.Filter_detections_panel, 'numeric');
            app.Min_CCR_Edit.Limits = [0 1];
            app.Min_CCR_Edit.Position = [145 134 41 22];
            app.Min_CCR_Edit.Value = 0.5;

            % Create HeightCheckBox
            app.HeightCheckBox = uicheckbox(app.Filter_detections_panel);
            app.HeightCheckBox.Text = 'Height';
            app.HeightCheckBox.Position = [145 104 57 22];

            % Create CorrelationCheckBox
            app.CorrelationCheckBox = uicheckbox(app.Filter_detections_panel);
            app.CorrelationCheckBox.Text = 'Correlation';
            app.CorrelationCheckBox.Position = [144 176 81 22];
            app.CorrelationCheckBox.Value = true;

            % Create lowerlimitLabel_2
            app.lowerlimitLabel_2 = uilabel(app.Filter_detections_panel);
            app.lowerlimitLabel_2.FontAngle = 'italic';
            app.lowerlimitLabel_2.FontColor = [1 0 0];
            app.lowerlimitLabel_2.Position = [139 6 60 22];
            app.lowerlimitLabel_2.Text = 'lower limit';

            % Create upperlimitLabel_2
            app.upperlimitLabel_2 = uilabel(app.Filter_detections_panel);
            app.upperlimitLabel_2.FontAngle = 'italic';
            app.upperlimitLabel_2.FontColor = [1 0 0];
            app.upperlimitLabel_2.Position = [141 26 62 22];
            app.upperlimitLabel_2.Text = 'upper limit';

            % Create CCRSliderMin
            app.CCRSliderMin = uislider(app.Filter_detections_panel);
            app.CCRSliderMin.MajorTicks = [];
            app.CCRSliderMin.MajorTickLabels = {''};
            app.CCRSliderMin.ValueChangingFcn = createCallbackFcn(app, @CCRSliderMinValueChanging, true);
            app.CCRSliderMin.MinorTicks = [];
            app.CCRSliderMin.FontSize = 8;
            app.CCRSliderMin.Position = [9 14 126 3];

            % Create CCRSliderMax
            app.CCRSliderMax = uislider(app.Filter_detections_panel);
            app.CCRSliderMax.MajorTicks = [];
            app.CCRSliderMax.MajorTickLabels = {''};
            app.CCRSliderMax.ValueChangingFcn = createCallbackFcn(app, @CCRSliderMaxValueChanging, true);
            app.CCRSliderMax.MinorTicks = [];
            app.CCRSliderMax.FontSize = 8;
            app.CCRSliderMax.Position = [9 33 126 3];
            app.CCRSliderMax.Value = 100;

            % Create Height_corr_switch
            app.Height_corr_switch = uiswitch(app.Filter_detections_panel, 'slider');
            app.Height_corr_switch.Items = {'Correlation', 'Height'};
            app.Height_corr_switch.ValueChangedFcn = createCallbackFcn(app, @Height_corr_switchValueChanged, true);
            app.Height_corr_switch.Position = [69 181 29 13];
            app.Height_corr_switch.Value = 'Correlation';

            % Create Overlay
            app.Overlay = uipanel(app.DetectTab);
            app.Overlay.BackgroundColor = [0.9412 0.9412 0.9412];
            app.Overlay.Position = [245 114 111 94];

            % Create MarkersCheckBox
            app.MarkersCheckBox = uicheckbox(app.Overlay);
            app.MarkersCheckBox.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.MarkersCheckBox.Text = 'Markers';
            app.MarkersCheckBox.Position = [7 71 66 22];

            % Create BoxesCheckBox
            app.BoxesCheckBox = uicheckbox(app.Overlay);
            app.BoxesCheckBox.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.BoxesCheckBox.Text = 'Boxes';
            app.BoxesCheckBox.Position = [7 55 56 22];
            app.BoxesCheckBox.Value = true;

            % Create TrackLengthEditFieldLabel
            app.TrackLengthEditFieldLabel = uilabel(app.Overlay);
            app.TrackLengthEditFieldLabel.HorizontalAlignment = 'right';
            app.TrackLengthEditFieldLabel.Position = [27 6 75 22];
            app.TrackLengthEditFieldLabel.Text = 'Track Length';

            % Create TrackLengthEditField
            app.TrackLengthEditField = uieditfield(app.Overlay, 'numeric');
            app.TrackLengthEditField.Position = [4 6 23 22];

            % Create OverlayValues
            app.OverlayValues = uidropdown(app.Overlay);
            app.OverlayValues.Items = {'None', 'Height', 'CCR', 'Angle', 'Track Number'};
            app.OverlayValues.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.OverlayValues.Position = [43 33 64 22];
            app.OverlayValues.Value = 'None';

            % Create ValuesLabel
            app.ValuesLabel = uilabel(app.Overlay);
            app.ValuesLabel.Position = [2 32 44 22];
            app.ValuesLabel.Text = 'Values:';

            % Create TrackDetectionsPanel
            app.TrackDetectionsPanel = uipanel(app.DetectTab);
            app.TrackDetectionsPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.TrackDetectionsPanel.FontWeight = 'bold';
            app.TrackDetectionsPanel.Position = [244 9 111 72];

            % Create RunTrackingButton
            app.RunTrackingButton = uibutton(app.TrackDetectionsPanel, 'push');
            app.RunTrackingButton.ButtonPushedFcn = createCallbackFcn(app, @RunTrackingButtonPushed, true);
            app.RunTrackingButton.FontWeight = 'bold';
            app.RunTrackingButton.FontColor = [1 0 0];
            app.RunTrackingButton.Position = [3 5 104 21];
            app.RunTrackingButton.Text = 'Run Tracking';

            % Create MaxmissingEditFieldLabel
            app.MaxmissingEditFieldLabel = uilabel(app.TrackDetectionsPanel);
            app.MaxmissingEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxmissingEditFieldLabel.Position = [3 28 75 22];
            app.MaxmissingEditFieldLabel.Text = 'Max missing ';

            % Create MaxmissingEditField
            app.MaxmissingEditField = uieditfield(app.TrackDetectionsPanel, 'numeric');
            app.MaxmissingEditField.Position = [76 27 32 22];
            app.MaxmissingEditField.Value = 3;

            % Create MaxstepEditFieldLabel
            app.MaxstepEditFieldLabel = uilabel(app.TrackDetectionsPanel);
            app.MaxstepEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxstepEditFieldLabel.Position = [25 48 50 22];
            app.MaxstepEditFieldLabel.Text = 'Max step';

            % Create MaxstepEditField
            app.MaxstepEditField = uieditfield(app.TrackDetectionsPanel, 'numeric');
            app.MaxstepEditField.Position = [76 48 32 22];
            app.MaxstepEditField.Value = 10;

            % Create FilterImageLabel
            app.FilterImageLabel = uilabel(app.DetectTab);
            app.FilterImageLabel.HorizontalAlignment = 'right';
            app.FilterImageLabel.Position = [20 287 68 22];
            app.FilterImageLabel.Text = 'Filter image';

            % Create FilterImgEditField_Detect
            app.FilterImgEditField_Detect = uieditfield(app.DetectTab, 'numeric');
            app.FilterImgEditField_Detect.Limits = [0 Inf];
            app.FilterImgEditField_Detect.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.FilterImgEditField_Detect.Position = [90 287 30 22];
            app.FilterImgEditField_Detect.Value = 1;

            % Create FindParticlesButton
            app.FindParticlesButton = uibutton(app.DetectTab, 'push');
            app.FindParticlesButton.ButtonPushedFcn = createCallbackFcn(app, @FindParticlesButtonPushed, true);
            app.FindParticlesButton.FontSize = 14;
            app.FindParticlesButton.FontWeight = 'bold';
            app.FindParticlesButton.FontColor = [1 0 0];
            app.FindParticlesButton.Position = [252 285 107 26];
            app.FindParticlesButton.Text = 'Find Particles';

            % Create SettingsLabel_Detect
            app.SettingsLabel_Detect = uilabel(app.DetectTab);
            app.SettingsLabel_Detect.HorizontalAlignment = 'center';
            app.SettingsLabel_Detect.FontWeight = 'bold';
            app.SettingsLabel_Detect.FontAngle = 'italic';
            app.SettingsLabel_Detect.Position = [261 205 78 22];
            app.SettingsLabel_Detect.Text = 'Overlay Plot';

            % Create SelectMethodLabel_2
            app.SelectMethodLabel_2 = uilabel(app.DetectTab);
            app.SelectMethodLabel_2.FontSize = 14;
            app.SelectMethodLabel_2.FontWeight = 'bold';
            app.SelectMethodLabel_2.FontAngle = 'italic';
            app.SelectMethodLabel_2.Position = [25 336 105 22];
            app.SelectMethodLabel_2.Text = 'Select Method:';

            % Create PeaksRegionsSwitch
            app.PeaksRegionsSwitch = uiswitch(app.DetectTab, 'slider');
            app.PeaksRegionsSwitch.Items = {'Peaks', 'Regions'};
            app.PeaksRegionsSwitch.ValueChangedFcn = createCallbackFcn(app, @PeaksRegionsSwitchValueChanged, true);
            app.PeaksRegionsSwitch.FontSize = 14;
            app.PeaksRegionsSwitch.FontWeight = 'bold';
            app.PeaksRegionsSwitch.Position = [182 337 45 20];
            app.PeaksRegionsSwitch.Value = 'Regions';

            % Create BoxSizeEditFieldLabel
            app.BoxSizeEditFieldLabel = uilabel(app.DetectTab);
            app.BoxSizeEditFieldLabel.HorizontalAlignment = 'right';
            app.BoxSizeEditFieldLabel.Visible = 'off';
            app.BoxSizeEditFieldLabel.Position = [34 307 53 22];
            app.BoxSizeEditFieldLabel.Text = 'Box Size';

            % Create BoxSizeEditField
            app.BoxSizeEditField = uieditfield(app.DetectTab, 'numeric');
            app.BoxSizeEditField.Limits = [2 1000];
            app.BoxSizeEditField.Visible = 'off';
            app.BoxSizeEditField.Position = [90 307 30 22];
            app.BoxSizeEditField.Value = 20;

            % Create FilterCCREditField_Detect
            app.FilterCCREditField_Detect = uieditfield(app.DetectTab, 'numeric');
            app.FilterCCREditField_Detect.Limits = [0 Inf];
            app.FilterCCREditField_Detect.Position = [90 308 30 22];
            app.FilterCCREditField_Detect.Value = 1;

            % Create SettingsLabel_Detect_2
            app.SettingsLabel_Detect_2 = uilabel(app.DetectTab);
            app.SettingsLabel_Detect_2.HorizontalAlignment = 'center';
            app.SettingsLabel_Detect_2.FontWeight = 'bold';
            app.SettingsLabel_Detect_2.FontAngle = 'italic';
            app.SettingsLabel_Detect_2.Position = [262 78 78 22];
            app.SettingsLabel_Detect_2.Text = 'Tracking:';

            % Create FilterxcorimageLabel
            app.FilterxcorimageLabel = uilabel(app.DetectTab);
            app.FilterxcorimageLabel.Position = [1 308 94 22];
            app.FilterxcorimageLabel.Text = 'Filter xcor image';

            % Create ExcludeEdgeCheckBox
            app.ExcludeEdgeCheckBox = uicheckbox(app.DetectTab);
            app.ExcludeEdgeCheckBox.Text = '';
            app.ExcludeEdgeCheckBox.Position = [215 308 19 22];
            app.ExcludeEdgeCheckBox.Value = true;

            % Create ExcludeedgesLabel
            app.ExcludeedgesLabel = uilabel(app.DetectTab);
            app.ExcludeedgesLabel.Position = [131 309 84 22];
            app.ExcludeedgesLabel.Text = 'Exclude edges';

            % Create FilterdetectionsLabel
            app.FilterdetectionsLabel = uilabel(app.DetectTab);
            app.FilterdetectionsLabel.HorizontalAlignment = 'center';
            app.FilterdetectionsLabel.FontWeight = 'bold';
            app.FilterdetectionsLabel.FontAngle = 'italic';
            app.FilterdetectionsLabel.Position = [4 203 98 22];
            app.FilterdetectionsLabel.Text = 'Filter detections';

            % Create PreviewPeaks
            app.PreviewPeaks = uicheckbox(app.DetectTab);
            app.PreviewPeaks.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.PreviewPeaks.Visible = 'off';
            app.PreviewPeaks.Text = '';
            app.PreviewPeaks.Position = [216 287 25 22];

            % Create PreviewpeaksLabel
            app.PreviewpeaksLabel = uilabel(app.DetectTab);
            app.PreviewpeaksLabel.Visible = 'off';
            app.PreviewpeaksLabel.Position = [132 287 83 22];
            app.PreviewpeaksLabel.Text = 'Preview peaks';

            % Create AutocenterreferencePanel
            app.AutocenterreferencePanel = uipanel(app.DetectTab);
            app.AutocenterreferencePanel.Title = 'Auto center reference';
            app.AutocenterreferencePanel.Position = [16 231 144 49];

            % Create AutocentrereCheckBox
            app.AutocentrereCheckBox = uicheckbox(app.AutocenterreferencePanel);
            app.AutocentrereCheckBox.Text = '';
            app.AutocentrereCheckBox.Position = [125 30 16 17];

            % Create FilterImageLabel_2
            app.FilterImageLabel_2 = uilabel(app.AutocenterreferencePanel);
            app.FilterImageLabel_2.HorizontalAlignment = 'right';
            app.FilterImageLabel_2.Position = [3 4 100 22];
            app.FilterImageLabel_2.Text = 'Particle symmetry';

            % Create Symmetry_detect
            app.Symmetry_detect = uieditfield(app.AutocenterreferencePanel, 'numeric');
            app.Symmetry_detect.Limits = [0 Inf];
            app.Symmetry_detect.Position = [106 4 34 22];
            app.Symmetry_detect.Value = 1;

            % Create AllowrotationofreferencePanel
            app.AllowrotationofreferencePanel = uipanel(app.DetectTab);
            app.AllowrotationofreferencePanel.Title = 'Allow rotation of reference';
            app.AllowrotationofreferencePanel.Position = [171 231 162 48];

            % Create RotationalFreedom
            app.RotationalFreedom = uicheckbox(app.AllowrotationofreferencePanel);
            app.RotationalFreedom.Text = '';
            app.RotationalFreedom.Position = [145 29 16 17];

            % Create SearchanglesEditFieldLabel
            app.SearchanglesEditFieldLabel = uilabel(app.AllowrotationofreferencePanel);
            app.SearchanglesEditFieldLabel.HorizontalAlignment = 'right';
            app.SearchanglesEditFieldLabel.Position = [2 4 85 22];
            app.SearchanglesEditFieldLabel.Text = 'Search angles ';

            % Create SearchanglesEditField
            app.SearchanglesEditField = uieditfield(app.AllowrotationofreferencePanel, 'text');
            app.SearchanglesEditField.Position = [90 4 70 22];
            app.SearchanglesEditField.Value = '-40:10:40';

            % Create Peaks_minHeight
            app.Peaks_minHeight = uispinner(app.DetectTab);
            app.Peaks_minHeight.ValueChangedFcn = createCallbackFcn(app, @Peaks_minHeightValueChanged, true);
            app.Peaks_minHeight.Visible = 'off';
            app.Peaks_minHeight.Position = [166 255 52 22];
            app.Peaks_minHeight.Value = 2;

            % Create Peaks_minSep
            app.Peaks_minSep = uispinner(app.DetectTab);
            app.Peaks_minSep.Limits = [1 50];
            app.Peaks_minSep.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.Peaks_minSep.Visible = 'off';
            app.Peaks_minSep.Position = [165 228 53 22];
            app.Peaks_minSep.Value = 2;

            % Create MinheightLabel
            app.MinheightLabel = uilabel(app.DetectTab);
            app.MinheightLabel.Visible = 'off';
            app.MinheightLabel.Position = [104 255 60 22];
            app.MinheightLabel.Text = 'Min height';

            % Create MinseparationLabel
            app.MinseparationLabel = uilabel(app.DetectTab);
            app.MinseparationLabel.Visible = 'off';
            app.MinseparationLabel.Position = [83 229 84 22];
            app.MinseparationLabel.Text = 'Min separation';

            % Create Sq_roi_Button_2
            app.Sq_roi_Button_2 = uibutton(app.DetectTab, 'state');
            app.Sq_roi_Button_2.ValueChangedFcn = createCallbackFcn(app, @Sq_roi_Button_2ValueChanged, true);
            app.Sq_roi_Button_2.Icon = fullfile(pathToMLAPP, 'icons', 'roi_sq.png');
            app.Sq_roi_Button_2.IconAlignment = 'top';
            app.Sq_roi_Button_2.Text = '';
            app.Sq_roi_Button_2.BackgroundColor = [1 1 1];
            app.Sq_roi_Button_2.Position = [315 318 40 40];

            % Create FineAlignTab
            app.FineAlignTab = uitab(app.TabGroup);
            app.FineAlignTab.Title = 'FineAlign';
            app.FineAlignTab.BackgroundColor = [1 1 1];
            app.FineAlignTab.ButtonDownFcn = createCallbackFcn(app, @FineAlignTabButtonDown, true);

            % Create CenterrefButton
            app.CenterrefButton = uibutton(app.FineAlignTab, 'push');
            app.CenterrefButton.ButtonPushedFcn = createCallbackFcn(app, @CenterrefButtonPushed, true);
            app.CenterrefButton.Position = [138 328 75 23];
            app.CenterrefButton.Text = 'Center ref';

            % Create Panel_3
            app.Panel_3 = uipanel(app.FineAlignTab);
            app.Panel_3.BackgroundColor = [0.9412 0.9412 0.9412];
            app.Panel_3.Position = [33 98 280 183];

            % Create searchangleEditFieldLabel
            app.searchangleEditFieldLabel = uilabel(app.Panel_3);
            app.searchangleEditFieldLabel.HorizontalAlignment = 'right';
            app.searchangleEditFieldLabel.Position = [124 107 101 22];
            app.searchangleEditFieldLabel.Text = 'search angle +/- ';

            % Create searchangleEditField
            app.searchangleEditField = uieditfield(app.Panel_3, 'numeric');
            app.searchangleEditField.Limits = [0 Inf];
            app.searchangleEditField.Position = [224 107 39 22];
            app.searchangleEditField.Value = 90;

            % Create RotationalLabel
            app.RotationalLabel = uilabel(app.Panel_3);
            app.RotationalLabel.FontSize = 14;
            app.RotationalLabel.FontWeight = 'bold';
            app.RotationalLabel.FontAngle = 'italic';
            app.RotationalLabel.Position = [178 158 73 22];
            app.RotationalLabel.Text = 'Rotational';

            % Create IterationsEditField_2Label
            app.IterationsEditField_2Label = uilabel(app.Panel_3);
            app.IterationsEditField_2Label.HorizontalAlignment = 'right';
            app.IterationsEditField_2Label.Position = [165 132 54 22];
            app.IterationsEditField_2Label.Text = 'Iterations';

            % Create Rot_IterationsEditField
            app.Rot_IterationsEditField = uieditfield(app.Panel_3, 'numeric');
            app.Rot_IterationsEditField.Limits = [0 Inf];
            app.Rot_IterationsEditField.Position = [224 131 39 22];

            % Create TranslationalLabel
            app.TranslationalLabel = uilabel(app.Panel_3);
            app.TranslationalLabel.FontSize = 14;
            app.TranslationalLabel.FontWeight = 'bold';
            app.TranslationalLabel.FontAngle = 'italic';
            app.TranslationalLabel.Position = [15 159 98 22];
            app.TranslationalLabel.Text = 'Translational';

            % Create IterationsEditField_3Label
            app.IterationsEditField_3Label = uilabel(app.Panel_3);
            app.IterationsEditField_3Label.HorizontalAlignment = 'right';
            app.IterationsEditField_3Label.Position = [15 133 54 22];
            app.IterationsEditField_3Label.Text = 'Iterations';

            % Create Tran_IterationsEditField
            app.Tran_IterationsEditField = uieditfield(app.Panel_3, 'numeric');
            app.Tran_IterationsEditField.Limits = [0 Inf];
            app.Tran_IterationsEditField.Position = [74 132 39 22];
            app.Tran_IterationsEditField.Value = 1;

            % Create MaxdriftEditField_2Label
            app.MaxdriftEditField_2Label = uilabel(app.Panel_3);
            app.MaxdriftEditField_2Label.HorizontalAlignment = 'right';
            app.MaxdriftEditField_2Label.Position = [16 108 53 22];
            app.MaxdriftEditField_2Label.Text = 'Max drift';

            % Create MaxdriftEditField_2
            app.MaxdriftEditField_2 = uieditfield(app.Panel_3, 'numeric');
            app.MaxdriftEditField_2.Limits = [0 Inf];
            app.MaxdriftEditField_2.Position = [74 108 39 22];
            app.MaxdriftEditField_2.Value = 5;

            % Create AutoupdatereferenceimageCheckBox
            app.AutoupdatereferenceimageCheckBox = uicheckbox(app.Panel_3);
            app.AutoupdatereferenceimageCheckBox.Text = 'Auto update reference image';
            app.AutoupdatereferenceimageCheckBox.Position = [8 57 177 22];

            % Create RunFineAlignButton
            app.RunFineAlignButton = uibutton(app.Panel_3, 'push');
            app.RunFineAlignButton.ButtonPushedFcn = createCallbackFcn(app, @RunFineAlignButtonPushed, true);
            app.RunFineAlignButton.FontSize = 14;
            app.RunFineAlignButton.FontWeight = 'bold';
            app.RunFineAlignButton.Position = [91 7 95 26];
            app.RunFineAlignButton.Text = 'Run Align';

            % Create ThresholdwithminheightCheckBox
            app.ThresholdwithminheightCheckBox = uicheckbox(app.Panel_3);
            app.ThresholdwithminheightCheckBox.Text = 'Threshold with min height';
            app.ThresholdwithminheightCheckBox.Position = [8 37 160 22];

            % Create SymmetryEditFieldLabel
            app.SymmetryEditFieldLabel = uilabel(app.FineAlignTab);
            app.SymmetryEditFieldLabel.HorizontalAlignment = 'right';
            app.SymmetryEditFieldLabel.Position = [23 329 59 22];
            app.SymmetryEditFieldLabel.Text = 'Symmetry';

            % Create SymmetryEditField
            app.SymmetryEditField = uieditfield(app.FineAlignTab, 'numeric');
            app.SymmetryEditField.Limits = [1 Inf];
            app.SymmetryEditField.RoundFractionalValues = 'on';
            app.SymmetryEditField.Position = [89 329 45 22];
            app.SymmetryEditField.Value = 1;

            % Create RoiareaEditFieldLabel
            app.RoiareaEditFieldLabel = uilabel(app.FineAlignTab);
            app.RoiareaEditFieldLabel.HorizontalAlignment = 'right';
            app.RoiareaEditFieldLabel.Position = [17 305 68 22];
            app.RoiareaEditFieldLabel.Text = '+/- Roi area';

            % Create RoiareaEditField
            app.RoiareaEditField = uieditfield(app.FineAlignTab, 'numeric');
            app.RoiareaEditField.Position = [89 305 45 22];

            % Create ApplyButton
            app.ApplyButton = uibutton(app.FineAlignTab, 'push');
            app.ApplyButton.ButtonPushedFcn = createCallbackFcn(app, @ApplyButtonPushed, true);
            app.ApplyButton.Position = [138 305 75 22];
            app.ApplyButton.Text = 'Apply';

            % Create LocalizeTab
            app.LocalizeTab = uitab(app.TabGroup);
            app.LocalizeTab.Title = 'Localize';
            app.LocalizeTab.BackgroundColor = [1 1 1];

            % Create Localize_FilterPanel
            app.Localize_FilterPanel = uipanel(app.LocalizeTab);
            app.Localize_FilterPanel.Position = [7 286 207 73];

            % Create HighpassDropDownLabel
            app.HighpassDropDownLabel = uilabel(app.Localize_FilterPanel);
            app.HighpassDropDownLabel.HorizontalAlignment = 'right';
            app.HighpassDropDownLabel.Position = [1 5 61 22];
            app.HighpassDropDownLabel.Text = 'High-pass';

            % Create LoczHighpassDropDown
            app.LoczHighpassDropDown = uidropdown(app.Localize_FilterPanel);
            app.LoczHighpassDropDown.Items = {'Off', 'High-pass', '-Average'};
            app.LoczHighpassDropDown.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.LoczHighpassDropDown.Position = [65 5 85 22];
            app.LoczHighpassDropDown.Value = 'Off';

            % Create LowpassDropDownLabel
            app.LowpassDropDownLabel = uilabel(app.Localize_FilterPanel);
            app.LowpassDropDownLabel.HorizontalAlignment = 'right';
            app.LowpassDropDownLabel.Position = [3 29 58 22];
            app.LowpassDropDownLabel.Text = 'Low-pass';

            % Create LoczLowpassDropDown
            app.LoczLowpassDropDown = uidropdown(app.Localize_FilterPanel);
            app.LoczLowpassDropDown.Items = {'Off', 'Gaussian'};
            app.LoczLowpassDropDown.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.LoczLowpassDropDown.Position = [65 29 85 22];
            app.LoczLowpassDropDown.Value = 'Gaussian';

            % Create LoczLowpass
            app.LoczLowpass = uispinner(app.Localize_FilterPanel);
            app.LoczLowpass.Step = 0.1;
            app.LoczLowpass.Limits = [0 Inf];
            app.LoczLowpass.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.LoczLowpass.Position = [150 29 56 22];

            % Create LoczHighpass
            app.LoczHighpass = uispinner(app.Localize_FilterPanel);
            app.LoczHighpass.Step = 0.1;
            app.LoczHighpass.Limits = [0 Inf];
            app.LoczHighpass.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.LoczHighpass.Position = [150 5 56 22];

            % Create LocFilterLabel
            app.LocFilterLabel = uilabel(app.Localize_FilterPanel);
            app.LocFilterLabel.FontSize = 14;
            app.LocFilterLabel.FontWeight = 'bold';
            app.LocFilterLabel.Position = [10 50 64 22];
            app.LocFilterLabel.Text = 'LocFilter';

            % Create LoczShowfilterCheckBox
            app.LoczShowfilterCheckBox = uicheckbox(app.Localize_FilterPanel);
            app.LoczShowfilterCheckBox.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.LoczShowfilterCheckBox.Text = 'See filter';
            app.LoczShowfilterCheckBox.Position = [99 50 79 22];

            % Create FindallpeaksButton
            app.FindallpeaksButton = uibutton(app.LocalizeTab, 'push');
            app.FindallpeaksButton.ButtonPushedFcn = createCallbackFcn(app, @FindallpeaksButtonPushed, true);
            app.FindallpeaksButton.FontWeight = 'bold';
            app.FindallpeaksButton.Position = [142 181 101 23];
            app.FindallpeaksButton.Text = 'Find all peaks';

            % Create LoczImagepeaksCheckBox
            app.LoczImagepeaksCheckBox = uicheckbox(app.LocalizeTab);
            app.LoczImagepeaksCheckBox.ValueChangedFcn = createCallbackFcn(app, @LoczImagepeaksCheckBoxValueChanged, true);
            app.LoczImagepeaksCheckBox.Text = 'Preview peaks';
            app.LoczImagepeaksCheckBox.Position = [209 255 100 22];

            % Create ThresholdLabel
            app.ThresholdLabel = uilabel(app.LocalizeTab);
            app.ThresholdLabel.HorizontalAlignment = 'right';
            app.ThresholdLabel.Position = [35 256 84 22];
            app.ThresholdLabel.Text = 'Min separation';

            % Create LoczMinSep
            app.LoczMinSep = uispinner(app.LocalizeTab);
            app.LoczMinSep.Limits = [1 50];
            app.LoczMinSep.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.LoczMinSep.Position = [122 256 60 22];
            app.LoczMinSep.Value = 1;

            % Create Localize_ThreshPanel
            app.Localize_ThreshPanel = uipanel(app.LocalizeTab);
            app.Localize_ThreshPanel.Position = [215 286 126 73];

            % Create ThresholdLabel_2
            app.ThresholdLabel_2 = uilabel(app.Localize_ThreshPanel);
            app.ThresholdLabel_2.HorizontalAlignment = 'right';
            app.ThresholdLabel_2.Position = [19 27 40 22];
            app.ThresholdLabel_2.Text = 'Height';

            % Create LoczHeightSpinner
            app.LoczHeightSpinner = uispinner(app.Localize_ThreshPanel);
            app.LoczHeightSpinner.Step = 0.1;
            app.LoczHeightSpinner.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.LoczHeightSpinner.Position = [69 27 55 22];

            % Create ThresholdLabel_3
            app.ThresholdLabel_3 = uilabel(app.Localize_ThreshPanel);
            app.ThresholdLabel_3.FontSize = 14;
            app.ThresholdLabel_3.FontWeight = 'bold';
            app.ThresholdLabel_3.Position = [28 50 73 22];
            app.ThresholdLabel_3.Text = 'Threshold';

            % Create ProminenceSpinnerLabel
            app.ProminenceSpinnerLabel = uilabel(app.Localize_ThreshPanel);
            app.ProminenceSpinnerLabel.HorizontalAlignment = 'right';
            app.ProminenceSpinnerLabel.Position = [2 4 69 22];
            app.ProminenceSpinnerLabel.Text = 'Prominence ';

            % Create LoczProminenceSpinner
            app.LoczProminenceSpinner = uispinner(app.Localize_ThreshPanel);
            app.LoczProminenceSpinner.Step = 0.1;
            app.LoczProminenceSpinner.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.LoczProminenceSpinner.Position = [69 4 54 22];

            % Create RenderLAFMButton
            app.RenderLAFMButton = uibutton(app.LocalizeTab, 'push');
            app.RenderLAFMButton.ButtonPushedFcn = createCallbackFcn(app, @RenderLAFMButtonPushed, true);
            app.RenderLAFMButton.FontWeight = 'bold';
            app.RenderLAFMButton.FontColor = [1 0.0745 0.651];
            app.RenderLAFMButton.Position = [140 140 101 23];
            app.RenderLAFMButton.Text = 'Render LAFM';

            % Create LAFM_LUT
            app.LAFM_LUT = uidropdown(app.LocalizeTab);
            app.LAFM_LUT.Items = {'LAFM', 'hot', 'jet'};
            app.LAFM_LUT.Position = [288 100 64 22];
            app.LAFM_LUT.Value = 'LAFM';

            % Create RenderpointsLabel
            app.RenderpointsLabel = uilabel(app.LocalizeTab);
            app.RenderpointsLabel.HorizontalAlignment = 'right';
            app.RenderpointsLabel.Position = [3 100 80 22];
            app.RenderpointsLabel.Text = 'Render points';

            % Create LAFM_gus
            app.LAFM_gus = uieditfield(app.LocalizeTab, 'numeric');
            app.LAFM_gus.Limits = [0.1 50];
            app.LAFM_gus.Position = [85 100 26 22];
            app.LAFM_gus.Value = 1;

            % Create imageexpansionLabel
            app.imageexpansionLabel = uilabel(app.LocalizeTab);
            app.imageexpansionLabel.HorizontalAlignment = 'right';
            app.imageexpansionLabel.Position = [121 100 61 22];
            app.imageexpansionLabel.Text = 'Expansion';

            % Create LAFM_exp
            app.LAFM_exp = uieditfield(app.LocalizeTab, 'numeric');
            app.LAFM_exp.Limits = [1 50];
            app.LAFM_exp.Position = [184 100 26 22];
            app.LAFM_exp.Value = 5;

            % Create ColourmapLabel
            app.ColourmapLabel = uilabel(app.LocalizeTab);
            app.ColourmapLabel.Position = [223 100 67 22];
            app.ColourmapLabel.Text = 'Colour map';

            % Create ImagePanel
            app.ImagePanel = uipanel(app.NanoLocz1_00Pre);
            app.ImagePanel.ForegroundColor = [0.051 0.051 0.051];
            app.ImagePanel.BackgroundColor = [0.051 0.051 0.051];
            app.ImagePanel.Position = [379 1 971 661];

            % Create UIAxes
            app.UIAxes = uiaxes(app.ImagePanel);
            app.UIAxes.PlotBoxAspectRatio = [1.08032128514056 1 1];
            app.UIAxes.XTick = [];
            app.UIAxes.XTickLabelRotation = 0;
            app.UIAxes.XTickLabel = '';
            app.UIAxes.YTick = [];
            app.UIAxes.YTickLabelRotation = 0;
            app.UIAxes.YTickLabel = '';
            app.UIAxes.ZTick = [0 0.5 1];
            app.UIAxes.ZTickLabelRotation = 0;
            app.UIAxes.ZTickLabel = '';
            app.UIAxes.BusyAction = 'cancel';
            colormap(app.UIAxes, 'hot')
            app.UIAxes.Position = [12 138 472 472];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.ImagePanel);
            app.UIAxes_2.PlotBoxAspectRatio = [1.08032128514056 1 1];
            app.UIAxes_2.XTick = [];
            app.UIAxes_2.XTickLabelRotation = 0;
            app.UIAxes_2.XTickLabel = '';
            app.UIAxes_2.YTick = [];
            app.UIAxes_2.YTickLabelRotation = 0;
            app.UIAxes_2.YTickLabel = '';
            app.UIAxes_2.ZTickLabelRotation = 0;
            colormap(app.UIAxes_2, 'hot')
            app.UIAxes_2.Position = [489 138 472 472];

            % Create VideoPanel
            app.VideoPanel = uipanel(app.ImagePanel);
            app.VideoPanel.BackgroundColor = [1 1 1];
            app.VideoPanel.Position = [4 30 257 95];

            % Create FrameSlider
            app.FrameSlider = uislider(app.VideoPanel);
            app.FrameSlider.Limits = [1 10];
            app.FrameSlider.MajorTicks = [1 10];
            app.FrameSlider.MajorTickLabels = {'1', '10'};
            app.FrameSlider.ValueChangingFcn = createCallbackFcn(app, @FrameSliderValueChanging, true);
            app.FrameSlider.FontSize = 10;
            app.FrameSlider.FontWeight = 'bold';
            app.FrameSlider.FontAngle = 'italic';
            app.FrameSlider.Position = [14 55 229 3];
            app.FrameSlider.Value = 1;

            % Create Spinner
            app.Spinner = uispinner(app.VideoPanel);
            app.Spinner.Limits = [1 Inf];
            app.Spinner.ValueChangedFcn = createCallbackFcn(app, @SpinnerValueChanged, true);
            app.Spinner.Position = [14 67 60 20];
            app.Spinner.Value = 1;

            % Create fpsEditFieldLabel
            app.fpsEditFieldLabel = uilabel(app.VideoPanel);
            app.fpsEditFieldLabel.HorizontalAlignment = 'center';
            app.fpsEditFieldLabel.Position = [224 67 21 21];
            app.fpsEditFieldLabel.Text = 'fps';

            % Create fps
            app.fps = uieditfield(app.VideoPanel, 'numeric');
            app.fps.Limits = [0.1 50];
            app.fps.Position = [197 68 27 18];
            app.fps.Value = 10;

            % Create PlayImage
            app.PlayImage = uiimage(app.VideoPanel);
            app.PlayImage.ImageClickedFcn = createCallbackFcn(app, @PlayImageClicked, true);
            app.PlayImage.Position = [110 65 28 23];
            app.PlayImage.ImageSource = fullfile(pathToMLAPP, 'icons', 'play.png');

            % Create PauseImage
            app.PauseImage = uiimage(app.VideoPanel);
            app.PauseImage.ImageClickedFcn = createCallbackFcn(app, @PauseImageClicked, true);
            app.PauseImage.Position = [109 65 28 24];
            app.PauseImage.ImageSource = fullfile(pathToMLAPP, 'icons', 'pause.png');

            % Create EndImage
            app.EndImage = uiimage(app.VideoPanel);
            app.EndImage.ImageClickedFcn = createCallbackFcn(app, @EndImageClicked, true);
            app.EndImage.Position = [141 69 13 16];
            app.EndImage.ImageSource = fullfile(pathToMLAPP, 'icons', 'end.png');

            % Create StartImage
            app.StartImage = uiimage(app.VideoPanel);
            app.StartImage.ImageClickedFcn = createCallbackFcn(app, @StartImageClicked, true);
            app.StartImage.Position = [92 69 12 16];
            app.StartImage.ImageSource = fullfile(pathToMLAPP, 'icons', 'start.png');

            % Create BinImage
            app.BinImage = uiimage(app.VideoPanel);
            app.BinImage.ImageClickedFcn = createCallbackFcn(app, @BinImageClicked, true);
            app.BinImage.Position = [170 68 19 21];
            app.BinImage.ImageSource = fullfile(pathToMLAPP, 'icons', 'bin.png');

            % Create BinRangeImage
            app.BinRangeImage = uiimage(app.VideoPanel);
            app.BinRangeImage.ImageClickedFcn = createCallbackFcn(app, @BinRangeImageClicked, true);
            app.BinRangeImage.Position = [229 6 19 21];
            app.BinRangeImage.ImageSource = fullfile(pathToMLAPP, 'icons', 'bin.png');

            % Create RemoveframesEditField
            app.RemoveframesEditField = uieditfield(app.VideoPanel, 'text');
            app.RemoveframesEditField.Position = [164 6 65 20];

            % Create DeleterangeLabel
            app.DeleterangeLabel = uilabel(app.VideoPanel);
            app.DeleterangeLabel.HorizontalAlignment = 'right';
            app.DeleterangeLabel.Position = [70 6 91 20];
            app.DeleterangeLabel.Text = 'Delete range:';

            % Create ZPanel
            app.ZPanel = uipanel(app.ImagePanel);
            app.ZPanel.BackgroundColor = [1 1 1];
            app.ZPanel.Position = [373 30 87 95];

            % Create ZScaleDropBox
            app.ZScaleDropBox = uidropdown(app.ZPanel);
            app.ZScaleDropBox.Items = {'Max Min', 'Exc outliers', 'Histogram', 'Manual'};
            app.ZScaleDropBox.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.ZScaleDropBox.Position = [1 71 83 20];
            app.ZScaleDropBox.Value = 'Max Min';

            % Create maxSpinnerLabel
            app.maxSpinnerLabel = uilabel(app.ZPanel);
            app.maxSpinnerLabel.Position = [2 22 25 20];
            app.maxSpinnerLabel.Text = 'max';

            % Create ContrastMaxSpinner
            app.ContrastMaxSpinner = uispinner(app.ZPanel);
            app.ContrastMaxSpinner.Step = 0.25;
            app.ContrastMaxSpinner.ValueChangedFcn = createCallbackFcn(app, @HoldButtonPushed, true);
            app.ContrastMaxSpinner.Position = [25 22 61 20];

            % Create minSpinnerLabel
            app.minSpinnerLabel = uilabel(app.ZPanel);
            app.minSpinnerLabel.Position = [4 2 25 22];
            app.minSpinnerLabel.Text = 'min';

            % Create ContrastMinSpinner
            app.ContrastMinSpinner = uispinner(app.ZPanel);
            app.ContrastMinSpinner.Step = 0.25;
            app.ContrastMinSpinner.ValueChangedFcn = createCallbackFcn(app, @HoldButtonPushed, true);
            app.ContrastMinSpinner.Position = [25 2 61 20];

            % Create AutoButton
            app.AutoButton = uibutton(app.ZPanel, 'push');
            app.AutoButton.ButtonPushedFcn = createCallbackFcn(app, @AutoButtonPushed, true);
            app.AutoButton.Position = [2 44 41 23];
            app.AutoButton.Text = 'Auto';

            % Create HoldButton
            app.HoldButton = uibutton(app.ZPanel, 'push');
            app.HoldButton.ButtonPushedFcn = createCallbackFcn(app, @HoldButtonPushed, true);
            app.HoldButton.Position = [44 44 40 23];
            app.HoldButton.Text = 'Hold';

            % Create ExportButton
            app.ExportButton = uibutton(app.ImagePanel, 'push');
            app.ExportButton.ButtonPushedFcn = createCallbackFcn(app, @ExportButtonPushed, true);
            app.ExportButton.IconAlignment = 'center';
            app.ExportButton.FontWeight = 'bold';
            app.ExportButton.Tooltip = {''};
            app.ExportButton.Position = [3 4 65 20];
            app.ExportButton.Text = 'Export';

            % Create ExportSelect
            app.ExportSelect = uidropdown(app.ImagePanel);
            app.ExportSelect.Items = {'Plot 1', 'Plot 2', 'data'};
            app.ExportSelect.FontWeight = 'bold';
            app.ExportSelect.BackgroundColor = [1 0.4118 0.1608];
            app.ExportSelect.Position = [70 4 65 20];
            app.ExportSelect.Value = 'Plot 1';

            % Create ExportFileFormat
            app.ExportFileFormat = uidropdown(app.ImagePanel);
            app.ExportFileFormat.Items = {'.tiff', '.gif', '.avi', '.png', '.jpeg', '.pdf', '.txt', '.csv', '.xls', 'Matlab workspace'};
            app.ExportFileFormat.FontWeight = 'bold';
            app.ExportFileFormat.BackgroundColor = [1 0.4118 0.1608];
            app.ExportFileFormat.Position = [136 4 80 20];
            app.ExportFileFormat.Value = '.tiff';

            % Create ColourmapDropDown
            app.ColourmapDropDown = uidropdown(app.ImagePanel);
            app.ColourmapDropDown.Items = {'AFM brown', 'AFM gold', 'fire', 'gray', 'hot', 'cool', 'jet', 'turbo', 'parula', 'hsv', 'winter', 'spring', 'summer', 'autumn'};
            app.ColourmapDropDown.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.ColourmapDropDown.FontColor = [1 1 1];
            app.ColourmapDropDown.BackgroundColor = [0 0 0];
            app.ColourmapDropDown.Position = [97 631 99 20];
            app.ColourmapDropDown.Value = 'AFM brown';

            % Create PlotTypeDropDown
            app.PlotTypeDropDown = uidropdown(app.ImagePanel);
            app.PlotTypeDropDown.Items = {'2D surface', '3D surface', 'Coordinates'};
            app.PlotTypeDropDown.ValueChangedFcn = createCallbackFcn(app, @PlotTypeDropDownValueChanged, true);
            app.PlotTypeDropDown.FontColor = [1 1 1];
            app.PlotTypeDropDown.BackgroundColor = [0 0 0];
            app.PlotTypeDropDown.Position = [195 631 93 20];
            app.PlotTypeDropDown.Value = '2D surface';

            % Create OverlayDropDown
            app.OverlayDropDown = uidropdown(app.ImagePanel);
            app.OverlayDropDown.Items = {'None', 'Threshold', 'Line Profile', 'Detections', 'Localizations'};
            app.OverlayDropDown.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.OverlayDropDown.FontColor = [1 1 1];
            app.OverlayDropDown.BackgroundColor = [0 0 0];
            app.OverlayDropDown.Position = [288 631 94 20];
            app.OverlayDropDown.Value = 'Threshold';

            % Create ScalebarCheckBox
            app.ScalebarCheckBox = uicheckbox(app.ImagePanel);
            app.ScalebarCheckBox.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.ScalebarCheckBox.Tooltip = {'Right click for more settings'};
            app.ScalebarCheckBox.Text = 'Scale bar';
            app.ScalebarCheckBox.FontColor = [1 1 1];
            app.ScalebarCheckBox.Position = [280 78 87 20];

            % Create TimescaleCheckBox
            app.TimescaleCheckBox = uicheckbox(app.ImagePanel);
            app.TimescaleCheckBox.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.TimescaleCheckBox.Tooltip = {'Right click for more settings'};
            app.TimescaleCheckBox.Text = 'Timescale';
            app.TimescaleCheckBox.FontColor = [1 1 1];
            app.TimescaleCheckBox.Position = [280 56 87 16];

            % Create AspectRatioSwitch
            app.AspectRatioSwitch = uiswitch(app.ImagePanel, 'slider');
            app.AspectRatioSwitch.Items = {'Original', '1:1'};
            app.AspectRatioSwitch.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.AspectRatioSwitch.FontSize = 14;
            app.AspectRatioSwitch.FontWeight = 'bold';
            app.AspectRatioSwitch.FontColor = [1 1 1];
            app.AspectRatioSwitch.Position = [299 5 41 18];
            app.AspectRatioSwitch.Value = 'Original';

            % Create LeftPlotList
            app.LeftPlotList = uidropdown(app.ImagePanel);
            app.LeftPlotList.Items = {'Target', 'Preview'};
            app.LeftPlotList.FontName = 'Arial';
            app.LeftPlotList.FontSize = 14;
            app.LeftPlotList.FontWeight = 'bold';
            app.LeftPlotList.BackgroundColor = [1 0.4118 0.1608];
            app.LeftPlotList.Position = [8 631 87 20];
            app.LeftPlotList.Value = 'Target';

            % Create ViewpixelsDropDown
            app.ViewpixelsDropDown = uidropdown(app.ImagePanel);
            app.ViewpixelsDropDown.Items = {'Original', 'Interpolated'};
            app.ViewpixelsDropDown.ValueChangedFcn = createCallbackFcn(app, @UpdatePlots, true);
            app.ViewpixelsDropDown.FontColor = [1 1 1];
            app.ViewpixelsDropDown.BackgroundColor = [0 0 0];
            app.ViewpixelsDropDown.Position = [380 631 87 20];
            app.ViewpixelsDropDown.Value = 'Original';

            % Create RightPlotList
            app.RightPlotList = uidropdown(app.ImagePanel);
            app.RightPlotList.Items = {'Off'};
            app.RightPlotList.ValueChangedFcn = createCallbackFcn(app, @RightPlotListValueChanged, true);
            app.RightPlotList.FontName = 'Arial';
            app.RightPlotList.FontSize = 14;
            app.RightPlotList.FontWeight = 'bold';
            app.RightPlotList.BackgroundColor = [1 0.4118 0.1608];
            app.RightPlotList.Position = [507 631 87 20];
            app.RightPlotList.Value = 'Off';

            % Create AcceptButtonImage
            app.AcceptButtonImage = uiimage(app.ImagePanel);
            app.AcceptButtonImage.ScaleMethod = 'fill';
            app.AcceptButtonImage.ImageClickedFcn = createCallbackFcn(app, @AcceptButtonImageClicked, true);
            app.AcceptButtonImage.Visible = 'off';
            app.AcceptButtonImage.Position = [3 218 15 303];
            app.AcceptButtonImage.ImageSource = fullfile(pathToMLAPP, 'icons', 'accept.png');

            % Create ColorBarCheckBox
            app.ColorBarCheckBox = uicheckbox(app.ImagePanel);
            app.ColorBarCheckBox.ValueChangedFcn = createCallbackFcn(app, @ColorBarCheckBoxValueChanged, true);
            app.ColorBarCheckBox.Text = 'z-scale (nm)';
            app.ColorBarCheckBox.FontColor = [1 1 1];
            app.ColorBarCheckBox.Position = [280 104 87 21];

            % Create ProcessingImage
            app.ProcessingImage = uiimage(app.ImagePanel);
            app.ProcessingImage.ScaleMethod = 'fill';
            app.ProcessingImage.Visible = 'off';
            app.ProcessingImage.Position = [3 218 15 303];
            app.ProcessingImage.ImageSource = fullfile(pathToMLAPP, 'icons', 'processing.png');

            % Create Forceto11Button
            app.Forceto11Button = uibutton(app.ImagePanel, 'push');
            app.Forceto11Button.ButtonPushedFcn = createCallbackFcn(app, @Forceto11ButtonPushed, true);
            app.Forceto11Button.Position = [372 4 87 20];
            app.Forceto11Button.Text = 'Force to 1:1';

            % Create HistValue
            app.HistValue = uidropdown(app.ImagePanel);
            app.HistValue.Items = {'Particle Height', 'Particle CCR', 'Particle Angle', 'Radial distribution'};
            app.HistValue.ValueChangedFcn = createCallbackFcn(app, @HistValueValueChanged, true);
            app.HistValue.Visible = 'off';
            app.HistValue.FontColor = [1 1 1];
            app.HistValue.BackgroundColor = [0 0 0];
            app.HistValue.Position = [597 630 115 22];
            app.HistValue.Value = 'Particle Height';

            % Create HistBin
            app.HistBin = uieditfield(app.ImagePanel, 'text');
            app.HistBin.ValueChangedFcn = createCallbackFcn(app, @HistBinValueChanged, true);
            app.HistBin.Visible = 'off';
            app.HistBin.Position = [715 631 90 20];
            app.HistBin.Value = '-10:1:10';

            % Create PopAx1
            app.PopAx1 = uibutton(app.ImagePanel, 'push');
            app.PopAx1.ButtonPushedFcn = createCallbackFcn(app, @PopAx1ButtonPushed, true);
            app.PopAx1.Icon = fullfile(pathToMLAPP, 'icons', 'pop.png');
            app.PopAx1.Position = [468 595 20 20];
            app.PopAx1.Text = '';

            % Create UITable2
            app.UITable2 = uitable(app.ImagePanel);
            app.UITable2.ColumnName = '';
            app.UITable2.ColumnWidth = {30};
            app.UITable2.ColumnRearrangeable = 'on';
            app.UITable2.RowName = {};
            app.UITable2.Visible = 'off';
            app.UITable2.Position = [510 140 444 117];

            % Create PopAx2
            app.PopAx2 = uibutton(app.ImagePanel, 'push');
            app.PopAx2.ButtonPushedFcn = createCallbackFcn(app, @PopAx2Pushed, true);
            app.PopAx2.Icon = fullfile(pathToMLAPP, 'icons', 'pop.png');
            app.PopAx2.Position = [945 595 20 20];
            app.PopAx2.Text = '';

            % Create LineProfilePanel
            app.LineProfilePanel = uipanel(app.ImagePanel);
            app.LineProfilePanel.Visible = 'off';
            app.LineProfilePanel.Position = [852 79 102 59];

            % Create AlignButton
            app.AlignButton = uibutton(app.LineProfilePanel, 'push');
            app.AlignButton.ButtonPushedFcn = createCallbackFcn(app, @AlignButtonPushed, true);
            app.AlignButton.Position = [2 6 40 23];
            app.AlignButton.Text = 'Align';

            % Create Live
            app.Live = uibutton(app.LineProfilePanel, 'state');
            app.Live.Text = 'Live';
            app.Live.FontColor = [1 0 0];
            app.Live.Position = [3 32 97 23];
            app.Live.Value = true;

            % Create AlignLineType
            app.AlignLineType = uidropdown(app.LineProfilePanel);
            app.AlignLineType.Items = {'Correlation', 'Max'};
            app.AlignLineType.Position = [43 6 57 23];
            app.AlignLineType.Value = 'Max';

            % Create LAFMPanel
            app.LAFMPanel = uipanel(app.ImagePanel);
            app.LAFMPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.LAFMPanel.Position = [508 77 444 63];

            % Create MaxLabel_5
            app.MaxLabel_5 = uilabel(app.LAFMPanel);
            app.MaxLabel_5.HorizontalAlignment = 'right';
            app.MaxLabel_5.Position = [6 40 25 22];
            app.MaxLabel_5.Text = 'Max';

            % Create LAFMMaxSlider
            app.LAFMMaxSlider = uislider(app.LAFMPanel);
            app.LAFMMaxSlider.Limits = [0 1];
            app.LAFMMaxSlider.MajorTicks = [];
            app.LAFMMaxSlider.ValueChangingFcn = createCallbackFcn(app, @LAFMMaxSliderValueChanging, true);
            app.LAFMMaxSlider.MinorTicks = [];
            app.LAFMMaxSlider.Position = [40 46 179 3];
            app.LAFMMaxSlider.Value = 1;

            % Create MinLabel_5
            app.MinLabel_5 = uilabel(app.LAFMPanel);
            app.MinLabel_5.HorizontalAlignment = 'right';
            app.MinLabel_5.Position = [1 25 28 22];
            app.MinLabel_5.Text = 'Min';

            % Create LAFMMinSlider
            app.LAFMMinSlider = uislider(app.LAFMPanel);
            app.LAFMMinSlider.Limits = [0 1];
            app.LAFMMinSlider.MajorTicks = [];
            app.LAFMMinSlider.ValueChangingFcn = createCallbackFcn(app, @LAFMMinSliderValueChanging, true);
            app.LAFMMinSlider.MinorTicks = [];
            app.LAFMMinSlider.Position = [38 34 182 3];

            % Create LAFM_sym_2
            app.LAFM_sym_2 = uispinner(app.LAFMPanel);
            app.LAFM_sym_2.Limits = [1 50];
            app.LAFM_sym_2.ValueChangedFcn = createCallbackFcn(app, @LAFM_sym_2ValueChanged, true);
            app.LAFM_sym_2.Position = [385 36 45 22];
            app.LAFM_sym_2.Value = 1;

            % Create AutoCenterLAFM
            app.AutoCenterLAFM = uicheckbox(app.LAFMPanel);
            app.AutoCenterLAFM.ValueChangedFcn = createCallbackFcn(app, @AutoCenterLAFMValueChanged, true);
            app.AutoCenterLAFM.Text = 'Auto Center';
            app.AutoCenterLAFM.Position = [290 16 86 22];
            app.AutoCenterLAFM.Value = true;

            % Create ViewSymmetrizedButton
            app.ViewSymmetrizedButton = uibutton(app.LAFMPanel, 'state');
            app.ViewSymmetrizedButton.ValueChangedFcn = createCallbackFcn(app, @ViewSymmetrizedButtonValueChanged, true);
            app.ViewSymmetrizedButton.Text = 'View Symmetrized';
            app.ViewSymmetrizedButton.Position = [272 35 114 23];

            % Create LAFMScalebarCheckBox
            app.LAFMScalebarCheckBox = uicheckbox(app.LAFMPanel);
            app.LAFMScalebarCheckBox.ValueChangedFcn = createCallbackFcn(app, @LAFMScalebarCheckBoxValueChanged, true);
            app.LAFMScalebarCheckBox.Tooltip = {'Right click for more settings'};
            app.LAFMScalebarCheckBox.Text = 'Scale bar';
            app.LAFMScalebarCheckBox.Position = [89 9 87 20];

            % Create DropDown
            app.DropDown = uidropdown(app.ImagePanel);
            app.DropDown.Items = {};
            app.DropDown.ValueChangedFcn = createCallbackFcn(app, @DropDownValueChanged, true);
            app.DropDown.Visible = 'off';
            app.DropDown.Position = [522 40 100 22];
            app.DropDown.Value = {};

            % Create RefCropButton
            app.RefCropButton = uibutton(app.ImagePanel, 'push');
            app.RefCropButton.ButtonPushedFcn = createCallbackFcn(app, @RefCropButtonPushed, true);
            app.RefCropButton.Icon = fullfile(pathToMLAPP, 'icons', 'crop.png');
            app.RefCropButton.IconAlignment = 'center';
            app.RefCropButton.Visible = 'off';
            app.RefCropButton.Tooltip = {'Crop Reference'};
            app.RefCropButton.Position = [633 34 44 35];
            app.RefCropButton.Text = '';

            % Create ReferenceButtonGroup
            app.ReferenceButtonGroup = uibuttongroup(app.ImagePanel);
            app.ReferenceButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ReferenceButtonGroupSelectionChanged, true);
            app.ReferenceButtonGroup.BorderColor = [1 1 1];
            app.ReferenceButtonGroup.Title = 'Reference:';
            app.ReferenceButtonGroup.Visible = 'off';
            app.ReferenceButtonGroup.BackgroundColor = [0.8 0.8 0.8];
            app.ReferenceButtonGroup.Position = [847 1 123 140];

            % Create MultiReferenceCheckBox
            app.MultiReferenceCheckBox = uicheckbox(app.ImagePanel);
            app.MultiReferenceCheckBox.ValueChangedFcn = createCallbackFcn(app, @MultiReferenceCheckBoxValueChanged, true);
            app.MultiReferenceCheckBox.Text = 'Multi Reference';
            app.MultiReferenceCheckBox.FontColor = [1 1 1];
            app.MultiReferenceCheckBox.Position = [530 9 106 22];

            % Create ClearButton_2
            app.ClearButton_2 = uibutton(app.ImagePanel, 'push');
            app.ClearButton_2.ButtonPushedFcn = createCallbackFcn(app, @ClearButton_2Pushed, true);
            app.ClearButton_2.FontWeight = 'bold';
            app.ClearButton_2.Visible = 'off';
            app.ClearButton_2.Position = [683 35 45 33];
            app.ClearButton_2.Text = 'Clear';

            % Create PreviewonoffButton
            app.PreviewonoffButton = uibutton(app.NanoLocz1_00Pre, 'state');
            app.PreviewonoffButton.ValueChangedFcn = createCallbackFcn(app, @PreviewonoffButtonValueChanged, true);
            app.PreviewonoffButton.Text = 'Preview on/off';
            app.PreviewonoffButton.WordWrap = 'on';
            app.PreviewonoffButton.BackgroundColor = [0 1 0];
            app.PreviewonoffButton.FontWeight = 'bold';
            app.PreviewonoffButton.Position = [276 424 104 25];

            % Create FramePartSwitch
            app.FramePartSwitch = uiswitch(app.NanoLocz1_00Pre, 'slider');
            app.FramePartSwitch.Items = {'Frames', 'Particles'};
            app.FramePartSwitch.ValueChangedFcn = createCallbackFcn(app, @FramePartSwitchValueChanged, true);
            app.FramePartSwitch.FontSize = 14;
            app.FramePartSwitch.FontWeight = 'bold';
            app.FramePartSwitch.FontColor = [1 0.4118 0.1608];
            app.FramePartSwitch.Position = [260 401 41 18];
            app.FramePartSwitch.Value = 'Frames';

            % Create BidirectionaldataCheckBox
            app.BidirectionaldataCheckBox = uicheckbox(app.NanoLocz1_00Pre);
            app.BidirectionaldataCheckBox.ValueChangedFcn = createCallbackFcn(app, @BidirectionaldataCheckBoxValueChanged, true);
            app.BidirectionaldataCheckBox.Tooltip = {'Bidirectional scan - How to check: Trace will appear as smoothed ReTrace'};
            app.BidirectionaldataCheckBox.Text = 'Bi-directional data';
            app.BidirectionaldataCheckBox.Position = [14 401 118 22];

            % Create AutoplayCheckBox
            app.AutoplayCheckBox = uicheckbox(app.NanoLocz1_00Pre);
            app.AutoplayCheckBox.Text = 'Auto play';
            app.AutoplayCheckBox.Position = [14 431 72 22];

            % Create View1stCheckBox
            app.View1stCheckBox = uicheckbox(app.NanoLocz1_00Pre);
            app.View1stCheckBox.ValueChangedFcn = createCallbackFcn(app, @Reload, true);
            app.View1stCheckBox.Text = 'View 1st         frames';
            app.View1stCheckBox.Position = [14 416 134 22];

            % Create View1st
            app.View1st = uieditfield(app.NanoLocz1_00Pre, 'numeric');
            app.View1st.Limits = [1 Inf];
            app.View1st.ValueChangedFcn = createCallbackFcn(app, @Reload, true);
            app.View1st.Position = [79 417 23 22];
            app.View1st.Value = 10;

            % Create OpenFolderButton
            app.OpenFolderButton = uiimage(app.NanoLocz1_00Pre);
            app.OpenFolderButton.ImageClickedFcn = createCallbackFcn(app, @OpenFolderButtonClicked, true);
            app.OpenFolderButton.Tooltip = {'Open working folder or session'};
            app.OpenFolderButton.Position = [21 656 42 47];
            app.OpenFolderButton.ImageSource = fullfile(pathToMLAPP, 'icons', 'open.png');

            % Create SaveSession
            app.SaveSession = uiimage(app.NanoLocz1_00Pre);
            app.SaveSession.ImageClickedFcn = createCallbackFcn(app, @SaveSessionImageClicked, true);
            app.SaveSession.Tooltip = {'Save'};
            app.SaveSession.Position = [79 656 46 46];
            app.SaveSession.ImageSource = fullfile(pathToMLAPP, 'icons', 'save.png');

            % Create FilesDropDown
            app.FilesDropDown = uidropdown(app.NanoLocz1_00Pre);
            app.FilesDropDown.Items = {'All files', 'Processed'};
            app.FilesDropDown.ValueChangedFcn = createCallbackFcn(app, @FilesDropDownValueChanged, true);
            app.FilesDropDown.Position = [13 635 83 22];
            app.FilesDropDown.Value = 'All files';

            % Create SaveType
            app.SaveType = uidropdown(app.NanoLocz1_00Pre);
            app.SaveType.Items = {'All Processed', 'Current File'};
            app.SaveType.Position = [119 668 64 22];
            app.SaveType.Value = 'All Processed';

            % Create ThumbnailViewButton
            app.ThumbnailViewButton = uibutton(app.NanoLocz1_00Pre, 'push');
            app.ThumbnailViewButton.ButtonPushedFcn = createCallbackFcn(app, @ThumbnailViewButtonPushed, true);
            app.ThumbnailViewButton.Position = [184 635 100 22];
            app.ThumbnailViewButton.Text = 'Thumbnail View';

            % Create ContextMenu_ScaleBar
            app.ContextMenu_ScaleBar = uicontextmenu(app.NanoLocz1_00Pre);

            % Create ChangeColorMenu
            app.ChangeColorMenu = uimenu(app.ContextMenu_ScaleBar);
            app.ChangeColorMenu.Text = 'Change Color';

            % Create BlackMenu
            app.BlackMenu = uimenu(app.ChangeColorMenu);
            app.BlackMenu.MenuSelectedFcn = createCallbackFcn(app, @BlackMenuSelected, true);
            app.BlackMenu.Text = 'Black';

            % Create WhiteMenu
            app.WhiteMenu = uimenu(app.ChangeColorMenu);
            app.WhiteMenu.MenuSelectedFcn = createCallbackFcn(app, @WhiteMenuSelected, true);
            app.WhiteMenu.Text = 'White';

            % Create CyanMenu
            app.CyanMenu = uimenu(app.ChangeColorMenu);
            app.CyanMenu.MenuSelectedFcn = createCallbackFcn(app, @CyanMenuSelected, true);
            app.CyanMenu.Text = 'Cyan';

            % Create MagentaMenu
            app.MagentaMenu = uimenu(app.ChangeColorMenu);
            app.MagentaMenu.MenuSelectedFcn = createCallbackFcn(app, @MagentaMenuSelected, true);
            app.MagentaMenu.Text = 'Magenta';

            % Create BlueMenu
            app.BlueMenu = uimenu(app.ChangeColorMenu);
            app.BlueMenu.MenuSelectedFcn = createCallbackFcn(app, @BlueMenuSelected, true);
            app.BlueMenu.Text = 'Blue';

            % Create GreenMenu
            app.GreenMenu = uimenu(app.ChangeColorMenu);
            app.GreenMenu.MenuSelectedFcn = createCallbackFcn(app, @GreenMenuSelected, true);
            app.GreenMenu.Text = 'Green';

            % Create YellowMenu
            app.YellowMenu = uimenu(app.ChangeColorMenu);
            app.YellowMenu.MenuSelectedFcn = createCallbackFcn(app, @YellowMenuSelected, true);
            app.YellowMenu.Text = 'Yellow';

            % Create ChangePositionMenu
            app.ChangePositionMenu = uimenu(app.ContextMenu_ScaleBar);
            app.ChangePositionMenu.Text = 'Change Position';

            % Create BottomRightMenu
            app.BottomRightMenu = uimenu(app.ChangePositionMenu);
            app.BottomRightMenu.MenuSelectedFcn = createCallbackFcn(app, @BottomRightMenuSelected, true);
            app.BottomRightMenu.Text = 'Bottom Right';

            % Create BottomLeftMenu
            app.BottomLeftMenu = uimenu(app.ChangePositionMenu);
            app.BottomLeftMenu.MenuSelectedFcn = createCallbackFcn(app, @BottomLeftMenuSelected, true);
            app.BottomLeftMenu.Text = 'Bottom Left';

            % Create TopRightMenu
            app.TopRightMenu = uimenu(app.ChangePositionMenu);
            app.TopRightMenu.MenuSelectedFcn = createCallbackFcn(app, @TopRightMenuSelected, true);
            app.TopRightMenu.Text = 'Top Right';

            % Create TopLeftMenu
            app.TopLeftMenu = uimenu(app.ChangePositionMenu);
            app.TopLeftMenu.MenuSelectedFcn = createCallbackFcn(app, @TopLeftMenuSelected, true);
            app.TopLeftMenu.Text = 'Top Left';

            % Create ContextMenu_TimeScale
            app.ContextMenu_TimeScale = uicontextmenu(app.NanoLocz1_00Pre);

            % Create ChangePositionMenu_2
            app.ChangePositionMenu_2 = uimenu(app.ContextMenu_TimeScale);
            app.ChangePositionMenu_2.Text = 'Change Position';

            % Create TopLeftMenu_2
            app.TopLeftMenu_2 = uimenu(app.ChangePositionMenu_2);
            app.TopLeftMenu_2.MenuSelectedFcn = createCallbackFcn(app, @TopLeftMenu_2Selected, true);
            app.TopLeftMenu_2.Text = 'Top Left';

            % Create TopRightMenu_2
            app.TopRightMenu_2 = uimenu(app.ChangePositionMenu_2);
            app.TopRightMenu_2.MenuSelectedFcn = createCallbackFcn(app, @TopRightMenu_2Selected, true);
            app.TopRightMenu_2.Text = 'Top Right';

            % Create BottomRightMenu_2
            app.BottomRightMenu_2 = uimenu(app.ChangePositionMenu_2);
            app.BottomRightMenu_2.MenuSelectedFcn = createCallbackFcn(app, @BottomRightMenu_2Selected, true);
            app.BottomRightMenu_2.Text = 'Bottom Right';

            % Create BottomLeftMenu_2
            app.BottomLeftMenu_2 = uimenu(app.ChangePositionMenu_2);
            app.BottomLeftMenu_2.MenuSelectedFcn = createCallbackFcn(app, @BottomLeftMenu_2Selected, true);
            app.BottomLeftMenu_2.Text = 'Bottom Left';

            % Create ChangeColourMenu
            app.ChangeColourMenu = uimenu(app.ContextMenu_TimeScale);
            app.ChangeColourMenu.Text = 'Change Colour';

            % Create BlackMenu_2
            app.BlackMenu_2 = uimenu(app.ChangeColourMenu);
            app.BlackMenu_2.MenuSelectedFcn = createCallbackFcn(app, @BlackMenu_2Selected, true);
            app.BlackMenu_2.Text = 'Black';

            % Create WhiteMenu_2
            app.WhiteMenu_2 = uimenu(app.ChangeColourMenu);
            app.WhiteMenu_2.MenuSelectedFcn = createCallbackFcn(app, @WhiteMenu_2Selected, true);
            app.WhiteMenu_2.Text = 'White';

            % Create CyanMenu_2
            app.CyanMenu_2 = uimenu(app.ChangeColourMenu);
            app.CyanMenu_2.MenuSelectedFcn = createCallbackFcn(app, @CyanMenu_2Selected, true);
            app.CyanMenu_2.Text = 'Cyan';

            % Create MagentaMenu_2
            app.MagentaMenu_2 = uimenu(app.ChangeColourMenu);
            app.MagentaMenu_2.MenuSelectedFcn = createCallbackFcn(app, @MagentaMenu_2Selected, true);
            app.MagentaMenu_2.Text = 'Magenta';

            % Create BlueMenu_2
            app.BlueMenu_2 = uimenu(app.ChangeColourMenu);
            app.BlueMenu_2.MenuSelectedFcn = createCallbackFcn(app, @BlueMenu_2Selected, true);
            app.BlueMenu_2.Text = 'Blue';

            % Create GreenMenu_2
            app.GreenMenu_2 = uimenu(app.ChangeColourMenu);
            app.GreenMenu_2.MenuSelectedFcn = createCallbackFcn(app, @GreenMenu_2Selected, true);
            app.GreenMenu_2.Text = 'Green';

            % Create YellowMenu_2
            app.YellowMenu_2 = uimenu(app.ChangeColourMenu);
            app.YellowMenu_2.MenuSelectedFcn = createCallbackFcn(app, @YellowMenu_2Selected, true);
            app.YellowMenu_2.Text = 'Yellow';

            % Create ExportContextMenu
            app.ExportContextMenu = uicontextmenu(app.NanoLocz1_00Pre);

            % Create BackgroundcolorMenu
            app.BackgroundcolorMenu = uimenu(app.ExportContextMenu);
            app.BackgroundcolorMenu.Text = 'Background color';

            % Create blackMenu
            app.blackMenu = uimenu(app.BackgroundcolorMenu);
            app.blackMenu.MenuSelectedFcn = createCallbackFcn(app, @blackMenuSelected, true);
            app.blackMenu.Text = 'black';

            % Create whiteMenu
            app.whiteMenu = uimenu(app.BackgroundcolorMenu);
            app.whiteMenu.MenuSelectedFcn = createCallbackFcn(app, @whiteMenuSelected, true);
            app.whiteMenu.Text = 'white';

            % Create ResolutionDPIMenu
            app.ResolutionDPIMenu = uimenu(app.ExportContextMenu);
            app.ResolutionDPIMenu.Text = 'Resolution (DPI)';

            % Create dpi75
            app.dpi75 = uimenu(app.ResolutionDPIMenu);
            app.dpi75.MenuSelectedFcn = createCallbackFcn(app, @dpi75MenuSelected, true);
            app.dpi75.Text = '75';

            % Create dpi150
            app.dpi150 = uimenu(app.ResolutionDPIMenu);
            app.dpi150.MenuSelectedFcn = createCallbackFcn(app, @dpi150MenuSelected, true);
            app.dpi150.Text = '150';

            % Create dpi300
            app.dpi300 = uimenu(app.ResolutionDPIMenu);
            app.dpi300.MenuSelectedFcn = createCallbackFcn(app, @dpi300MenuSelected, true);
            app.dpi300.Text = '300';

            % Create dpi450
            app.dpi450 = uimenu(app.ResolutionDPIMenu);
            app.dpi450.MenuSelectedFcn = createCallbackFcn(app, @dpi450MenuSelected, true);
            app.dpi450.Text = '450';

            % Show the figure after all components are created
            app.NanoLocz1_00Pre.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = NanoLocz_v1_03_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.NanoLocz1_00Pre)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.NanoLocz1_00Pre)
        end
    end
end