// Action script...

// [onClipEvent of sprite 497 in frame 1]
onClipEvent (construct)
{
    title = "Error";
    message = "This presentation requires the screen to be at least 1024x768. Please reset the screen size then try launching again.";
    icon = "error";
    buttons = [];
    buttons[0] = "Quit";
    closeHandler = "doQuit";
    buttonWidth = 100;
    titlebarHeight = 20;
    setProperty("", _visible, false);
}

// [onClipEvent of sprite 497 in frame 1]
onClipEvent (construct)
{
    title = "Error";
    message = "This presentation requires the screen to be at least 1024x768. Please reset the screen size then try launching again.";
    icon = "error";
    buttons = [];
    buttons[0] = "Quit";
    closeHandler = "doQuit";
    buttonWidth = 100;
    titlebarHeight = 20;
    setProperty("", _visible, false);
}

// [onClipEvent of sprite 455 in frame 2]
onClipEvent (construct)
{
    title = "Demo Version";
    message = "This feature is only available in full version only.  To order, please contact one of our training specialists at 877-752-5329 or visit us at www.makaucorp.com";
    icon = "famb_infoIcon";
    buttons = [];
    buttons[0] = "OK";
    closeHandler = "";
    buttonWidth = 100;
    titlebarHeight = 20;
    ActiveState = false;
    useScrollbars = "auto";
}

// [onClipEvent of sprite 210 in frame 2]
onClipEvent (construct)
{
    editable = false;
    labels = [];
    labels[0] = "No Bookmarks Set";
    rowCount = 4;
    restrict = "";
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 425 in frame 6]
onClipEvent (construct)
{
    aspectRatio = true;
    autoPlay = true;
    autoSize = true;
    contentPath = "";
    fps = 15;
    mediaType = "FLV";
    totalTime = 0;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 425 in frame 6]
onClipEvent (load)
{
    function __f_complete(eventObj)
    {
        this.stop();
        _root.HeadMov.stop();
        _root.HeadMov.clear();
        this._parent.gotoAndPlay("outlines");
    } // End of the function
    this.addEventListener("complete", __f_complete);
}

// [onClipEvent of sprite 425 in frame 6]
onClipEvent (mouseDown)
{
    this.stop();
    _root.HeadMov.stop();
    _root.HeadMov.clear();
    this._parent.gotoAndPlay("outlines");
}

// [onClipEvent of sprite 748 in frame 10]
onClipEvent (construct)
{
    activePlayControl = "pause";
    backgroundStyle = "none";
    controllerPolicy = "on";
    horizontal = true;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 748 in frame 10]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this.associateDisplay(this._parent.HeadMov);
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 780 in frame 10]
onClipEvent (construct)
{
    _defaultVol = 100;
}

// [onClipEvent of sprite 425 in frame 10]
onClipEvent (construct)
{
    aspectRatio = true;
    autoPlay = false;
    autoSize = true;
    contentPath = "";
    fps = "ms";
    mediaType = "FLV";
    totalTime = 0;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 921 in frame 57]
onClipEvent (construct)
{
    searchKey = 116;
    Randomize = false;
    QuestionsToAsk = 0;
    LoginURL = "";
    Activity_ID = 103;
    Activity_Name = "Quiz3";
    Results = true;
}

// [onClipEvent of sprite 35 in frame 58]
onClipEvent (construct)
{
    icon = "";
    label = "Control Button";
    labelPlacement = "right";
    selected = false;
    toggle = false;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 406 in frame 61]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 61]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 953 in frame 61]
onClipEvent (construct)
{
    searchKey = 244;
    Interaction_ID = "Interaction_01";
    Question = "Which of the following numbers are divisible by 3?";
    Distractor_Label1 = 9;
    Distractor_Label2 = 41;
    Distractor_Label3 = 18;
    Distractor_Label4 = 22;
    Distractor_Label5 = 33;
    Distractor_Label6 = 44;
    Distractor_Label7 = 55;
    Distractor_Label8 = 97;
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = false;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = false;
    Correct_Response8 = false;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on a Checkbox.";
    Correct_Feedback = "Yes, that is correct.";
    Incorrect_Feedback = "No, that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "That is incorrect. Try Again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    checkName1 = "Checkbox1";
    checkName2 = "Checkbox2";
    checkName3 = "Checkbox3";
    checkName4 = "Checkbox4";
    checkName5 = "Checkbox5";
    checkName6 = "Checkbox6";
    checkName7 = "Checkbox7";
    checkName8 = "Checkbox8";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 26165;
}

// [onClipEvent of sprite 234 in frame 61]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 61]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 61]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 61]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 61]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 61]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 61]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 61]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 63]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 63]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 457 in frame 63]
onClipEvent (construct)
{
    _targetInstanceName = "text_scroll";
    horizontal = false;
    enabled = true;
    visible = false;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 457 in frame 63]
onClipEvent (construct)
{
    _targetInstanceName = "text_scrollH";
    horizontal = true;
    enabled = true;
    visible = false;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 953 in frame 63]
onClipEvent (construct)
{
    searchKey = 244;
    Interaction_ID = "Interaction_01";
    Question = "Which of the following numbers are divisible by 3?";
    Distractor_Label1 = 9;
    Distractor_Label2 = 41;
    Distractor_Label3 = 18;
    Distractor_Label4 = 22;
    Distractor_Label5 = 33;
    Distractor_Label6 = 44;
    Distractor_Label7 = 55;
    Distractor_Label8 = 97;
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = false;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = false;
    Correct_Response8 = false;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on a Checkbox.";
    Correct_Feedback = "Yes, that is correct.";
    Incorrect_Feedback = "No, that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "That is incorrect. Try Again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    checkName1 = "Checkbox1";
    checkName2 = "Checkbox2";
    checkName3 = "Checkbox3";
    checkName4 = "Checkbox4";
    checkName5 = "Checkbox5";
    checkName6 = "Checkbox6";
    checkName7 = "Checkbox7";
    checkName8 = "Checkbox8";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 26165;
}

// [onClipEvent of sprite 234 in frame 63]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 63]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 63]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 63]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 63]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 63]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 63]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 63]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 748 in frame 65]
onClipEvent (construct)
{
    activePlayControl = "pause";
    backgroundStyle = "none";
    controllerPolicy = "on";
    horizontal = true;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 748 in frame 65]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this.associateDisplay(this._parent.QuizMov);
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 780 in frame 65]
onClipEvent (construct)
{
    _defaultVol = 100;
}

// [onClipEvent of sprite 406 in frame 65]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 65]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 953 in frame 65]
onClipEvent (construct)
{
    searchKey = 244;
    Interaction_ID = "Interaction_01";
    Question = "Which of the following numbers are divisible by 3?";
    Distractor_Label1 = 9;
    Distractor_Label2 = 41;
    Distractor_Label3 = 18;
    Distractor_Label4 = 22;
    Distractor_Label5 = 33;
    Distractor_Label6 = 44;
    Distractor_Label7 = 55;
    Distractor_Label8 = 97;
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = false;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = false;
    Correct_Response8 = false;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on a Checkbox.";
    Correct_Feedback = "Yes, that is correct.";
    Incorrect_Feedback = "No, that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "That is incorrect. Try Again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    checkName1 = "Checkbox1";
    checkName2 = "Checkbox2";
    checkName3 = "Checkbox3";
    checkName4 = "Checkbox4";
    checkName5 = "Checkbox5";
    checkName6 = "Checkbox6";
    checkName7 = "Checkbox7";
    checkName8 = "Checkbox8";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 26165;
}

// [onClipEvent of sprite 234 in frame 65]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 65]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 65]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 65]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 65]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 65]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 65]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 65]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 425 in frame 65]
onClipEvent (construct)
{
    aspectRatio = true;
    autoPlay = false;
    autoSize = true;
    contentPath = "";
    fps = "ms";
    mediaType = "FLV";
    totalTime = 0;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 780 in frame 67]
onClipEvent (construct)
{
    _defaultVol = 100;
}

// [onClipEvent of sprite 748 in frame 67]
onClipEvent (construct)
{
    activePlayControl = "pause";
    backgroundStyle = "none";
    controllerPolicy = "on";
    horizontal = true;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 748 in frame 67]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this.associateDisplay(this._parent.QuizMov);
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 406 in frame 67]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 67]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 953 in frame 67]
onClipEvent (construct)
{
    searchKey = 244;
    Interaction_ID = "Interaction_01";
    Question = "Which of the following numbers are divisible by 3?";
    Distractor_Label1 = 9;
    Distractor_Label2 = 41;
    Distractor_Label3 = 18;
    Distractor_Label4 = 22;
    Distractor_Label5 = 33;
    Distractor_Label6 = 44;
    Distractor_Label7 = 55;
    Distractor_Label8 = 97;
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = false;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = false;
    Correct_Response8 = false;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on a Checkbox.";
    Correct_Feedback = "Yes, that is correct.";
    Incorrect_Feedback = "No, that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "That is incorrect. Try Again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    checkName1 = "Checkbox1";
    checkName2 = "Checkbox2";
    checkName3 = "Checkbox3";
    checkName4 = "Checkbox4";
    checkName5 = "Checkbox5";
    checkName6 = "Checkbox6";
    checkName7 = "Checkbox7";
    checkName8 = "Checkbox8";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 14809;
}

// [onClipEvent of sprite 234 in frame 67]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 67]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 67]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 67]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 67]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 67]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 67]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 234 in frame 67]
onClipEvent (construct)
{
    label = "CheckBox";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 425 in frame 67]
onClipEvent (construct)
{
    aspectRatio = false;
    autoPlay = false;
    autoSize = false;
    contentPath = "";
    fps = "ms";
    mediaType = "MP3";
    totalTime = 0;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 406 in frame 70]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 70]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1001 in frame 70]
onClipEvent (construct)
{
    searchKey = 244;
    Interaction_ID = "Interaction_01";
    Question = "Which of the following numbers are divisible by 3?";
    Distractor_Label1 = "A. True";
    Distractor_Label2 = "B. False";
    Distractor_Label3 = 18;
    Distractor_Label4 = 22;
    Distractor_Label5 = 33;
    Distractor_Label6 = 44;
    Distractor_Label7 = 55;
    Distractor_Label8 = 97;
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = false;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = false;
    Correct_Response8 = false;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on a Radio Button.";
    Correct_Feedback = "Yes, that is correct.";
    Incorrect_Feedback = "No, that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "That is incorrect. Try Again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    checkName1 = "Checkbox1";
    checkName2 = "Checkbox2";
    checkName3 = "Checkbox3";
    checkName4 = "Checkbox4";
    checkName5 = "Checkbox5";
    checkName6 = "Checkbox6";
    checkName7 = "Checkbox7";
    checkName8 = "Checkbox8";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 26165;
    Assets4 = "Radio1";
    Assets5 = "Radio2";
    Assets6 = "radioGroup";
    Correct_Response = true;
}

// [onClipEvent of sprite 406 in frame 70]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 70]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 72]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 72]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 457 in frame 72]
onClipEvent (construct)
{
    _targetInstanceName = "text_scrollH";
    horizontal = true;
    enabled = true;
    visible = false;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 457 in frame 72]
onClipEvent (construct)
{
    _targetInstanceName = "text_scroll";
    horizontal = false;
    enabled = true;
    visible = false;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 1001 in frame 72]
onClipEvent (construct)
{
    searchKey = 244;
    Interaction_ID = "Interaction_01";
    Question = "Which of the following numbers are divisible by 3?";
    Distractor_Label1 = "A. True";
    Distractor_Label2 = "B. False";
    Distractor_Label3 = 18;
    Distractor_Label4 = 22;
    Distractor_Label5 = 33;
    Distractor_Label6 = 44;
    Distractor_Label7 = 55;
    Distractor_Label8 = 97;
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = false;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = false;
    Correct_Response8 = false;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on a Radio Button.";
    Correct_Feedback = "Yes, that is correct.";
    Incorrect_Feedback = "No, that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "That is incorrect. Try Again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    checkName1 = "Checkbox1";
    checkName2 = "Checkbox2";
    checkName3 = "Checkbox3";
    checkName4 = "Checkbox4";
    checkName5 = "Checkbox5";
    checkName6 = "Checkbox6";
    checkName7 = "Checkbox7";
    checkName8 = "Checkbox8";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 26165;
    Assets4 = "Radio1";
    Assets5 = "Radio2";
    Assets6 = "radioGroup";
    Correct_Response = true;
}

// [onClipEvent of sprite 406 in frame 72]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 72]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 780 in frame 74]
onClipEvent (construct)
{
    _defaultVol = 100;
}

// [onClipEvent of sprite 748 in frame 74]
onClipEvent (construct)
{
    activePlayControl = "pause";
    backgroundStyle = "none";
    controllerPolicy = "on";
    horizontal = true;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 748 in frame 74]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this.associateDisplay(this._parent.QuizMov);
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 406 in frame 74]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 74]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1001 in frame 74]
onClipEvent (construct)
{
    searchKey = 244;
    Interaction_ID = "Interaction_01";
    Question = "Which of the following numbers are divisible by 3?";
    Distractor_Label1 = "A. True";
    Distractor_Label2 = "B. False";
    Distractor_Label3 = 18;
    Distractor_Label4 = 22;
    Distractor_Label5 = 33;
    Distractor_Label6 = 44;
    Distractor_Label7 = 55;
    Distractor_Label8 = 97;
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = false;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = false;
    Correct_Response8 = false;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on a Radio Button.";
    Correct_Feedback = "Yes, that is correct.";
    Incorrect_Feedback = "No, that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "That is incorrect. Try Again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    checkName1 = "Checkbox1";
    checkName2 = "Checkbox2";
    checkName3 = "Checkbox3";
    checkName4 = "Checkbox4";
    checkName5 = "Checkbox5";
    checkName6 = "Checkbox6";
    checkName7 = "Checkbox7";
    checkName8 = "Checkbox8";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 26165;
    Assets4 = "Radio1";
    Assets5 = "Radio2";
    Assets6 = "radioGroup";
    Correct_Response = true;
}

// [onClipEvent of sprite 406 in frame 74]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 74]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 425 in frame 74]
onClipEvent (construct)
{
    aspectRatio = true;
    autoPlay = false;
    autoSize = true;
    contentPath = "";
    fps = "ms";
    mediaType = "FLV";
    totalTime = 0;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 780 in frame 76]
onClipEvent (construct)
{
    _defaultVol = 100;
}

// [onClipEvent of sprite 748 in frame 76]
onClipEvent (construct)
{
    activePlayControl = "pause";
    backgroundStyle = "none";
    controllerPolicy = "on";
    horizontal = true;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 748 in frame 76]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this.associateDisplay(this._parent.QuizMov);
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 406 in frame 76]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 76]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1001 in frame 76]
onClipEvent (construct)
{
    searchKey = 244;
    Interaction_ID = "Interaction_01";
    Question = "Which of the following numbers are divisible by 3?";
    Distractor_Label1 = "A. True";
    Distractor_Label2 = "B. False";
    Distractor_Label3 = 18;
    Distractor_Label4 = 22;
    Distractor_Label5 = 33;
    Distractor_Label6 = 44;
    Distractor_Label7 = 55;
    Distractor_Label8 = 97;
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = false;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = false;
    Correct_Response8 = false;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on a Radio Button.";
    Correct_Feedback = "Yes, that is correct.";
    Incorrect_Feedback = "No, that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "That is incorrect. Try Again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    checkName1 = "Checkbox1";
    checkName2 = "Checkbox2";
    checkName3 = "Checkbox3";
    checkName4 = "Checkbox4";
    checkName5 = "Checkbox5";
    checkName6 = "Checkbox6";
    checkName7 = "Checkbox7";
    checkName8 = "Checkbox8";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 26165;
    Assets4 = "Radio1";
    Assets5 = "Radio2";
    Assets6 = "radioGroup";
    Correct_Response = true;
}

// [onClipEvent of sprite 406 in frame 76]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 76]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 425 in frame 76]
onClipEvent (construct)
{
    aspectRatio = false;
    autoPlay = false;
    autoSize = false;
    contentPath = "";
    fps = "ms";
    mediaType = "MP3";
    totalTime = 0;
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 1007 in frame 78]
onClipEvent (construct)
{
    searchKey = 162;
    Interaction_ID = "Interaction_02";
    Question = "What animal has black and white stripes?";
    Response1 = "Zebra";
    Response2 = "zebra";
    Response3 = "ZEBRA";
    Response_Value1 = false;
    Response_Value2 = false;
    Response_Value3 = false;
    Other_Responses = false;
    Case_Sensitive = false;
    Exact_Match = false;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Fill in the blank Text Field.";
    Correct_Feedback = "Yes that is correct.";
    Incorrect_Feedback = "No that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "No that is incorrect. Try Again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "UserEntry";
    Assets4 = "Template_ControlButton";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
}

// [onClipEvent of sprite 192 in frame 78]
onClipEvent (construct)
{
    editable = true;
    password = false;
    text = "";
    maxChars = null;
    restrict = "";
    enabled = true;
    visible = true;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 192 in frame 78]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this.tabIndex = 0;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 192 in frame 78]
onClipEvent (load)
{
    function __f_change(eventObj)
    {
        if (this.text != "")
        {
            _parent.text_entered = true;
        } // end if
    } // End of the function
    this.addEventListener("change", __f_change);
}

// [onClipEvent of sprite 192 in frame 78]
onClipEvent (load)
{
    function __f_enter(eventObj)
    {
        if (_parent.text_entered)
        {
            _parent.Q_Component.onFBButton();
        } // end if
    } // End of the function
    this.addEventListener("enter", __f_enter);
}

// [onClipEvent of sprite 406 in frame 81]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 81]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1037 in frame 81]
onClipEvent (construct)
{
    searchKey = 231;
    Interaction_ID = "Interaction_01";
    Question = "Move the items to the correct position.";
    Snap_To_Start = true;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Press on an object to drag it.";
    Correct_Feedback = "Yes that is correct.";
    Incorrect_Feedback = "No that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "No that is incorrect. Try again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    Assets4 = "Template_ResetButton";
    dragName1 = "ot_Drag1";
    dragName2 = "ot_Drag2";
    dragName3 = "ot_Drag3";
    dragName4 = "ot_Drag4";
    dragName5 = "ot_Drag5";
    dragName6 = "ot_Drag6";
    dragName7 = "ot_Drag7";
    dragName8 = "ot_Drag8";
    dragName9 = "";
    targetName1 = "ot_Target1";
    targetName2 = "ot_Target2";
    targetName3 = "ot_Target3";
    targetName4 = "ot_Target4";
    targetName5 = "ot_Target5";
    targetName6 = "ot_Target6";
    targetName7 = "ot_Target7";
    targetName8 = "ot_Target8";
    targetName9 = "";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 113986;
}

// [onClipEvent of sprite 406 in frame 84]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 84]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1037 in frame 84]
onClipEvent (construct)
{
    searchKey = 231;
    Interaction_ID = "Interaction_01";
    Question = "Move the items to the correct position.";
    Snap_To_Start = true;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Press on an object to drag it.";
    Correct_Feedback = "Yes that is correct.";
    Incorrect_Feedback = "No that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "No that is incorrect. Try again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    Assets4 = "Template_ResetButton";
    dragName1 = "oi_Drag1";
    dragName2 = "oi_Drag2";
    dragName3 = "oi_Drag3";
    dragName4 = "oi_Drag4";
    dragName5 = "oi_Drag5";
    dragName6 = "oi_Drag6";
    dragName7 = "oi_Drag7";
    dragName8 = "oi_Drag8";
    dragName9 = "";
    targetName1 = "oi_Target1";
    targetName2 = "oi_Target2";
    targetName3 = "oi_Target3";
    targetName4 = "oi_Target4";
    targetName5 = "oi_Target5";
    targetName6 = "oi_Target6";
    targetName7 = "oi_Target7";
    targetName8 = "oi_Target8";
    targetName9 = "";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 60080;
}

// [onClipEvent of sprite 406 in frame 88]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 88]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1070 in frame 88]
onClipEvent (construct)
{
    searchKey = 231;
    Interaction_ID = "Interaction_01";
    Question = "Move the items to the correct position.";
    Snap_To_Start = true;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Press on an object to drag it.";
    Correct_Feedback = "Yes that is correct.";
    Incorrect_Feedback = "No that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "No that is incorrect. Try again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    Assets4 = "Template_ResetButton";
    dragName1 = "gt_Drag1";
    dragName2 = "gt_Drag2";
    dragName3 = "gt_Drag3";
    dragName4 = "gt_Drag4";
    dragName5 = "gt_Drag5";
    dragName6 = "gt_Drag6";
    dragName7 = "gt_Drag7";
    dragName8 = "gt_Drag8";
    dragName9 = "";
    targetName1 = "gt_Target1";
    targetName2 = "gt_Target2";
    targetName3 = "gt_Target3";
    targetName4 = "gt_Target4";
    targetName5 = "gt_Target5";
    targetName6 = "gt_Target6";
    targetName7 = "gt_Target7";
    targetName8 = "gt_Target8";
    targetName9 = "";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 113986;
}

// [onClipEvent of sprite 406 in frame 91]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 91]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1070 in frame 91]
onClipEvent (construct)
{
    searchKey = 231;
    Interaction_ID = "Interaction_01";
    Question = "Move the items to the correct position.";
    Snap_To_Start = true;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Press on an object to drag it.";
    Correct_Feedback = "Yes that is correct.";
    Incorrect_Feedback = "No that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "No that is incorrect. Try again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    Assets4 = "Template_ResetButton";
    dragName1 = "gi_Drag1";
    dragName2 = "gi_Drag2";
    dragName3 = "gi_Drag3";
    dragName4 = "gi_Drag4";
    dragName5 = "gi_Drag5";
    dragName6 = "gi_Drag6";
    dragName7 = "gi_Drag7";
    dragName8 = "gi_Drag8";
    dragName9 = "";
    targetName1 = "gi_Target1";
    targetName2 = "gi_Target2";
    targetName3 = "gi_Target3";
    targetName4 = "gi_Target4";
    targetName5 = "gi_Target5";
    targetName6 = "gi_Target6";
    targetName7 = "gi_Target7";
    targetName8 = "gi_Target8";
    targetName9 = "";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 60080;
}

// [onClipEvent of sprite 406 in frame 95]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 95]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1091 in frame 95]
onClipEvent (construct)
{
    searchKey = 231;
    Interaction_ID = "Interaction_01";
    Question = "Move the items to the correct position.";
    Snap_To_Start = true;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Press on an object to drag it.";
    Correct_Feedback = "Yes that is correct.";
    Incorrect_Feedback = "No that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "No that is incorrect. Try again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    Assets4 = "Template_ResetButton";
    dragName1 = "mt_Drag1";
    dragName2 = "mt_Drag2";
    dragName3 = "mt_Drag3";
    dragName4 = "mt_Drag4";
    dragName5 = "mt_Drag5";
    dragName6 = "mt_Drag6";
    dragName7 = "mt_Drag7";
    dragName8 = "mt_Drag8";
    dragName9 = "";
    targetName1 = "mt_Target1";
    targetName2 = "mt_Target2";
    targetName3 = "mt_Target3";
    targetName4 = "mt_Target4";
    targetName5 = "mt_Target5";
    targetName6 = "mt_Target6";
    targetName7 = "mt_Target7";
    targetName8 = "mt_Target8";
    targetName9 = "";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 113986;
}

// [onClipEvent of sprite 406 in frame 98]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 98]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1091 in frame 98]
onClipEvent (construct)
{
    searchKey = 231;
    Interaction_ID = "Interaction_01";
    Question = "Move the items to the correct position.";
    Snap_To_Start = true;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Press on an object to drag it.";
    Correct_Feedback = "Yes that is correct.";
    Incorrect_Feedback = "No that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "No that is incorrect. Try again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    Assets4 = "Template_ResetButton";
    dragName1 = "mi_Drag1";
    dragName2 = "mi_Drag2";
    dragName3 = "mi_Drag3";
    dragName4 = "mi_Drag4";
    dragName5 = "mi_Drag5";
    dragName6 = "mi_Drag6";
    dragName7 = "mi_Drag7";
    dragName8 = "mi_Drag8";
    dragName9 = "";
    targetName1 = "mi_Target1";
    targetName2 = "mi_Target2";
    targetName3 = "mi_Target3";
    targetName4 = "mi_Target4";
    targetName5 = "mi_Target5";
    targetName6 = "mi_Target6";
    targetName7 = "mi_Target7";
    targetName8 = "mi_Target8";
    targetName9 = "";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 60080;
}

// [onClipEvent of sprite 406 in frame 101]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 101]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1116 in frame 101]
onClipEvent (construct)
{
    searchKey = 198;
    Interaction_ID = "Interaction_04";
    Question = "Object number 4 is the correct answer";
    UPalpha = 25;
    DNalpha = 100;
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on an object to select it.";
    Correct_Feedback = "Yes that is correct.";
    Incorrect_Feedback = "No that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "No that is incorrect. Try again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    Assets4 = "Template_ResetButton";
    hsName1 = "HotSpot1";
    hsName2 = "HotSpot2";
    hsName3 = "HotSpot3";
    hsName4 = "HotSpot4";
    hsName5 = "HotSpot5";
    hsName6 = "HotSpot6";
    hsName7 = "HotSpot7";
    hsName8 = "HotSpot8";
    hsName9 = "";
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = true;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = "";
    Correct_Response8 = "";
    Correct_Response9 = "";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 24684;
}

// [onClipEvent of sprite 406 in frame 103]
onClipEvent (construct)
{
    data = "";
    groupName = "radioGroup";
    label = "Radio Button";
    labelPlacement = "right";
    selected = false;
}

// [onClipEvent of sprite 406 in frame 103]
onClipEvent (load)
{
    function __f_load(eventObj)
    {
        this._visible = false;
        this.setFocus();
    } // End of the function
    this.addEventListener("load", __f_load);
}

// [onClipEvent of sprite 1128 in frame 103]
onClipEvent (construct)
{
    searchKey = 203;
    Interaction_ID = "Interaction_03";
    Question = "Object number 4 is the correct answer";
    Feedback = true;
    Num_Of_Tries = 1;
    Initial_Feedback = "Click on an object to select it.";
    Correct_Feedback = "Yes that is correct.";
    Incorrect_Feedback = "No that is incorrect.";
    Evaluate_Feedback = "Click on the Check Answer button.";
    Tries_Feedback = "No that is incorrect. Try again.";
    Tracking = false;
    Objective_ID = "";
    Weighting = 1;
    Navigation = 1;
    Go_To_Action = false;
    Go_To_Label = "nQuestion";
    Assets1 = "Template_Question";
    Assets2 = "Template_Feedback";
    Assets3 = "Template_ControlButton";
    Assets4 = "Template_ResetButton";
    hoName1 = "HotObject1";
    hoName2 = "HotObject2";
    hoName3 = "HotObject3";
    hoName4 = "HotObject4";
    hoName5 = "HotObject5";
    hoName6 = "HotObject6";
    hoName7 = "HotObject7";
    hoName8 = "HotObject8";
    hoName9 = "";
    Correct_Response1 = false;
    Correct_Response2 = false;
    Correct_Response3 = false;
    Correct_Response4 = false;
    Correct_Response5 = false;
    Correct_Response6 = false;
    Correct_Response7 = false;
    Correct_Response8 = false;
    Correct_Response9 = "";
    ButtonLabels1 = "Check Answer";
    ButtonLabels2 = "Submit";
    ButtonLabels3 = "Next Question";
    ButtonLabels4 = "Reset";
    _searchKey = 29282;
}

// [onClipEvent of sprite 35 in frame 105]
onClipEvent (construct)
{
    icon = "";
    label = "Control Button";
    labelPlacement = "right";
    selected = false;
    toggle = false;
    enabled = true;
    visible = false;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 35 in frame 105]
onClipEvent (load)
{
    function __f_click(eventObj)
    {
        _root.nextload();
    } // End of the function
    this.addEventListener("click", __f_click);
}

// [onClipEvent of sprite 35 in frame 105]
onClipEvent (construct)
{
    icon = "";
    label = "Control Button";
    labelPlacement = "right";
    selected = false;
    toggle = false;
    enabled = true;
    visible = false;
    minHeight = 0;
    minWidth = 0;
}

// [onClipEvent of sprite 35 in frame 105]
onClipEvent (load)
{
    function __f_click(eventObj)
    {
        if (_parent.details._visible)
        {
            _parent.details.gotoAndPlay("hide");
            this.label = "Show Detailed Results";
        }
        else
        {
            _parent.details.gotoAndPlay("show");
            this.label = "Show Basic Results";
        } // end else if
    } // End of the function
    this.addEventListener("click", __f_click);
}

// [Action in Frame 1]
var curtColor = 1114112;
var demoVer = false;
var brandLoc = "lpi_brand/";

// [Action in Frame 2]
function show_load_status()
{
    load_num = load_num + 10;
    load_status.load_perc.text = load_num + "%";
    if (load_num == 100)
    {
        load_status.gotoAndPlay("loaded");
    } // end if
} // End of the function
function print_notes()
{
    var _loc2 = 0;
    var _loc5 = new PrintJob();
    ptxt.print_text.text = notepad.np_text.text;
    ptxt.print_text.scroll = 1;
    if (_loc5.start())
    {
        if (ptxt.print_text.maxscroll > 7)
        {
            var _loc6 = Math.ceil(ptxt.print_text.maxscroll / 54);
            ptxt.page_num.text = "- " + (_loc2 + 1) + " -";
            if (_loc5.addPage(ptxt, {xMin: 0, xMax: 625, yMin: 0, yMax: 875}, null, 1))
            {
                ++_loc2;
                
            } // end if
            for (var _loc3 = 0; _loc3 < _loc6; ++_loc3)
            {
                if (_loc3 + 1 != _loc6)
                {
                    ptxt.page_num.text = "- " + (_loc2 + 1) + " -";
                    ptxt.print_text.scroll = ptxt.print_text.scroll + 54;
                    if (_loc5.addPage(ptxt, {xMin: 0, xMax: 625, yMin: 0, yMax: 875}, null, 1))
                    {
                        ++_loc2;
                    }
                    else
                    {
                        break;
                    } // end else if
                    continue;
                } // end if
                var _loc4 = 55 - (ptxt.print_text.maxscroll - ptxt.print_text.scroll);
                for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
                {
                    ptxt.print_text.text = ptxt.print_text.text + "\r";
                } // end of for
                ptxt.page_num.text = "- " + (_loc2 + 1) + " -";
                ptxt.print_text.scroll = ptxt.print_text.maxscroll;
                if (_loc5.addPage(ptxt, {xMin: 0, xMax: 625, yMin: 0, yMax: 875}, null, 1))
                {
                    ++_loc2;
                    continue;
                } // end if
                break;
            } // end of for
        }
        else
        {
            ptxt.page_num.text = "- " + (_loc2 + 1) + " -";
            if (_loc5.addPage(ptxt, {xMin: 0, xMax: 625, yMin: 0, yMax: 875}, null, 1))
            {
                ++_loc2;
            } // end if
        } // end if
    } // end else if
    if (_loc2 > 0)
    {
        _loc5.send();
    } // end if
    false;
} // End of the function
function store_outline()
{
    var _loc3 = "";
    var _loc4 = 0;
    for (outs in outlines)
    {
        if (_loc4 != 0)
        {
            _loc3 = _loc3 + "-";
        } // end if
        _loc3 = _loc3 + (outs + "," + _global.trackObj.data[outs]);
        ++_loc4;
    } // end of for...in
    if (_root.lms == "TRUE")
    {
        loadVariablesNum("/bullets.asp?Bullets=" + _loc3 + "&CourseID=" + _root.CourseID, 0);
    } // end if
} // End of the function
function show_out_bullet(bull_subj, bull_topic, bull_out)
{
    with (out_obj["w_" + bull_out]["out" + bull_subj + "-" + bull_topic])
    {
        oDot.drawOutDot(outDotProp[0], outDotProp[1]);
        oDot._y = oText.getTextFormat().size / 2 + 2;
        oDot._visible = true;
    } // End of with
    if (_root.lms == "TRUE")
    {
        store_outline();
    } // end if
} // End of the function
function show_toc_bullet(bull_subj)
{
    if (bull_subj > 0)
    {
        with (toc_mc["toc_c" + bull_subj])
        {
            dot.drawTocDot(tocDotProp[0], tocDotProp[1]);
            dot._visible = true;
        } // End of with
        if (_root.lms == "TRUE")
        {
            loadVariablesNum("/bullets.asp?tocBullets=" + _global.trackObj.data.toc + "&CourseID=" + _root.CourseID, 0);
        } // end if
    } // end if
} // End of the function
function storeBML()
{
    loadVariablesNum("/bookmarks.asp?Bookmarks=" + _root.condBML + "&CourseID=" + _root.CourseID, 0);
} // End of the function
function clearALL(o_dat, t_dat)
{
    loadVariablesNum("/bookmarks.asp?Bookmarks=&CourseID=" + _root.CourseID, 0);
    loadVariablesNum("/bullets.asp?tocBullets=" + t_dat + "&CourseID=" + _root.CourseID, 0);
    loadVariablesNum("/bullets.asp?Bullets=" + o_dat + "&CourseID=" + _root.CourseID, 0);
} // End of the function
function show_notepad()
{
    notepad._x = Number(_global.trackObj.data.np_pos[0]);
    notepad._y = Number(_global.trackObj.data.np_pos[1]);
    notepad._visible = true;
    notepad.np_text.setNewTextFormat(userNote);
    notes_btn.gotoAndStop("disable");
} // End of the function
function store_notes()
{
    _global.trackObj.data.notes = notepad.np_text.text;
} // End of the function
function close_notepad()
{
    notepad._visible = false;
    notepad._x = 1600;
    notepad._y = 1600;
    _global.trackObj.data.notes = notepad.np_text.text;
    notes_btn.gotoAndStop("enable");
} // End of the function
function return_to_prev()
{
    if (curr_template == "flashpaper")
    {
        if (start_point[0] == 0 || viewing_page)
        {
            goto_return_point();
        }
        else
        {
            play_topic(0, curr_o_num);
        } // end else if
    }
    else if (curr_template == "outlines")
    {
        goto_return_point();
    }
    else
    {
        play_topic(0, curr_o_num);
    } // end else if
} // End of the function
function set_return_point(play_time)
{
    return_point = new Array();
    return_point[0] = curr_subj;
    return_point[1] = curr_topic;
    return_point[2] = curr_clip;
    return_point[3] = curr_o_num;
    return_point[4] = curr_item;
    return_point[5] = start_point[0];
    return_point[6] = start_point[1];
    if (FlashPaperHolder.getCurrentPage() != undefined)
    {
        return_point[7] = FlashPaperHolder.getCurrentPage();
        return_point[8] = FlashPaperHolder.getCurrentZoom();
    }
    else
    {
        return_point[7] = play_time;
    } // end else if
    return_history.push(return_point);
} // End of the function
function goto_return_point()
{
    if (viewing_page)
    {
        viewing_page = false;
    } // end if
    return_point = new Array();
    return_point = return_history[return_history.length - 1];
    return_history.splice(return_history.length - 1, 1);
    toc_mc["toc_s" + curr_o_num].gotoAndStop("enable");
    if (curr_o_num != return_point[3])
    {
        curr_o_num = return_point[3];
        set_curr_outline(toc_arr.Supp[curr_o_num].Obj, curr_o_num);
    } // end if
    curr_clip = return_point[2];
    start_point[0] = return_point[5];
    start_point[1] = return_point[6];
    start_point[2] = Number(outlines[curr_outline].Subject[start_point[0]].Topic[start_point[1]].indent);
    if (return_point.length == 9)
    {
        zoom_pref = return_point[8];
        marked_page = return_point[7];
    }
    else
    {
        resume_time = return_point[7];
    } // end else if
    find_place(start_point[0], start_point[1]);
    curr_item = return_point[4];
    play_topic(return_point[0], return_point[1]);
} // End of the function
function check_sec_complete(check_sec)
{
    for (var _loc2 = 0; _loc2 < _global.trackObj.data[curr_outline][check_sec].length; ++_loc2)
    {
        if (_global.trackObj.data[curr_outline][check_sec][_loc2] == 0)
        {
            return (false);
            break;
            continue;
        } // end if
        if (_loc2 + 1 == _global.trackObj.data[curr_outline][check_sec].length)
        {
            return (true);
        } // end if
    } // end of for
} // End of the function
function find_main_title_end(orig_txt, out_txt)
{
    var _loc1 = "";
    var _loc2 = -1;
    if (orig_txt.indexOf("~") >= 0)
    {
        _loc1 = orig_txt.substring(0, orig_txt.indexOf("~") - 1);
        _loc2 = out_txt.indexOf(_loc1);
        return (_loc2 + _loc1.length);
    }
    else
    {
        return (-1);
    } // end else if
} // End of the function
function return_main_title(title_txt)
{
    if (title_txt.indexOf("~") >= 0)
    {
        return (title_txt.substring(0, title_txt.indexOf("~") - 1));
    }
    else
    {
        return (title_txt);
    } // end else if
} // End of the function
function return_sub_title(title_txt)
{
    if (title_txt.indexOf("~") >= 0)
    {
        return (title_txt.substr(title_txt.indexOf("~") + 1));
    }
    else
    {
        return ("");
    } // end else if
} // End of the function
function get_message()
{
    switch (curr_template)
    {
        case "vid_part":
        {
            if (selected_part != 0)
            {
                if (array_list[curr_index].p_msg2 == "" || array_list[curr_index].p_msg2 == undefined)
                {
                    if (partP_msg2 == "" || partP_msg2 == undefined)
                    {
                        return (regP_msg);
                    }
                    else
                    {
                        return (partP_msg2);
                    } // end else if
                }
                else
                {
                    return (array_list[curr_index].p_msg2);
                } // end else if
            }
            else if (array_list[curr_index].p_msg1 == "" || array_list[curr_index].p_msg1 == undefined)
            {
                if (partP_msg1 == "" || partP_msg1 == undefined)
                {
                    return (regP_msg);
                }
                else
                {
                    return (partP_msg1);
                } // end else if
            }
            else
            {
                return (array_list[curr_index].p_msg1);
            } // end else if
            break;
        } 
        case "vid_agree":
        {
            if (selected_scene != 0)
            {
                if (!responded)
                {
                    if (array_list[curr_index].p_msg2 == "" || array_list[curr_index].p_msg2 == undefined)
                    {
                        if (scenP_msg2 == "" || scenP_msg2 == undefined)
                        {
                            return (regP_msg);
                        }
                        else
                        {
                            return (scenP_msg2);
                        } // end else if
                    }
                    else
                    {
                        return (array_list[curr_index].p_msg2);
                    } // end else if
                }
                else if (array_list[curr_index].p_msg3 == "" || array_list[curr_index].p_msg3 == undefined)
                {
                    if (scenP_msg3 == "" || scenP_msg3 == undefined)
                    {
                        return (regP_msg);
                    }
                    else
                    {
                        return (scenP_msg3);
                    } // end else if
                }
                else
                {
                    return (array_list[curr_index].p_msg3);
                } // end else if
            }
            else if (array_list[curr_index].p_msg1 == "" || array_list[curr_index].p_msg1 == undefined)
            {
                if (scenP_msg1 == "" || scenP_msg1 == undefined)
                {
                    return (regP_msg);
                }
                else
                {
                    return (scenP_msg1);
                } // end else if
            }
            else
            {
                return (array_list[curr_index].p_msg1);
            } // end else if
            break;
        } 
        default:
        {
            if (array_list[curr_index].p_msg == "" || array_list[curr_index].p_msg == undefined)
            {
                return (regP_msg);
                break;
            } // end if
            return (array_list[curr_index].p_msg);
        } 
    } // End of switch
} // End of the function
function send_status(f_name, v_num)
{
    if (_root.lms == "TRUE" && _root.rEnd == 1)
    {
        loadVariablesNum("/status.asp?VidFile=" + f_name + "&CourseID=" + _root.CourseID + "&VidIndex=" + v_num, 0);
    } // end if
} // End of the function
function nextload()
{
    if (part_vids.length > 1 && part_vid_count < part_vids.length)
    {
        play_otherVid();
    }
    else
    {
        HeadMov.removeAllCuePoints();
        if (curr_clip + 1 < outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].range.length)
        {
            ++curr_clip;
            ++curr_item;
            change_title = false;
            if (demoVer)
            {
                if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
                {
                    send_status("PLAY", curr_index);
                    play_topic(curr_subj, curr_topic);
                }
                else
                {
                    send_status("END", curr_index);
                    play_topic(0, curr_o_num);
                } // end else if
            }
            else
            {
                send_status("PLAY", curr_index);
                play_topic(curr_subj, curr_topic);
            } // end else if
        }
        else
        {
            change_title = true;
            switch (play_style)
            {
                case "s":
                {
                    if (start_point[1] == 0)
                    {
                        if (curr_topic + 1 < outlines[curr_outline].Subject[curr_subj].Topic.length)
                        {
                            ++curr_topic;
                            curr_clip = 0;
                            ++curr_item;
                            if (demoVer)
                            {
                                if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
                                {
                                    send_status("PLAY", curr_index);
                                    play_topic(curr_subj, curr_topic);
                                }
                                else
                                {
                                    send_status("END", curr_index);
                                    play_topic(0, curr_o_num);
                                } // end else if
                            }
                            else
                            {
                                send_status("PLAY", curr_index);
                                play_topic(curr_subj, curr_topic);
                            } // end else if
                        }
                        else
                        {
                            send_status("END", curr_index);
                            play_topic(0, curr_o_num);
                        } // end else if
                    }
                    else
                    {
                        send_status("END", curr_index);
                        play_topic(0, curr_o_num);
                    } // end else if
                    break;
                } 
                case "l":
                {
                    if (outlines[curr_outline].Subject[curr_subj].Topic[start_point[1]].indent < outlines[curr_outline].Subject[curr_subj].Topic[curr_topic + 1].indent)
                    {
                        ++curr_topic;
                        curr_clip = 0;
                        ++curr_item;
                        if (demoVer)
                        {
                            if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
                            {
                                send_status("PLAY", curr_index);
                                play_topic(curr_subj, curr_topic);
                            }
                            else
                            {
                                send_status("END", curr_index);
                                play_topic(0, curr_o_num);
                            } // end else if
                        }
                        else
                        {
                            send_status("PLAY", curr_index);
                            play_topic(curr_subj, curr_topic);
                        } // end else if
                    }
                    else
                    {
                        send_status("END", curr_index);
                        play_topic(0, curr_o_num);
                    } // end else if
                    break;
                } 
                case "c":
                {
                    if (curr_topic + 1 < outlines[curr_outline].Subject[curr_subj].Topic.length)
                    {
                        ++curr_topic;
                        curr_clip = 0;
                        ++curr_item;
                        if (demoVer)
                        {
                            if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
                            {
                                send_status("PLAY", curr_index);
                                play_topic(curr_subj, curr_topic);
                            }
                            else
                            {
                                send_status("END", curr_index);
                                play_topic(0, curr_o_num);
                            } // end else if
                        }
                        else
                        {
                            send_status("PLAY", curr_index);
                            play_topic(curr_subj, curr_topic);
                        } // end else if
                    }
                    else if (curr_subj + 1 < outlines[curr_outline].Subject.length)
                    {
                        toc_mc["toc_c" + curr_subj].gotoAndStop("enable");
                        ++curr_subj;
                        curr_topic = 0;
                        curr_clip = 0;
                        ++curr_item;
                        if (demoVer)
                        {
                            if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
                            {
                                send_status("PLAY", curr_index);
                                play_topic(curr_subj, curr_topic);
                            }
                            else
                            {
                                send_status("END", curr_index);
                                play_topic(0, curr_o_num);
                            } // end else if
                        }
                        else
                        {
                            send_status("PLAY", curr_index);
                            play_topic(curr_subj, curr_topic);
                        } // end else if
                    }
                    else
                    {
                        send_status("END", curr_index);
                        play_topic(0, curr_o_num);
                    } // end else if
                    break;
                } 
            } // End of switch
        } // end else if
    } // end else if
} // End of the function
function prevload()
{
    HeadMov.removeAllCuePoints();
    if (curr_clip - 1 >= 0)
    {
        --curr_clip;
        --curr_item;
        change_title = false;
        if (demoVer)
        {
            if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
            {
                play_topic(curr_subj, curr_topic);
            }
            else
            {
                play_topic(0, curr_o_num);
            } // end else if
        }
        else
        {
            play_topic(curr_subj, curr_topic);
        } // end else if
    }
    else
    {
        change_title = true;
        switch (play_style)
        {
            case "s":
            {
                if (start_point[1] == 0)
                {
                    if (curr_topic - 1 >= 0)
                    {
                        --curr_topic;
                        curr_clip = outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].range.length - 1;
                        --curr_item;
                        if (demoVer)
                        {
                            if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
                            {
                                play_topic(curr_subj, curr_topic);
                            }
                            else
                            {
                                play_topic(0, curr_o_num);
                            } // end else if
                        }
                        else
                        {
                            play_topic(curr_subj, curr_topic);
                        } // end else if
                    }
                    else
                    {
                        play_topic(0, curr_o_num);
                    } // end else if
                }
                else
                {
                    play_topic(0, curr_o_num);
                } // end else if
                break;
            } 
            case "l":
            {
                if (curr_topic - 1 >= start_point[1])
                {
                    --curr_topic;
                    curr_clip = outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].range.length - 1;
                    --curr_item;
                    if (demoVer)
                    {
                        if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
                        {
                            play_topic(curr_subj, curr_topic);
                        }
                        else
                        {
                            play_topic(0, curr_o_num);
                        } // end else if
                    }
                    else
                    {
                        play_topic(curr_subj, curr_topic);
                    } // end else if
                }
                else
                {
                    play_topic(0, curr_o_num);
                } // end else if
                break;
            } 
            case "c":
            {
                if (curr_topic - 1 >= 0)
                {
                    --curr_topic;
                    curr_clip = outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].range.length - 1;
                    --curr_item;
                    if (demoVer)
                    {
                        if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
                        {
                            play_topic(curr_subj, curr_topic);
                        }
                        else
                        {
                            play_topic(0, curr_o_num);
                        } // end else if
                    }
                    else
                    {
                        play_topic(curr_subj, curr_topic);
                    } // end else if
                }
                else if (curr_subj - 1 >= 0)
                {
                    toc_mc["toc_c" + curr_subj].gotoAndStop("enable");
                    --curr_subj;
                    curr_topic = outlines[curr_outline].Subject[curr_subj].Topic.length - 1;
                    curr_clip = outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].range.length - 1;
                    --curr_item;
                    if (demoVer)
                    {
                        if (outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].demo.substr(0, 1).toLowerCase() == "y")
                        {
                            play_topic(curr_subj, curr_topic);
                        }
                        else
                        {
                            play_topic(0, curr_o_num);
                        } // end else if
                    }
                    else
                    {
                        play_topic(curr_subj, curr_topic);
                    } // end else if
                }
                else
                {
                    play_topic(0, curr_o_num);
                } // end else if
                break;
            } 
        } // End of switch
    } // end else if
} // End of the function
function set_curr_outline(outline_name, o_num)
{
    toc_mc["toc_s" + curr_o_num].gotoAndStop("enable");
    curr_outline = outline_name;
    curr_o_num = o_num;
    play_style = outlines[curr_outline].p_style.substr(0, 1).toLowerCase();
} // End of the function
function clear_history()
{
    if (_root.lms == "TRUE")
    {
        _root.clearALL(_global.trackObj.data.out_e, String(_global.trackObj.data.toc_e));
    } // end if
    _root.titleInd.text = "";
    notepad._visible = false;
    notepad.np_text.text = "";
    notes_btn.gotoAndStop("enable");
    _root.bookM_goto.gotoAndStop("disable");
    _root.bookM_del.gotoAndStop("disable");
    _root.bookM_add.gotoAndStop("disable");
    _root.bookM_list.removeAll();
    _root.bookM_list.addItemAt(0, _root.bookM_default);
    _root.bookM_list.selectedIndex = 0;
    _root.out_obj.wOut._visible = false;
    outline_done = false;
    toc_done = false;
    _global.trackObj.clear();
    for (var _loc3 = 0; _loc3 < toc_arr.Supp.length; ++_loc3)
    {
        toc_mc["toc_s" + _loc3].removeMovieClip();
    } // end of for
    _root.historyCleared = true;
    _root.gotoAndPlay("prestart");
} // End of the function
function clear_curr_topic(template_type, clear_subj, clear_topic)
{
    pause_media = false;
    part_vids = new Array();
    TestID = "";
    resend_data = new Array();
    switch (template_type)
    {
        case "outlines":
        {
            out_obj["w_" + toc_arr.Supp[curr_topic].Obj]._x = out_hide_x;
            out_obj["w_" + toc_arr.Supp[curr_topic].Obj]._visible = false;
            break;
        } 
        case "flashpaper":
        {
            if (curr_outline == main_out)
            {
                if (return_btn._visible)
                {
                    return_btn._visible = false;
                } // end if
            } // end if
            HeadMov.removeAllCuePoints();
            no_cues = true;
            HeadMov.stop();
            HeadMov.clear();
            break;
        } 
        default:
        {
            HeadMov.removeAllCuePoints();
            no_cues = true;
            HeadMov.stop();
            HeadMov.clear();
            _root.Slideshow.unloadMovie();
            _root.support_text.sub_text.scroll = 1;
            _root.user_pause = false;
        } 
    } // End of switch
    if (clear_subj == 0)
    {
        toc_mc["toc_s" + clear_topic].gotoAndStop("enable");
    }
    else
    {
        toc_mc["toc_c" + clear_subj].gotoAndStop("enable");
    } // end else if
} // End of the function
function find_place(find_subj, find_topic)
{
    switch (play_style)
    {
        case "s":
        {
            curr_item = 1;
            if (find_topic == 0)
            {
                total_items = outlines[curr_outline].Subject[find_subj].items;
            }
            else
            {
                total_items = outlines[curr_outline].Subject[find_subj].Topic[find_topic].range.length;
            } // end else if
            break;
        } 
        case "l":
        {
            curr_item = 1;
            if (find_topic == 0)
            {
                total_items = outlines[curr_outline].Subject[find_subj].items;
            }
            else if (outlines[curr_outline].Subject[find_subj].Topic[find_topic].indent < outlines[curr_outline].Subject[find_subj].Topic[find_topic + 1].indent)
            {
                total_items = outlines[curr_outline].Subject[find_subj].Topic[find_topic].range.length;
                for (var _loc5 = find_topic + 1; outlines[curr_outline].Subject[find_subj].Topic[find_topic].indent < outlines[curr_outline].Subject[find_subj].Topic[_loc5].indent; ++_loc5)
                {
                    total_items = total_items + outlines[curr_outline].Subject[find_subj].Topic[_loc5].range.length;
                } // end of for
            }
            else
            {
                total_items = outlines[curr_outline].Subject[find_subj].Topic[find_topic].range.length;
            } // end else if
            break;
        } 
        case "c":
        {
            total_items = 0;
            for (var _loc2 = 1; _loc2 < outlines[curr_outline].Subject.length; ++_loc2)
            {
                if (_loc2 == find_subj)
                {
                    curr_item = total_items + 1;
                    for (var _loc1 = 0; _loc1 < find_topic; ++_loc1)
                    {
                        curr_item = curr_item + outlines[curr_outline].Subject[_loc2].Topic[_loc1].range.length;
                    } // end of for
                } // end if
                total_items = total_items + outlines[curr_outline].Subject[_loc2].items;
            } // end of for
            break;
        } 
    } // End of switch
} // End of the function
function change_subtitle()
{
    var _loc2 = outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].subtitle[0];
    var _loc3 = outlines[curr_outline].Subject[curr_subj].Topic[curr_topic].subtitle[1];
    if (_loc3 != "")
    {
        if (_root.lms == "TRUE")
        {
            _root.titleInd.text = _loc2 + subTSpacer + _loc3;
        }
        else
        {
            _root.titleInd.text = _loc2 + "\r" + _loc3;
        } // end else if
        _root.titleInd.setTextFormat(subTtl);
        _root.titleInd.setTextFormat(_loc2.length, _root.titleInd.text.length, subSubTtl);
    }
    else
    {
        _root.titleInd.text = _loc2;
        _root.titleInd.setTextFormat(subTtl);
    } // end else if
    change_title = false;
} // End of the function
function play_topic(sel_subj, sel_topic)
{
    var _loc5 = false;
    clear_curr_topic(curr_template, curr_subj, curr_topic);
    curr_subj = sel_subj;
    curr_topic = sel_topic;
    if (notes_btn._currentframe == 2 && notepad._x != _global.trackObj.data.np_pos[0] && notepad._y != _global.trackObj.data.np_pos[0])
    {
        notes_btn.gotoAndStop("enable");
    } // end if
    if (sel_subj == 0)
    {
        if (curr_o_num != 0)
        {
            toc_mc["toc_s" + curr_o_num].gotoAndStop("enable");
        } // end if
        if (toc_arr.Supp[sel_topic].Obj.toLowerCase().indexOf(".swf") >= 0)
        {
            curr_template = "flashpaper";
        }
        else
        {
            curr_template = "outlines";
        } // end else if
        _root.titleInd.text = toc_arr.Supp[sel_topic].Name;
        _root.titleInd.setTextFormat(subTtl);
        toc_mc["toc_s" + sel_topic].gotoAndStop("disable");
        gotoAndPlay(curr_template);
    }
    else
    {
        trace ("curr_clip = " + curr_clip);
        curr_index = outlines[curr_outline].Subject[sel_subj].Topic[sel_topic].range[curr_clip];
        if (curr_index >= array_list.length)
        {
            trace ("Error: The index " + curr_index + " is outside of the range of 0 to " + (array_list.length - 1));
        }
        else
        {
            curr_template = array_list[curr_index].template;
            if (curr_template != "quiz")
            {
                if (_global.trackObj.data[curr_outline][sel_subj][sel_topic] == 0)
                {
                    show_out_bullet(curr_subj, curr_topic, curr_outline);
                    _global.trackObj.data[curr_outline][sel_subj][sel_topic] = 1;
                    _loc5 = check_sec_complete(sel_subj);
                    if (curr_outline == "outline")
                    {
                        if (_loc5)
                        {
                            _global.trackObj.data.toc[curr_subj] = 1;
                            show_toc_bullet(curr_subj);
                        } // end if
                    } // end if
                    if (_loc5 && checkMark.toLowerCase().substr(0, 1) == "y")
                    {
                        _global.trackObj.data[curr_outline][sel_subj][0] = 2;
                        out_obj["w_" + curr_outline]["out" + sel_subj + "-0"].oDot.outDot_mc.removeMovieClip();
                        out_obj["w_" + curr_outline]["out" + sel_subj + "-0"].oDot.drawOutDot(outDotProp[0], outDotProp[1], "m");
                        store_outline();
                    } // end if
                } // end if
            } // end if
            if (change_title)
            {
                change_subtitle();
            } // end if
            if (curr_o_num == 0)
            {
                toc_mc["toc_c" + sel_subj].gotoAndStop("disable");
            }
            else
            {
                toc_mc["toc_s" + curr_o_num].gotoAndStop("disable");
            } // end else if
            if (array_list[curr_index].pause.substr(0, 1).toLowerCase() == "y")
            {
                pause_media = true;
            }
            else
            {
                pause_media = false;
            } // end else if
            gotoAndPlay(curr_template);
            if (curr_outline != main_out)
            {
                return_btn._visible = true;
            } // end if
            itemTrack.text = "Item " + curr_item + " of " + total_items;
            itemTrack.setTextFormat(clipProg);
        } // end else if
    } // end else if
} // End of the function
function doQuit()
{
    trace ("hit");
    fscommand("quit");
} // End of the function
function addBookmark()
{
    var _loc3 = Array();
    var _loc5 = 20;
    var _loc8 = String(Math.floor(HeadMov.playheadTime / 60));
    var _loc6 = String(60 * (HeadMov.playheadTime / 60 - Math.floor(HeadMov.playheadTime / 60)));
    var _loc4 = "";
    var _loc7 = "";
    if (curr_subj == 0)
    {
        _loc4 = toc_arr.Supp[curr_topic].Name;
    }
    else
    {
        _loc4 = out_obj["w_" + curr_outline]["out" + curr_subj + "-" + curr_topic].oText.text;
    } // end else if
    if (FlashPaperHolder.getCurrentPage() != undefined)
    {
        _loc3[1] = FlashPaperHolder.getCurrentPage();
        _loc3[2] = FlashPaperHolder.getCurrentZoom();
        _loc3[0] = (_loc4.length > _loc5 ? (_loc4.substr(0, _loc5) + "...") : (_loc4)) + " - p. " + _loc3[1] + " (" + _loc3[2] + "%)";
        _loc7 = _loc7 + String(_loc3[1] + "." + _loc3[2] + "-");
    }
    else
    {
        _loc3[0] = (_loc4.length > _loc5 ? (_loc4.substr(0, _loc5) + "...") : (_loc4 + " -")) + " " + _loc8 + ":" + (_loc6.indexOf(".") == 1 ? ("0" + _loc6.substr(0, 1)) : (_loc6.substr(0, 2)));
        trace ("HeadMov.contentPath = " + HeadMov.contentPath);
        trace ("HeadMov.contentPath isolated = " + HeadMov.contentPath.substring(HeadMov.contentPath.indexOf("/") + 1, HeadMov.contentPath.length - 4));
        trace ("array_list[" + curr_index + "][file] = " + array_list[curr_index].file);
        if (HeadMov.contentPath.substring(HeadMov.contentPath.indexOf("/") + 1, HeadMov.contentPath.length - 4) == array_list[curr_index].file)
        {
            _loc3[0] = (_loc4.length > _loc5 ? (_loc4.substr(0, _loc5) + "...") : (_loc4 + " -")) + " " + _loc8 + ":" + (_loc6.indexOf(".") == 1 ? ("0" + _loc6.substr(0, 1)) : (_loc6.substr(0, 2)));
            _loc3[2] = HeadMov.playheadTime;
        }
        else
        {
            _loc3[0] = (_loc4.length > _loc5 ? (_loc4.substr(0, _loc5) + "...") : (_loc4 + " -")) + " 0:00";
            _loc3[2] = 0;
        } // end else if
        _loc7 = _loc7 + String(_loc3[2] + "-");
    } // end else if
    _loc3[3] = curr_subj;
    _loc3[4] = curr_topic;
    _loc3[5] = curr_clip;
    _loc3[6] = curr_o_num;
    _loc3[7] = curr_item;
    _loc3[8] = start_point[0];
    _loc3[9] = start_point[1];
    _loc7 = _loc7 + String(_loc3[3] + "." + _loc3[4] + "." + _loc3[5] + "." + _loc3[6] + "." + _loc3[7] + "." + _loc3[8] + "." + _loc3[9]);
    bookM_goto.gotoAndStop("enable");
    bookM_del.gotoAndStop("enable");
    bookM_list.addItemAt(0, _loc3[0], _loc3);
    _root.condBML.addItemAt(0, _loc7, _loc3);
    _global.trackObj.data.bookM.splice(0, 0, _loc3);
    if (bookM_list.text == bookM_default)
    {
        bookM_list.removeItemAt(1);
        _global.trackObj.data.bookM = new Array();
        _global.trackObj.data.bookM.push(_loc3);
    }
    else
    {
        _global.trackObj.data.bookM.splice(0, _loc3);
    } // end else if
    bookM_list.selectedIndex = 0;
    if (_root.lms == "TRUE")
    {
        _root.storeBML();
    } // end if
} // End of the function
function gotoBookmark()
{
    var _loc2 = bookM_list.selectedIndex;
    toc_mc["toc_s" + curr_o_num].gotoAndStop("enable");
    if (curr_o_num != _global.trackObj.data.bookM[_loc2][6])
    {
        curr_o_num = _global.trackObj.data.bookM[_loc2][6];
        set_curr_outline(toc_arr.Supp[curr_o_num].Obj, curr_o_num);
    } // end if
    curr_clip = _global.trackObj.data.bookM[_loc2][5];
    trace ("curr_clip = " + curr_clip);
    start_point[0] = _global.trackObj.data.bookM[_loc2][8];
    start_point[1] = _global.trackObj.data.bookM[_loc2][9];
    start_point[2] = Number(outlines[curr_outline].Subject[start_point[0]].Topic[start_point[1]].indent);
    if (_global.trackObj.data.bookM[_loc2][1] != undefined)
    {
        zoom_pref = _global.trackObj.data.bookM[_loc2][2];
        marked_page = _global.trackObj.data.bookM[_loc2][1];
    }
    else
    {
        resume_time = _global.trackObj.data.bookM[_loc2][2];
    } // end else if
    find_place(start_point[0], start_point[1]);
    curr_item = _global.trackObj.data.bookM[_loc2][7];
    trace ("curr_clip = " + curr_clip);
    change_title = true;
    play_topic(_global.trackObj.data.bookM[_loc2][3], _global.trackObj.data.bookM[_loc2][4]);
} // End of the function
function deleteBookmark()
{
    var _loc3 = bookM_list.selectedIndex;
    _root.condBML.removeItemAt(_loc3);
    if (bookM_list.length == 1)
    {
        bookM_list.removeItemAt(_loc3);
        bookM_list.addItemAt(0, bookM_default);
        bookM_list.selectedIndex = 0;
        _global.trackObj.data.bookM = new Array();
        bookM_goto.gotoAndStop("disable");
        bookM_del.gotoAndStop("disable");
    }
    else
    {
        _global.trackObj.data.bookM.splice(_loc3, 1);
        bookM_list.removeItemAt(_loc3);
        if (_loc3 != 0)
        {
            bookM_list.selectedIndex = _loc3 - 1;
        }
        else
        {
            bookM_list.selectedIndex = 0;
        } // end else if
    } // end else if
    if (_root.lms == "TRUE")
    {
        _root.storeBML();
    } // end if
} // End of the function
function convToBoolean(strVal)
{
    var _loc1 = false;
    if (strVal.toLowerCase().substring(0, 1) == "t" || strVal.toLowerCase().substring(0, 1) == "1")
    {
        _loc1 = true;
    } // end if
    return (_loc1);
} // End of the function
function parse_range(input_range)
{
    var _loc8 = new Array();
    var _loc4 = new Array();
    _loc8 = input_range.split(",");
    var _loc9 = _loc8.length;
    for (var _loc5 = 0; _loc5 < _loc9; ++_loc5)
    {
        if (isNaN(Number(_loc8[_loc5])))
        {
            var _loc1 = _loc8[_loc5].split("-");
            var _loc7 = _loc1.length;
            for (var _loc2 = 0; _loc2 < _loc7; ++_loc2)
            {
                if (_loc2 > 1)
                {
                    trace ("Error: Extraneous range values!");
                    continue;
                } // end if
                if (isNaN(Number(_loc1[_loc2])))
                {
                    trace ("Error: Non-numeric range value!");
                    continue;
                } // end if
                _loc1[_loc2] = Number(_loc1[_loc2]);
            } // end of for
            if (_loc1[0] < _loc1[1])
            {
                var _loc6 = _loc1[1] - _loc1[0];
                _loc4.push(_loc1[0]);
                for (var _loc3 = 1; _loc3 < _loc6; ++_loc3)
                {
                    _loc4.push(_loc1[0] + _loc3);
                } // end of for
                _loc4.push(_loc1[1]);
            }
            else
            {
                _loc6 = _loc1[0] - _loc1[1];
                _loc4.push(_loc1[0]);
                for (var _loc3 = 1; _loc3 < _loc6; ++_loc3)
                {
                    _loc4.push(_loc1[0] - _loc3);
                } // end of for
                _loc4.push(_loc1[1]);
            } // end else if
            continue;
        } // end if
        _loc4.push(Number(_loc8[_loc5]));
    } // end of for
    return (_loc4);
} // End of the function
function interpret_num(num, num_form)
{
    var _loc1 = "";
    var _loc3 = num_form.substr(0, 1);
    var _loc4 = num_form.substr(1);
    switch (_loc3)
    {
        case "a":
        {
            _loc1 = String.fromCharCode(num + 96);
            break;
        } 
        case "A":
        {
            _loc1 = String.fromCharCode(num + 64);
            break;
        } 
        case "1":
        {
            _loc1 = String(num);
            break;
        } 
        case "i":
        {
            _loc1 = roman_num[num - 1].toLowerCase();
            break;
        } 
        case "I":
        {
            _loc1 = roman_num[num - 1];
            break;
        } 
    } // End of switch
    if (_loc1.length > 0)
    {
        curr_oi_num = _loc1;
        _loc1 = _loc1 + _loc4;
    } // end if
    return (_loc1);
} // End of the function
function construct_toc()
{
    toc_arr.Supp = new Array();
    toc_arr.Cont = new Array();
    var counter = 0;
    for (outs in outlines)
    {
        toc_arr.Supp[counter] = new Array();
        toc_arr.Supp[counter].Name = outlines[outs].name;
        toc_arr.Supp[counter].Obj = outs;
        if (outlines[outs].demo.substr(0, 1).toLowerCase() == "y")
        {
            toc_arr.Supp[counter].Demo = true;
        }
        else
        {
            toc_arr.Supp[counter].Demo = false;
        } // end else if
        ++counter;
    } // end of for...in
    toc_arr.Supp.reverse();
    counter = 1;
    var d_arL = doc_arr.length;
    var d = 0;
    while (d < d_arL)
    {
        if (doc_arr[d].Toc_Rep.substr(0, 1).toLowerCase() == "y")
        {
            toc_arr.Supp.splice(counter, 0, "");
            toc_arr.Supp[counter] = new Array();
            toc_arr.Supp[counter].Name = doc_arr[d].Name;
            toc_arr.Supp[counter].Obj = doc_arr[d].File;
            if (doc_arr[d].Demo.substr(0, 1).toLowerCase() == "y")
            {
                toc_arr.Supp[counter].Demo = true;
            }
            else
            {
                toc_arr.Supp[counter].Demo = false;
            } // end else if
            ++counter;
        } // end if
        ++d;
    } // end while
    main_out = toc_arr.Supp[0].Obj;
    var omo_arL = outlines[main_out].Subject.length;
    var d = 0;
    while (d <= omo_arL)
    {
        if (outlines[main_out].Subject[d].toc_rep.substr(0, 1).toLowerCase() == "y")
        {
            toc_arr.Cont[d] = new Array();
            if (outlines[main_out].Subject[d].Topic[0].name.indexOf("~") >= 0)
            {
                toc_arr.Cont[d].Name = outlines[main_out].Subject[d].Topic[0].name.substring(0, outlines[main_out].Subject[d].Topic[0].name.indexOf("~") - 1);
            }
            else
            {
                toc_arr.Cont[d].Name = outlines[main_out].Subject[d].Topic[0].name;
            } // end else if
            if (outlines[main_out].Subject[d].demo.substr(0, 1).toLowerCase() == "y")
            {
                toc_arr.Cont[d].Demo = true;
            }
            else
            {
                toc_arr.Cont[d].Demo = false;
            } // end if
        } // end else if
        ++d;
    } // end while
    if (tocCont1st)
    {
        counter = 0;
        var tac_arL = toc_arr.Cont.length;
        var c = 0;
        while (c < tac_arL)
        {
            if (toc_arr.Cont[c] != undefined)
            {
                toc_mc.tocIB.duplicateMovieClip("toc_c" + c, toc_mc.getNextHighestDepth());
                toc_mc["toc_c" + c].tocB.tocUpText.text = toc_mc["toc_c" + c].tocB.tocOverText.text = toc_mc["toc_c" + c].tocB.tocDownText.text = toc_mc["toc_c" + c].tocB.tocDisText.text = toc_arr.Cont[c].Name;
                if (counter != 0)
                {
                    toc_mc["toc_c" + c]._y = toc_mc["toc_c" + counter]._y + toc_mc["toc_c" + counter]._height + tocItemSpace;
                } // end if
                toc_mc["toc_c" + c].tocB.tocUpText.setTextFormat(tocUp);
                toc_mc["toc_c" + c].tocB.tocOverText.setTextFormat(tocOver);
                toc_mc["toc_c" + c].tocB.tocDownText.setTextFormat(tocDown);
                toc_mc["toc_c" + c].tocB.tocDisText.setTextFormat(tocDis);
                counter = c;
            } // end if
            ++c;
        } // end while
        var tas_arL = toc_arr.Supp.length;
        var c = 0;
        while (c < tas_arL)
        {
            toc_mc.tocIB.duplicateMovieClip("toc_s" + c, toc_mc.getNextHighestDepth());
            toc_mc["toc_s" + c].tocB.tocUpText.text = toc_mc["toc_s" + c].tocB.tocOverText.text = toc_mc["toc_s" + c].tocB.tocDownText.text = toc_mc["toc_s" + c].tocB.tocDisText.text = toc_arr.Supp[c].Name;
            if (c == 0)
            {
                toc_mc["toc_s" + c]._y = toc_mc["toc_c" + (toc_arr.Cont.length - 1)]._y + toc_mc["toc_c" + (toc_arr.Cont.length - 1)]._height * (1 + Number(tocGap));
            }
            else
            {
                toc_mc["toc_s" + c]._y = toc_mc["toc_s" + c]._y + toc_mc["toc_s" + c]._height + tocItemSpace;
            } // end else if
            if (c != 0)
            {
                toc_mc["toc_s" + c]._y = toc_mc["toc_s" + (c - 1)]._y + toc_mc["toc_s" + (c - 1)]._height + tocItemSpace;
            } // end if
            toc_mc["toc_s" + c].tocB.tocUpText.setTextFormat(tocUp);
            toc_mc["toc_s" + c].tocB.tocOverText.setTextFormat(tocOver);
            toc_mc["toc_s" + c].tocB.tocDownText.setTextFormat(tocDown);
            toc_mc["toc_s" + c].tocB.tocDisText.setTextFormat(tocDis);
            ++c;
        } // end while
    }
    else
    {
        var tas_arL = toc_arr.Supp.length;
        var c = 0;
        while (c < tas_arL)
        {
            toc_mc.tocIB.duplicateMovieClip("toc_s" + c, toc_mc.getNextHighestDepth());
            toc_mc["toc_s" + c].tocB.tocUpText.text = toc_mc["toc_s" + c].tocB.tocOverText.text = toc_mc["toc_s" + c].tocB.tocDownText.text = toc_mc["toc_s" + c].tocB.tocDisText.text = toc_arr.Supp[c].Name;
            if (c != 0)
            {
                toc_mc["toc_s" + c]._y = toc_mc["toc_s" + (c - 1)]._y + toc_mc["toc_s" + (c - 1)]._height + tocItemSpace;
                
            } // end if
            toc_mc["toc_s" + c].tocB.tocUpText.setTextFormat(tocUp);
            toc_mc["toc_s" + c].tocB.tocOverText.setTextFormat(tocOver);
            toc_mc["toc_s" + c].tocB.tocDownText.setTextFormat(tocDown);
            toc_mc["toc_s" + c].tocB.tocDisText.setTextFormat(tocDis);
            ++c;
        } // end while
        counter = 0;
        var tac_arL = toc_arr.Cont.length;
        var c = 0;
        while (c < tac_arL)
        {
            if (toc_arr.Cont[c] != undefined)
            {
                toc_mc.tocIB.duplicateMovieClip("toc_c" + c, toc_mc.getNextHighestDepth());
                toc_mc["toc_c" + c].tocB.tocUpText.text = toc_mc["toc_c" + c].tocB.tocOverText.text = toc_mc["toc_c" + c].tocB.tocDownText.text = toc_mc["toc_c" + c].tocB.tocDisText.text = toc_arr.Cont[c].Name;
                if (counter == 0)
                {
                    toc_mc["toc_c" + c]._y = toc_mc["toc_s" + (toc_arr.Supp.length - 1)]._y + toc_mc["toc_s" + (toc_arr.Supp.length - 1)]._height * (1 + Number(tocGap));
                }
                else
                {
                    toc_mc["toc_c" + c]._y = toc_mc["toc_c" + counter]._y + toc_mc["toc_c" + counter]._height + tocItemSpace;
                } // end else if
                toc_mc["toc_c" + c].tocB.tocUpText.setTextFormat(tocUp);
                toc_mc["toc_c" + c].tocB.tocOverText.setTextFormat(tocOver);
                toc_mc["toc_c" + c].tocB.tocDownText.setTextFormat(tocDown);
                toc_mc["toc_c" + c].tocB.tocDisText.setTextFormat(tocDis);
                counter = c;
            } // end if
            ++c;
        } // end while
    } // end else if
    toc_mc.tocIB._visible = false;
    toc_mc._x = toc_mc._x + tocNudge;
    var tb_arL = _global.trackObj.data.toc.length + 1;
    var j = 1;
    while (j <= tb_arL)
    {
        if (_global.trackObj.data.toc[j] == 1)
        {
            with (toc_mc["toc_c" + j])
            {
                dot.drawTocDot(tocDotProp[0], tocDotProp[1]);
                dot._visible = true;
            } // End of with
        } // end if
        ++j;
    } // end while
    var coB_ar = "";
    var co_count = 0;
    for (outs in outlines)
    {
        if (co_count != 0)
        {
            coB_ar = coB_ar + "-";
        } // end if
        coB_ar = coB_ar + (outs + "," + _global.trackObj.data[outs + "_e"]);
        ++co_count;
    } // end of for...in
    _global.trackObj.data.out_e = coB_ar;
    if (_root.historyCleared)
    {
        _root.historyCleared = false;
        _root.Curtain._alpha = 0;
        _root.gotoAndPlay(6);
    }
    else
    {
        _root.Curtain._alpha = 0;
        _root.gotoAndPlay(6);
    } // end else if
    show_load_status();
    load_status.gotoAndPlay("loaded");
} // End of the function
function construct_outline(out_name)
{
    var _loc61 = 0;
    var _loc6 = "";
    var _loc51 = "";
    var _loc58 = 0;
    var _loc63 = 0;
    var _loc65 = 100;
    var _loc60 = false;
    var _loc57 = 0;
    var _loc9 = 0;
    var toc_count = 0;
    var _loc62 = true;
    var _loc64 = 0;
    var _loc48 = false;
    var _loc24 = Array();
    var _loc20 = Array();
    var _loc11 = "";
    var _loc8 = 0;
    var _loc59 = 0;
    var _loc5 = "w_" + out_name.toLowerCase();
    var _loc52 = outlines[out_name].subt_sep;
    var _loc49 = outlines[out_name].subt_form;
    if (_loc49 == "" || _loc49 == undefined)
    {
        _loc49 = subt_format;
    } // end if
    if (_loc52 == "" || _loc52 == undefined)
    {
        _loc52 = subt_separator;
    } // end if
    if (_loc52 != "")
    {
        if (_loc52 != undefined)
        {
            if (_loc49 != "")
            {
                if (_loc49 != undefined)
                {
                    subt_pieces = _loc49.split(_loc52);
                }
                else
                {
                    subt_pieces[0] = "n";
                } // end else if
            }
            else
            {
                subt_pieces[0] = "n";
            } // end else if
        }
        else if (_loc49 != "")
        {
            if (_loc49 != undefined)
            {
                subt_pieces[0] = _loc49;
            }
            else
            {
                subt_pieces[0] = "n";
            } // end else if
        }
        else
        {
            subt_pieces[0] = "n";
        } // end else if
    }
    else if (_loc49 != "")
    {
        if (_loc49 != undefined)
        {
            subt_pieces[0] = _loc49;
        }
        else
        {
            subt_pieces[0] = "n";
        } // end else if
    }
    else
    {
        subt_pieces[0] = "n";
    } // end else if
    for (var _loc15 = 0; _loc15 < subt_pieces.length; ++_loc15)
    {
        var _loc43 = subt_pieces[_loc15];
        subt_pieces[_loc15] = new Array();
        subt_pieces[_loc15] = _loc43.split("~~");
        for (var _loc13 = 0; _loc13 < subt_pieces[_loc15].length; ++_loc13)
        {
            if (subt_pieces[_loc15][_loc13] == "" || subt_pieces[_loc15][_loc13] == undefined)
            {
                subt_pieces[_loc15].splice(_loc13, 1);
                --_loc13;
            } // end if
        } // end of for
    } // end of for
    if (outlines[out_name].subt_form == undefined || outlines[out_name].subt_form == "")
    {
        if (_loc49 == "" || _loc49 == undefined)
        {
            outlines[out_name].subt_form = "n";
        }
        else
        {
            outlines[out_name].subt_form = _loc49;
            outlines[out_name].subt_sep = _loc52;
        } // end if
    } // end else if
    if (outlines[out_name].p_style == undefined || outlines[out_name].p_style == "")
    {
        if (play_style == "" || play_style == undefined)
        {
            outlines[out_name].p_style = "s";
        }
        else
        {
            outlines[out_name].p_style = play_style;
        } // end if
    } // end else if
    dotSize = outDotProp[0];
    if (outlines[out_name].char.indexOf(",") != -1)
    {
        _loc48 = false;
        _loc24 = outlines[out_name].char.split(",");
    }
    else if (outlines[out_name].char.indexOf(".") != outlines[out_name].char.length - 1)
    {
        _loc48 = true;
        _loc24 = outlines[out_name].char.split(".");
    }
    else
    {
        _loc24[0] = outlines[out_name].char;
        _loc48 = false;
    } // end else if
    var _loc55 = _loc24.length;
    for (var _loc42 = 0; _loc42 < _loc55; ++_loc42)
    {
        _loc20.push(0);
    } // end of for
    out_obj.wOut.duplicateMovieClip(_loc5, out_obj.getNextHighestDepth());
    var _loc56 = outlines[out_name].Subject.length;
    for (var _loc19 = 0; _loc19 < _loc56; ++_loc19)
    {
        var _loc33 = 0;
        _loc9 = 0;
        var _loc38 = outlines[out_name].Subject[_loc19].Topic.length;
        for (var _loc14 = 0; _loc14 < _loc38; ++_loc14)
        {
            var _loc7 = outlines[out_name].Subject[_loc19].Topic[_loc14].name;
            _loc11 = "";
            _loc8 = Number(outlines[out_name].Subject[_loc19].Topic[_loc14].indent);
            _loc33 = _loc33 + outlines[out_name].Subject[_loc19].Topic[_loc14].range.length;
            if (outlines[out_name].Subject[_loc19].Topic[_loc14].range.length > 1)
            {
                var _loc28 = outlines[out_name].Subject[_loc19].Topic[_loc14].range.length;
                for (var _loc12 = 0; _loc12 < _loc28; ++_loc12)
                {
                    if (!isNaN(Number(array_list[outlines[out_name].Subject[_loc19].Topic[_loc14].range[_loc12]].dur)))
                    {
                        _loc9 = _loc9 + Number(array_list[outlines[out_name].Subject[_loc19].Topic[_loc14].range[_loc12]].dur);
                    } // end if
                } // end of for
            }
            else if (!isNaN(Number(array_list[outlines[out_name].Subject[_loc19].Topic[_loc14].range].dur)))
            {
                _loc9 = _loc9 + Number(array_list[outlines[out_name].Subject[_loc19].Topic[_loc14].range].dur);
            } // end else if
            _loc6 = "out" + _loc19 + "-" + _loc14;
            if (eval[_loc5 + "." + _loc6]._x == undefined)
            {
                out_obj[_loc5].oElem0.duplicateMovieClip(_loc6, out_obj[_loc5].getNextHighestDepth());
                out_obj[_loc5][_loc6].oText.autoSize = "left";
                out_obj[_loc5][_loc6].oTextH.autoSize = "left";
                out_obj[_loc5][_loc6].oTextD.autoSize = "left";
                out_obj[_loc5][_loc6].oDot._visible = false;
                if (outlines[out_name].Subject[_loc19].Topic[_loc14].numbered.toLowerCase().substr(0, 1) == "y")
                {
                    ++_loc20[_loc8];
                    if (_loc48)
                    {
                        for (var _loc35 = 0; _loc35 <= _loc8; ++_loc35)
                        {
                            if (_loc35 != 0)
                            {
                                _loc11 = _loc11 + ".";
                            } // end if
                            _loc11 = _loc11 + interpret_num(_loc20[_loc35], _loc24[_loc35]);
                            if (_loc35 == _loc8)
                            {
                                outlines[out_name].Subject[_loc19].Topic[_loc14].num = curr_oi_num;
                            } // end if
                        } // end of for
                        if (_loc8 == 0)
                        {
                            if (_loc24[0].substr(0, 1) == "1")
                            {
                                _loc11 = _loc11 + ".0";
                            } // end if
                        } // end if
                    }
                    else
                    {
                        _loc11 = _loc11 + interpret_num(_loc20[_loc8], _loc24[_loc8]);
                        outlines[out_name].Subject[_loc19].Topic[_loc14].num = curr_oi_num;
                    } // end else if
                    if (prev_ind > _loc8)
                    {
                        for (var _loc16 = prev_ind; _loc16 > _loc8; --_loc16)
                        {
                            _loc20[_loc16] = 0;
                        } // end of for
                    } // end if
                    _loc11 = _loc11 + ("  " + (_loc7.indexOf("~") != -1 ? (_loc7.substring(0, _loc7.indexOf("~")) + _loc7.substr(_loc7.indexOf("~") + 1)) : (_loc7)));
                }
                else
                {
                    _loc11 = _loc7.indexOf("~") != -1 ? (_loc7.substring(0, _loc7.indexOf("~")) + _loc7.substr(_loc7.indexOf("~") + 1)) : (_loc7);
                } // end else if
                out_obj[_loc5][_loc6].oText.text = out_obj[_loc5][_loc6].oTextH.text = out_obj[_loc5][_loc6].oTextD.text = _loc11;
                out_obj[_loc5][_loc6].oText._visible = true;
                out_obj[_loc5][_loc6].oTextH._visible = false;
                out_obj[_loc5][_loc6].oTextD._visible = false;
                if (outlines[out_name].Subject[_loc19].toc_rep.toLowerCase() == "y" && _loc14 == 0)
                {
                    ++toc_count;
                } // end if
                outlines[out_name].Subject[_loc19].Topic[_loc14].subtitle = new Array();
                outlines[out_name].Subject[_loc19].Topic[_loc14].subtitle = get_subtitle(out_name, _loc19, _loc14);
                trace (outlines[out_name].Subject[_loc19].Topic[_loc14].subtitle);
                _loc51 = _loc6;
                prev_ind = _loc8;
            } // end if
        } // end of for
        outlines[out_name].Subject[_loc19].items = _loc33;
        outlines[out_name].Subject[_loc19].dur = _loc9;
        if (outlines[out_name].Subject[_loc19].dur > 0)
        {
            if (outlines[out_name].show_time.substr(0, 1).toLowerCase() == "y")
            {
                _loc6 = "out" + _loc19 + "-0";
                out_obj[_loc5][_loc6].oText.text = out_obj[_loc5][_loc6].oTextH.text = out_obj[_loc5][_loc6].oTextD.text = out_obj[_loc5][_loc6].oTextD.text + (" (" + Math.floor(_loc9 / 60) + ":" + (Math.round((_loc9 / 60 - Math.floor(_loc9 / 60)) * 60) < 10 ? ("0" + Math.round((_loc9 / 60 - Math.floor(_loc9 / 60)) * 60)) : (Math.round((_loc9 / 60 - Math.floor(_loc9 / 60)) * 60))) + ")");
                continue;
            } // end if
            if (outlines[out_name].show_time.substr(0, 1).toLowerCase() == "" || outlines[out_name].show_time.substr(0, 1).toLowerCase() == undefined)
            {
                if (showOutlineTimeCode.substr(0, 1).toLowerCase() == "y")
                {
                    _loc6 = "out" + _loc19 + "-0";
                    out_obj[_loc5][_loc6].oText.text = out_obj[_loc5][_loc6].oTextH.text = out_obj[_loc5][_loc6].oTextD.text = out_obj[_loc5][_loc6].oTextD.text + (" (" + Math.floor(_loc9 / 60) + ":" + (Math.round((_loc9 / 60 - Math.floor(_loc9 / 60)) * 60) < 10 ? ("0" + Math.round((_loc9 / 60 - Math.floor(_loc9 / 60)) * 60)) : (Math.round((_loc9 / 60 - Math.floor(_loc9 / 60)) * 60))) + ")");
                } // end if
            } // end if
        } // end if
    } // end of for
    space_outline(_loc57, out_name, _loc5, mainScreenBack);
    _global.trackObj = SharedObject.getLocal(cacheName, "/");
    if (_global.trackObj.data.ini != 1)
    {
        _global.trackObj.data[out_name] = [];
        _global.trackObj.data[out_name + "_e"] = [];
        var _loc53 = outlines[out_name].Subject.length;
        for (var _loc37 = 0; _loc37 < _loc53; ++_loc37)
        {
            if (outlines[out_name].Subject[_loc37].Topic.length != undefined)
            {
                _global.trackObj.data[out_name][_loc37] = new Array();
                var _loc41 = outlines[out_name].Subject[_loc37].Topic.length;
                for (var _loc23 = 0; _loc23 < _loc41; ++_loc23)
                {
                    _global.trackObj.data[out_name][_loc37][_loc23] = 0;
                } // end of for
                continue;
            } // end if
            _global.trackObj.data[out_name][_loc37] = 0;
        } // end of for
        _global.trackObj.data[out_name + "_e"] = _global.trackObj.data[out_name];
        trace ("_global.trackObj.data[" + out_name + "] = " + _global.trackObj.data[out_name]);
        if (out_name.toLowerCase() == "outline")
        {
            out_obj.wOut._visible = false;
            out_obj.wOut.oElem0._visible = false;
            out_obj[_loc5]._visible = false;
            _global.trackObj.data.bookM = [];
            _global.trackObj.data.toc = [];
            _global.trackObj.data.toc_e = [];
            _global.trackObj.data.np_pos = [];
            _global.trackObj.data.notes = "";
            _global.trackObj.data.st_state = "";
            for (var _loc37 = 0; _loc37 <= toc_count; ++_loc37)
            {
                _global.trackObj.data.toc[_loc37] = 0;
            } // end of for
            _global.trackObj.data.toc_e = _global.trackObj.data.toc;
            _global.trackObj.data.ini = 1;
            _global.trackObj.flush(5120);
            _global.trackObj.data.np_pos[0] = _global.trackObj.data.np_pos[1] = _global.trackObj.data.np_pos[2] = _global.trackObj.data.np_pos[3] = 350;
        } // end if
    }
    else
    {
        if (out_name.toLowerCase() == "outline")
        {
            if (_global.trackObj.data.bookM.length > 0)
            {
                bookM_list.removeItemAt(0);
                var _loc54 = _global.trackObj.data.bookM.length;
                for (var _loc19 = 0; _loc19 < _loc54; ++_loc19)
                {
                    bookM_list.addItemAt(_loc19, _global.trackObj.data.bookM[_loc19][0], _global.trackObj.data.bookM[_loc19]);
                } // end of for
            } // end if
        } // end if
        if (_global.trackObj.data.np_pos[0] != undefined)
        {
            notepad._x = _global.trackObj.data.np_pos[0];
            notepad._y = _global.trackObj.data.np_pos[1];
        } // end if
        notepad.np_text.text = _global.trackObj.data.notes;
        notepad.np_text.setTextFormat(userNote);
    } // end else if
    notepad.np_back.draw_npBack(_global.trackObj.data.np_pos[2], _global.trackObj.data.np_pos[3]);
    if (_root.lms == "TRUE")
    {
        varSender = new LoadVars();
        varSender.CourseID = _root.CourseID;
        varSender.cacheKiller = new Date().getTime();
        varReceiver = new LoadVars();
        varReceiver.onLoad = function (success)
        {
            if (success)
            {
                var _loc15 = 0;
                if (this.tocBullets != "" || this.tocBullets.length != 0)
                {
                    _global.trackObj.data.toc = [];
                    _global.trackObj.data.toc = this.tocBullets.split(",");
                } // end if
                if (this.Bullets != "" || this.Bullets.length != 0)
                {
                    var _loc26 = this.Bullets.split("-");
                    for (var _loc18 = 0; _loc18 < _loc26.length; ++_loc18)
                    {
                        var _loc13 = _loc26[_loc18].split(",");
                        var _loc6 = _loc13[0];
                        var _loc12 = 1;
                        _loc13.splice(0, 1);
                        _global.trackObj.data[_loc6] = [];
                        var _loc21 = outlines[_loc6].Subject.length;
                        for (var _loc5 = 0; _loc5 < _loc21; ++_loc5)
                        {
                            var _loc14 = outlines[_loc6].Subject[_loc5].Topic.length;
                            if (_loc14 != undefined)
                            {
                                _global.trackObj.data[_loc6][_loc5] = new Array();
                                _loc14 = outlines[_loc6].Subject[_loc5].Topic.length;
                                for (var _loc7 = 0; _loc7 < _loc14; ++_loc7)
                                {
                                    _global.trackObj.data[_loc6][_loc5][_loc7] = _loc13[_loc12];
                                    ++_loc12;
                                } // end of for
                                continue;
                            } // end if
                            _global.trackObj.data[_loc6][_loc5] = 0;
                        } // end of for
                    } // end of for
                } // end if
                if (this.Bookmarks != "" || this.Bookmarks.length != 0)
                {
                    _root.condBML = this.Bookmarks.split(",");
                }
                else
                {
                    _global.trackObj.data.bookM = new Array();
                    _root.condBML = new Array();
                } // end else if
                if (_root.condBML.length > 0)
                {
                    _root.bookM_list.removeAll();
                    _global.trackObj.data.bookM = new Array();
                    for (var _loc11 = 0; _loc11 < _root.condBML.length; ++_loc11)
                    {
                        var _loc4 = new Array();
                        _loc15 = _root.condBML[_loc11].substring(0, _root.condBML[_loc11].indexOf("-"));
                        _loc4 = _root.condBML[_loc11].substr(_root.condBML[_loc11].indexOf("-") + 1).split(".");
                        var _loc20 = toc_arr.Supp[_loc4[3]].Obj;
                        var _loc9 = "";
                        var _loc16 = 20;
                        if (_loc4[0] == 0)
                        {
                            _loc9 = toc_arr.Supp[_loc4[1]].Name;
                        }
                        else
                        {
                            _loc9 = out_obj["w_" + _loc20]["out" + _loc4[0] + "-" + _loc4[1]].oText.text;
                        } // end else if
                        if (_loc4[0] != 0)
                        {
                            var _loc23 = array_list[outlines[_loc20].Subject[_loc4[0]].Topic[_loc4[1]].range[_loc4[2]]].template;
                            if (_loc23 == "flashpaper")
                            {
                                var _loc19 = new Array();
                                _loc19 = _loc15.split(".");
                                _loc4.splice(0, 0, _loc19[0], _loc19[1]);
                                var _loc22 = (_loc9.length > _loc16 ? (_loc9.substr(0, _loc16) + "...") : (_loc9)) + " - p. " + _loc4[0] + " (" + _loc4[1] + "%)";
                                _loc4.splice(0, 0, _loc22);
                            }
                            else
                            {
                                _loc4.splice(0, 0, undefined, _loc15);
                                var _loc25 = String(Math.floor(Number(_loc15) / 60));
                                var _loc17 = String(60 * (Number(_loc15) / 60 - Math.floor(Number(_loc15) / 60)));
                                var _loc24 = (_loc9.length > _loc16 ? (_loc9.substr(0, _loc16) + "...") : (_loc9 = " -", " -")) + " " + _loc25 + ":" + (_loc17.indexOf(".") == 1 ? ("0" + _loc17.substr(0, 1)) : (_loc17.substr(0, 2)));
                                _loc4.splice(0, 0, _loc24);
                            } // end if
                        } // end else if
                        bookM_list.addItem(_loc4[0], _loc4);
                        _global.trackObj.data.bookM.push(_loc4);
                    } // end of for
                }
                else
                {
                    _root.bookM_list.removeAll();
                    _root.bookM_list.addItemAt(0, _root.bookM_default);
                    _root.bookM_list.selectedIndex = 0;
                    _global.trackObj.data.bookM = new Array();
                } // end else if
                for (var _loc8 = 0; _loc8 < out_record_arr.length; ++_loc8)
                {
                    if (demoVer)
                    {
                        if (Number(out_record_arr[_loc8].Demo) == 0)
                        {
                            wOutline["out" + _loc8].oText._visible = false;
                            wOutline["out" + _loc8].oTextH._visible = false;
                            wOutline["out" + _loc8].oTextD._visible = true;
                        }
                        else
                        {
                            wOutline["out" + _loc8].oText._visible = true;
                            wOutline["out" + _loc8].oTextH._visible = false;
                            wOutline["out" + _loc8].oTextD._visible = false;
                        } // end else if
                        continue;
                    } // end if
                    wOutline["out" + _loc8].oText._visible = true;
                    wOutline["out" + _loc8].oTextH._visible = false;
                    wOutline["out" + _loc8].oTextD._visible = false;
                } // end of for
                for (var _loc10 = 1; _loc10 <= toc_count; ++_loc10)
                {
                    _root["button" + _loc10].tocB.buttonUp.drawTocUp(Button_arr.tocUp.FillC, Button_arr.tocUp.FillA);
                    _root["button" + _loc10].tocB.buttonOver.drawTocO(Button_arr.tocOver.FillC, Button_arr.tocOver.FillA);
                    _root["button" + _loc10].tocB.buttonDown.drawTocO(Button_arr.tocOver.FillC, Button_arr.tocOver.FillA);
                    _root["button" + _loc10].tocB.buttonDis.drawTocDis(Button_arr.tocDis.FillC, Button_arr.tocDis.FillA);
                    if (demoVer)
                    {
                        if (Number(toc_record_arr[_loc10 - 1].Demo) == 0)
                        {
                            _root["button" + _loc10].tocB.gotoAndStop("Dis");
                        } // end if
                    } // end if
                } // end of for
                
            } // end if
        };
        varSender.sendAndLoad("/GetCourseInfo.asp", varReceiver, "GET");
    } // end if
    if (space_outline(_loc57, out_name, _loc5, mainScreenBack))
    {
        if (out_name.toLowerCase() == "outline")
        {
            if (_root.historyCleared)
            {
                gotoAndPlay(5);
            }
            else
            {
                fscommand("fullscreen", "true");
                if (checkx < 1024 || checky < 768)
                {
                    _root.Curtain._alpha = 100;
                    _root.sizeError._x = 345;
                    _root.sizeError._visible = true;
                }
                else
                {
                    gotoAndPlay(5);
                } // end if
            } // end if
        } // end else if
    } // end else if
    out_obj[_loc5]._x = out_hide_x;
    out_obj[_loc5]._visible = false;
    out_obj[_loc5].oElem0._visible = false;
    out_obj.wOut.oElem0._visible = false;
    if (demoVer)
    {
        _loc53 = outlines[out_name].Subject.length;
        for (var _loc19 = 0; _loc19 < _loc53; ++_loc19)
        {
            _loc41 = outlines[out_name].Subject[_loc19].Topic.length;
            for (var _loc14 = 0; _loc14 < _loc41; ++_loc14)
            {
                var _loc31 = outlines[out_name].Subject[_loc19].Topic[_loc14].demo.substr(0, 1).toLowerCase();
                if (_loc31 != "y")
                {
                    out_obj[_loc5]["out" + _loc19 + "-" + _loc14].oText._visible = false;
                    out_obj[_loc5]["out" + _loc19 + "-" + _loc14].oTextH._visible = false;
                    out_obj[_loc5]["out" + _loc19 + "-" + _loc14].oTextD._visible = true;
                } // end if
            } // end of for
        } // end of for
    } // end if
    if (out_name.toLowerCase() == "outline")
    {
        if (introMedia == "" || introMedia.lastIndexOf(".") < 0)
        {
            _root.HeadMov.stop();
            _root.HeadMov.clear();
            _root.gotoAndPlay("outlines");
        } // end if
    } // end if
    show_load_status();
} // End of the function
function get_subtitle(o_name, s_num, t_num)
{
    var _loc5 = "";
    var _loc10 = "";
    var _loc9 = Number(outlines[o_name].Subject[s_num].Topic[t_num].indent);
    var _loc8 = 0;
    _root.titleInd.text = "";
    while (subt_pieces[_loc8] != undefined)
    {
        if (_loc9 >= _loc8)
        {
            for (var _loc11 = 0; _loc11 < subt_pieces[_loc8].length; ++_loc11)
            {
                switch (subt_pieces[_loc8][_loc11])
                {
                    case "o":
                    {
                        _loc5 = _loc5 + outlines[o_name].name;
                        break;
                    } 
                    case "n":
                    {
                        if (subt_pieces.length > 1)
                        {
                            if (subt_pieces[1] == undefined)
                            {
                                _loc5 = _loc5 + return_main_title(outlines[o_name].Subject[s_num].Topic[t_num].name);
                                _loc10 = return_sub_title(outlines[o_name].Subject[s_num].Topic[t_num].name);
                            }
                            else if (_loc9 == _loc8)
                            {
                                _loc5 = _loc5 + return_main_title(outlines[o_name].Subject[s_num].Topic[t_num].name);
                                _loc10 = return_sub_title(outlines[o_name].Subject[s_num].Topic[t_num].name);
                            }
                            else
                            {
                                for (var _loc7 = _loc9 + 1; _loc7 >= 0; --_loc7)
                                {
                                    if (Number(outlines[o_name].Subject[s_num].Topic[_loc7].indent) == _loc8)
                                    {
                                        _loc5 = _loc5 + return_main_title(outlines[o_name].Subject[s_num].Topic[_loc7].name);
                                        _loc7 = -1;
                                    } // end if
                                } // end of for
                            } // end else if
                        }
                        else
                        {
                            _loc5 = _loc5 + return_main_title(outlines[o_name].Subject[s_num].Topic[t_num].name);
                            _loc10 = return_sub_title(outlines[o_name].Subject[s_num].Topic[t_num].name);
                        } // end else if
                        break;
                    } 
                    case "#":
                    {
                        if (subt_pieces.length > 1)
                        {
                            if (subt_pieces[1] == undefined)
                            {
                                _loc5 = _loc5 + outlines[o_name].Subject[s_num].Topic[t_num].num;
                            }
                            else if (_loc9 == _loc8)
                            {
                                _loc5 = _loc5 + outlines[o_name].Subject[s_num].Topic[t_num].num;
                            }
                            else
                            {
                                for (var _loc7 = _loc9 + 1; _loc7 >= 0; --_loc7)
                                {
                                    if (Number(outlines[o_name].Subject[s_num].Topic[_loc7].indent) == _loc8)
                                    {
                                        _loc5 = _loc5 + outlines[o_name].Subject[s_num].Topic[_loc7].num;
                                        _loc7 = -1;
                                    } // end if
                                } // end of for
                            } // end else if
                        }
                        else
                        {
                            _loc5 = _loc5 + outlines[o_name].Subject[s_num].Topic[t_num].num;
                        } // end else if
                        break;
                    } 
                    case "#n":
                    {
                        var _loc6 = -1;
                        if (subt_pieces.length > 1)
                        {
                            if (subt_pieces[1] == undefined)
                            {
                                _loc6 = find_main_title_end(outlines[o_name].Subject[s_num].Topic[t_num].name, out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text);
                                if (_loc6 >= 0)
                                {
                                    _loc5 = _loc5 + out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text.substring(0, _loc6);
                                    _loc10 = _loc10 + out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text.substr(_loc6 + 1);
                                }
                                else
                                {
                                    _loc5 = _loc5 + out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text;
                                } // end else if
                            }
                            else if (_loc9 == _loc8)
                            {
                                _loc6 = find_main_title_end(outlines[o_name].Subject[s_num].Topic[t_num].name, out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text);
                                if (_loc6 >= 0)
                                {
                                    _loc5 = _loc5 + out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text.substring(0, _loc6);
                                    _loc10 = _loc10 + out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text.substr(_loc6 + 1);
                                }
                                else
                                {
                                    _loc5 = _loc5 + out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text;
                                } // end else if
                            }
                            else
                            {
                                for (var _loc7 = _loc9 + 1; _loc7 >= 0; --_loc7)
                                {
                                    if (Number(outlines[o_name].Subject[s_num].Topic[_loc7].indent) == _loc8)
                                    {
                                        _loc6 = find_main_title_end(outlines[o_name].Subject[s_num].Topic[_loc7].name, out_obj["w_" + o_name]["out" + s_num + "-" + _loc7].oText.text);
                                        if (_loc6 >= 0)
                                        {
                                            _loc5 = _loc5 + out_obj["w_" + o_name]["out" + s_num + "-" + _loc7].oText.text.substring(0, _loc6);
                                        }
                                        else
                                        {
                                            _loc5 = _loc5 + out_obj["w_" + o_name]["out" + s_num + "-" + _loc7].oText.text;
                                        } // end else if
                                        _loc7 = -1;
                                    } // end if
                                } // end of for
                            } // end else if
                        }
                        else
                        {
                            _loc6 = find_main_title_end(outlines[o_name].Subject[s_num].Topic[t_num].name, out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text);
                            if (_loc6 >= 0)
                            {
                                _loc5 = _loc5 + out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text.substring(0, _loc6);
                                _loc10 = _loc10 + out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text.substr(_loc6 + 1);
                            }
                            else
                            {
                                _loc5 = _loc5 + out_obj["w_" + o_name]["out" + s_num + "-" + t_num].oText.text;
                            } // end else if
                        } // end else if
                        break;
                    } 
                    default:
                    {
                        _loc5 = _loc5 + subt_pieces[_loc8][_loc11];
                    } 
                } // End of switch
            } // end of for
        } // end if
        ++_loc8;
    } // end while
    var _loc12 = new Array();
    _loc12[0] = _loc5;
    _loc12[1] = _loc10;
    return (_loc12);
} // End of the function
function fixFlashPaper2SelectionManagement(mc)
{
    if (typeof(mc.gMainView.m_mainMC.onMouseDown) == "function" && mc.gMainView.m_mainMC.hasSafeSelectionManagement === undefined)
    {
        mc.gMainView.m_mainMC.onMouseDown = function ()
        {
            var _loc4 = _global.FPUI.Component.focusedComponent;
            if (_loc4 != null)
            {
                var _loc5 = false;
                if (_loc4._visible)
                {
                    var _loc3 = new Object();
                    _loc3.x = _root._xmouse;
                    _loc3.y = _root._ymouse;
                    _root.localToGlobal(_loc3);
                    _loc5 = _loc4.hitTest(_loc3.x, _loc3.y, true);
                } // end if
                if (_loc5 == false)
                {
                    _loc4.onComponentKillFocus();
                } // end if
            } // end if
        };
    } // end if
} // End of the function
function space_outline(reduction, out_name, out_var, back_obj)
{
    var _loc24 = 0;
    var _loc26 = 0;
    var _loc3 = "";
    var _loc6 = 0;
    var _loc12 = 1;
    var _loc25 = out_obj[out_var].out0._x;
    var _loc21 = 0;
    var _loc23 = 0;
    var _loc16 = outUp.size;
    var _loc18 = outlines[out_name].size_inc;
    var _loc10 = "";
    var _loc15 = 0;
    var _loc22 = false;
    if (outlines[out_name].i_col != undefined)
    {
        var _loc11 = Number(outlines[out_name].i_col);
    }
    else
    {
        _loc11 = Number(initCol);
    } // end else if
    if (outlines[out_name].b_space != undefined)
    {
        var _loc7 = Number(outlines[out_name].b_space);
    }
    else
    {
        _loc7 = Number(subjSpace);
    } // end else if
    if (outlines[out_name].i_space != undefined)
    {
        var _loc14 = Number(outlines[out_name].i_space);
    }
    else
    {
        _loc14 = Number(paragraphSpace);
    } // end else if
    while (!_loc22)
    {
        outItemW = (back_obj._width - out_obj[out_var].oElem0.oText._x * _loc11 - _loc7 * (_loc11 + 1)) / _loc11;
        var _loc20 = outlines[out_name].Subject.length;
        for (var _loc2 = 0; _loc2 < _loc20; ++_loc2)
        {
            var _loc17 = outlines[out_name].Subject[_loc2].Topic.length;
            for (var _loc5 = 0; _loc5 < _loc17; ++_loc5)
            {
                _loc6 = Number(outlines[out_name].Subject[_loc2].Topic[_loc5].indent);
                _loc3 = "out" + _loc2 + "-" + _loc5;
                out_obj[out_var][_loc3].oText._width = outItemW - outIndent * _loc6;
                out_obj[out_var][_loc3].oTextH._width = outItemW - outIndent * _loc6;
                out_obj[out_var][_loc3].oTextD._width = outItemW - outIndent * _loc6;
                out_obj[out_var][_loc3].oButton._width = outItemW - outIndent * _loc6;
                _loc21 = _loc6;
                out_obj[out_var][_loc3].oDot._width = dotSize - reduction / 2 - 5.000000E-001 * _loc6;
                out_obj[out_var][_loc3].oDot._height = dotSize - reduction / 2 - 5.000000E-001 * _loc6;
                if (outUp.size != _loc16 - reduction - _loc6 * _loc18)
                {
                    outUp.size = outOver.size = outDis.size = _loc16 - reduction - _loc6 * _loc18;
                } // end if
                out_obj[out_var][_loc3].oText.setTextFormat(outUp);
                out_obj[out_var][_loc3].oTextH.setTextFormat(outOver);
                out_obj[out_var][_loc3].oTextD.setTextFormat(outDis);
                _loc23 = outUp.size;
                out_obj[out_var][_loc3].oButton._height = out_obj[out_var][_loc3].oText._height;
                out_obj[out_var][_loc3]._alpha = 100;
                if (_loc10 != "")
                {
                    out_obj[out_var][_loc3]._x = out_obj[out_var][_loc10]._x + (_loc6 - _loc15) * outIndent;
                    if (_loc5 == 0)
                    {
                        out_obj[out_var][_loc3]._y = out_obj[out_var][_loc10]._y + out_obj[out_var][_loc10]._height + _loc7;
                    }
                    else
                    {
                        out_obj[out_var][_loc3]._y = out_obj[out_var][_loc10]._y + out_obj[out_var][_loc10]._height + _loc14;
                    } // end else if
                }
                else
                {
                    out_obj[out_var][_loc3]._y = _loc7;
                    out_obj[out_var][_loc3]._x = _loc7((_loc6 - _loc15) * outIndent);
                } // end else if
                if (out_obj[out_var][_loc3]._y + out_obj[out_var][_loc3]._height > back_obj._height - _loc7)
                {
                    ++_loc12;
                    trace ("Value of currCol right after being incremented is: " + _loc12);
                    if (_loc12 > _loc11)
                    {
                        break;
                    }
                    else if (outlines[out_name].Subject[_loc2].Topic.length <= subjLimit)
                    {
                        var _loc8 = 0;
                        if (_loc5 < subjLimit / 2)
                        {
                            _loc8 = 0;
                        } // end if
                        for (var _loc4 = _loc8; _loc4 <= _loc5; ++_loc4)
                        {
                            if (_loc4 == _loc8)
                            {
                                out_obj[out_var]["out" + _loc2 + "-" + _loc4]._y = _loc7;
                                out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x = out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x + (outItemW + _loc7);
                                continue;
                            } // end if
                            out_obj[out_var]["out" + _loc2 + "-" + _loc4]._y = out_obj[out_var]["out" + _loc2 + "-" + (_loc4 - 1)]._y + out_obj[out_var]["out" + _loc2 + "-" + (_loc4 - 1)]._height + _loc14;
                            out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x = out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x + (outItemW + _loc7);
                        } // end of for
                    }
                    else
                    {
                        _loc8 = _loc5;
                        if (_loc5 < subjLimit / 2)
                        {
                            _loc8 = 0;
                        }
                        else if (_loc5 > outlines[out_name].Subject[_loc2].Topic.length - subjLimit / 2 - 1)
                        {
                            _loc8 = outlines[out_name].Subject[_loc2].Topic.length - subjLimit / 2;
                        } // end else if
                        if (_loc8 != 0)
                        {
                            if (Number(outlines[out_name].Subject[_loc2].Topic[_loc8].indent) > Number(outlines[out_name].Subject[_loc2].Topic[_loc8 - 1].indent))
                            {
                                --_loc8;
                            } // end if
                        } // end if
                        trace ("Repositioning section " + _loc2 + " from the subIndex of: " + _loc8);
                        for (var _loc4 = _loc8; _loc4 <= _loc5; ++_loc4)
                        {
                            if (_loc4 == _loc8)
                            {
                                out_obj[out_var]["out" + _loc2 + "-" + _loc4]._y = _loc7;
                                trace ("The first item:  out_obj[out_var][out" + _loc2 + "-" + _loc4 + "]._x = " + out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x);
                                out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x = out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x + (outItemW + _loc7);
                                continue;
                            } // end if
                            out_obj[out_var]["out" + _loc2 + "-" + _loc4]._y = out_obj[out_var]["out" + _loc2 + "-" + (_loc4 - 1)]._y + out_obj[out_var]["out" + _loc2 + "-" + (_loc4 - 1)]._height + _loc14;
                            trace ("Additional item:  out_obj[out_var][out" + _loc2 + "-" + _loc4 + "]._x = " + out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x);
                            out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x = out_obj[out_var]["out" + _loc2 + "-" + _loc4]._x + (outItemW + _loc7);
                        } // end of for
                    } // end else if
                } // end else if
                _loc15 = _loc6;
                _loc10 = _loc3;
            } // end of for
            if (_loc12 > _loc11)
            {
                break;
            } // end if
        } // end of for
        if (_loc12 > _loc11)
        {
            _loc22 = false;
            ++_loc11;
            _loc12 = 1;
            _loc10 = "";
            _loc15 = 0;
            trace ("reduCol = " + _loc11 + "     currCol = " + _loc12 + "     mainFontSize = " + _loc16);
            if (_loc11 > colMax)
            {
                --_loc16;
                if (outlines[out_name].i_col != undefined)
                {
                    _loc11 = Number(outlines[out_name].i_col);
                }
                else
                {
                    _loc11 = Number(initCol);
                } // end if
            } // end else if
            continue;
        } // end if
        _loc22 = true;
    } // end while
    outUp.size = outOver.size = outDis.size = _loc16 - reduction;
    outlines[out_name].x_pos = back_obj._x + (back_obj._width - out_obj[out_var]._width) / 2;
    return (true);
} // End of the function
function starttest()
{
    gotoAndPlay("InitQuiz");
} // End of the function
wOut._visible = false;
w_outline._visible = false;
fscommand("allowscale", "false");
fscommand("showmenu", "false");
my_color = new Color(_root.BackColor);
my_color.setRGB(3355494);
inactive_color = new Color(_root.BackColor);
inactive_color.setRGB(7829367);
_root.StartVid = "";
_root.CurrentVid = "";
_root.EndVid = "";
_root.logo.loadMovie(brandLoc + "logo.swf");
_root.backgroundclip.loadMovie(brandLoc + "back.swf");
checkx = System.capabilities.screenResolutionX;
checky = System.capabilities.screenResolutionY;
bookM_list.color = 0;
bookM_add.gotoAndStop("disable");
bookM_goto.gotoAndStop("disable");
bookM_del.gotoAndStop("disable");
ptxt._visible = false;
var obj_fieldnames_arr = [];
var prop_fieldnames_arr = [];
var set_fieldnames_arr = [];
var brand_fieldnames_arr = [];
var doc_fieldnames_arr = [];
var objects_set = new Object();
var array_list = [];
var templates_arr = [];
var properties_arr = [];
var settings_arr = [];
var doc_arr = [];
var toc_arr = [];
var genericloader = new LoadVars();
var temploader = new LoadVars();
var objloader = new LoadVars();
var proploader = new LoadVars();
var setloader = new LoadVars();
var brandloader = new LoadVars();
var arrayloader = new LoadVars();
var docloader = new LoadVars();
var typeSize = Array();
var subjLengths = Array();
var webAdd = Array();
var VideoArray = [];
var VideoTimes = [];
var ex_Ltarg = "";
var irecord = 0;
var section = "0";
var bookM_default = "No Bookmarks Set";
var resume_time = 0;
var marked_page = 0;
var zoom_pref = 100;
var curr_sect = 0;
var outItemW = 0;
var colMax = 6;
var fontSize_limit = 6;
var dotSize = 8;
var tempVal = "";
var quizMediaLoc = "media/";
var roman_num = Array("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX", "XXXI", "XXXII", "XXXIII", "XXXIV", "XXXV", "XXXVI", "XXXVII", "XXXIX", "XXXVIII", "XL", "XLI", "XXIX", "XLIII", "LIV", "XLV", "XLVI", "XLVII", "XLVIII", "XLIX", "L", "LI", "LII", "LIII", "LIV", "LV", "LVI", "LVII", "LVIII", "LIX", "LX", "LXI", "LXII", "LXIII", "LXIV", "LXV", "LXVI", "LXVII", "LXVIII", "LXIX", "LXX", "LXXI", "LXXII", "LXXIII", "LXXIV", "LXXV", "LXXVI", "LXXVII", "LXXVIII", "LXXIX", "LXXX", "LXXXI", "LXXXII", "LXXXIII", "LXXXIV", "LXXXV", "LXXXVI", "LXXXVII", "LXXXVIII", "LXXXIX", "XC", "XCI", "XCII", "XCIII", "XCIV", "XCV", "XCVI", "XCVII", "XCVIII", "XCIX", "C", "CI");
var main_out = "";
var curr_subj = 0;
var curr_topic = 0;
var curr_clip = 0;
var curr_index = 0;
var curr_item = 0;
var total_items = 0;
var curr_template = "outlines";
var pause_media = false;
var start_point = new Array();
var subt_pieces = new Array();
var curr_oi_num = "";
var change_title = false;
var no_cues = true;
var near_end = false;
var out_hide_x = 1536;
var curr_outline = "w_outlines";
var curr_o_num = 0;
var time_played = 0;
var selected_scene = 0;
var selected_part = 0;
var responded = false;
var scroll_change = new Array();
var scroll_count = 0;
var forward_click = false;
var return_point = new Array();
var return_history = new Array();
var notes_showing = false;
var resizing_np = false;
var viewing_page = false;
var part_vids = new Array();
var part_cues = new Array();
var part_subtxt = new Array();
var head_graphic = "";
var condBML = new Array();
var load_stat = "";
var load_num = 0;
var user_pause = false;
brandCopyRight = "2005 Makau Corporation";
brandWebAddress = "www.makaucorp.com";
var clearH_txt = "Clear History";
var quit_txt = "Quit";
var bookNames = Array();
var outIndent = 0;
var showOutlineTimeCode = "yes";
var docDir = "doc/";
var rndQuit = "yes";
var ddTargInst = "";
var courseRet_txt = "";
var show_courseRet = "";
var subTxtLbl = "";
var sTxtWidth = 54;
var noteTxt = "";
var storeTxt = "";
var prntTxt = "";
var returnTxt = "";
var partTitle = "";
var pageTitle = "";
var qBeginBT = "";
var thmColor = "haloOrange";
var dotShape = "";
var checkMark = "no";
var outDotProp = Array();
var tocDotProp = Array();
var degRound = 6;
var slideRound = 10;
var introMedia = "intro.flv";
var titleNudge = undefined;
var subTNudge = new Array();
var subTSpacer = "";
var tocNudge = 0;
var tocGap = 0;
var tocItemSpace = 0;
var tocCont1st = false;
var play_style = s;
var subt_separator = "";
var subt_format = "";
var regP_msg = "Click on the forward button to continue.";
var partP_msg1 = "";
var partP_msg2 = "";
var scenP_msg1 = "";
var scenP_msg2 = "";
var scenP_msg3 = "";
var quiz_inst = "";
var cacheName = "default";
thisTitle = "";
var paragraphSpace = 1;
var subjSpace = 20;
var subjLimit = 6;
var initCol = 3;
var initSec = 1;
var version = "";
var oDefChar = "";
var Button_arr = Array();
var Graphic_arr = Array();
var mainTtl = new TextFormat();
var subTtl = new TextFormat();
var subSubTtl = new TextFormat();
var copyRt = new TextFormat();
var questTxt = new TextFormat();
var questStat = new TextFormat();
var ansTxt = new TextFormat();
var ddTrgIns = new TextFormat();
var ddIbackL = new TextFormat();
var ddIansL = new TextFormat();
var ddTxtAns = new TextFormat();
var saInst = new TextFormat();
var qbuttons = new TextFormat();
var qrTitle = new TextFormat();
var tocUp = new TextFormat();
var bookmarks = new TextFormat();
var tocOver = new TextFormat();
var tocDown = new TextFormat();
var tocDis = new TextFormat();
var bookMDis = new TextFormat();
var bookMUp = new TextFormat();
var bookMDown = new TextFormat();
var prntOver = new TextFormat();
var storOver = new TextFormat();
var addOver = new TextFormat();
var delOver = new TextFormat();
var noteOver = new TextFormat();
var disagOver = new TextFormat();
var gotoOver = new TextFormat();
var retOver = new TextFormat();
var agreeOver = new TextFormat();
var contOver = new TextFormat();
var contUp = new TextFormat();
var contDown = new TextFormat();
var outUp = new TextFormat();
var outOver = new TextFormat();
var outDis = new TextFormat();
var volText = new TextFormat();
var clipProg = new TextFormat();
var verStyle = new TextFormat();
var pmsgtxt = new TextFormat();
var subttxt = new TextFormat();
var stxtlbl = new TextFormat();
var partTtl = new TextFormat();
var partName = new TextFormat();
var userNote = new TextFormat();
var npTitle = new TextFormat();
var quizTitle = new TextFormat();
var qqNum = new TextFormat();
var quizInst = new TextFormat();
var pgNum = new TextFormat();
var pgLbl = new TextFormat();
var pgLblG = new TextFormat();
var agreeUp = new TextFormat();
var agreeDown = new TextFormat();
var qLoadTxt = new TextFormat();
var myCuePointListener = new Object();
myCuePointListener.cuePoint = function (eventObject)
{
    if (HeadMov.playheadTime != 0)
    {
        trace ("(HeadMov.playheadTime >= eventObject.cuePointTime) = (" + HeadMov.playheadTime + " >= " + eventObject.cuePointTime + ") = " + (HeadMov.playheadTime >= eventObject.cuePointTime));
        if (HeadMov.playheadTime >= eventObject.cuePointTime)
        {
            switch (eventObject.cuePointName.substr(0, 1).toLowerCase())
            {
                case "s":
                {
                    _root.Slideshow.gotoAndPlay(Number(eventObject.cuePointName.substr(1)) + 1);
                    break;
                } 
                case "t":
                {
                    ++scroll_count;
                    if (scroll_count > scroll_change.length)
                    {
                        scroll_change.push(Number(eventObject.cuePointName.substr(1)) - _root.support_text.sub_text.scroll);
                    } // end if
                    _root.support_text.sub_text.scroll = Number(eventObject.cuePointName.substr(1));
                    break;
                } 
            } // End of switch
            no_cues = false;
        }
        else if (!no_cues)
        {
            switch (eventObject.cuePointName.substr(0, 1).toLowerCase())
            {
                case "s":
                {
                    _root.Slideshow.gotoAndPlay(Number(eventObject.cuePointName.substr(1)));
                    break;
                } 
                case "t":
                {
                    --scroll_count;
                    _root.support_text.sub_text.scroll = _root.support_text.sub_text.scroll - scroll_change[scroll_count];
                    break;
                } 
            } // End of switch
        }
        else
        {
            trace ("Cues were just added!  Don\'t play them...");
        } // end else if
    }
    else
    {
        trace ("The Play head stopped!  Don\'t play them...");
    } // end else if
};
if (typeof(demoVer) != "boolean")
{
    var temp_dV = demoVer;
    demoVer = convToBoolean(temp_dV);
} // end if
if (_root.historyCleared == undefined)
{
    var historyCleared = false;
} // end if
brandloader.load(brandLoc + "brand.ini");
brandloader.onData = function (dat)
{
    var _loc5 = dat.split("\r\n");
    if (_loc5.length == 1)
    {
        _loc5 = dat.split("\n");
    } // end if
    var _loc16 = "";
    var _loc15 = "";
    var _loc9 = "";
    var _loc14 = "";
    var _loc12 = "";
    var _loc8 = "";
    var _loc13 = "";
    var _loc11 = "";
    brand_fieldnames_arr = _loc5[0].split("|");
    var _loc7 = _loc5.length;
    for (var _loc4 = 1; _loc4 < _loc7; ++_loc4)
    {
        if (_loc5[_loc4].length != 0)
        {
            var _loc2 = _loc5[_loc4].split("|");
            switch (brand_fieldnames_arr[0])
            {
                case "Dot":
                case "Graphic":
                case "Button":
                {
                    _root[brand_fieldnames_arr[0] + "_arr"][_loc2[0]] = new Array();
                    var _loc6 = _loc2.length;
                    for (var _loc3 = 1; _loc3 < _loc6; ++_loc3)
                    {
                        if (_loc2[_loc3] == "")
                        {
                            _loc2[_loc3] = _root["temp_" + brand_fieldnames_arr[_loc3]];
                        }
                        else
                        {
                            _root["temp_" + brand_fieldnames_arr[_loc3]] = _loc2[_loc3];
                        } // end else if
                        _root[brand_fieldnames_arr[0] + "_arr"][_loc2[0]][brand_fieldnames_arr[_loc3]] = _loc2[_loc3];
                    } // end of for
                    break;
                } 
                case "Name":
                {
                    _loc6 = _loc2.length;
                    for (var _loc3 = 1; _loc3 < _loc6; ++_loc3)
                    {
                        if (_loc2[_loc3] == "")
                        {
                            _loc2[_loc3] = _root["temp_" + brand_fieldnames_arr[_loc3]];
                            continue;
                        } // end if
                        _root["temp_" + brand_fieldnames_arr[_loc3]] = _loc2[_loc3];
                    } // end of for
                    if (_loc2[0] == "webAdd")
                    {
                        _root[_loc2[0]][brand_fieldnames_arr[1]] = _loc2[1];
                        _root[_loc2[0]][brand_fieldnames_arr[2]] = _loc2[2];
                        _root[_loc2[0]][brand_fieldnames_arr[3]] = _loc2[3];
                        if (_loc2.length > 5 && _loc2[5] != undefined)
                        {
                            _root[_loc2[0]][brand_fieldnames_arr[5]] = _loc2[5];
                        } // end if
                        if (_loc2.length > 6 && _loc2[6] != undefined)
                        {
                            _root[_loc2[0]][brand_fieldnames_arr[6]] = _loc2[6];
                        } // end if
                        if (_loc2.length > 7 && _loc2[7] != undefined)
                        {
                            _root[_loc2[0]][brand_fieldnames_arr[7]] = _loc2[7];
                        } // end if
                    }
                    else
                    {
                        _root[_loc2[0]].color = _loc2[1];
                        _root[_loc2[0]].size = _loc2[2];
                        _root[_loc2[0]].font = _loc2[3];
                        if (_loc2.length > 4 && _loc2[4] != undefined)
                        {
                            _root[_loc2[0]].align = _loc2[4].toLowerCase();
                        } // end if
                        if (_loc2.length > 5 && _loc2[5] != undefined)
                        {
                            _root[_loc2[0]].bold = convToBoolean(_loc2[5]);
                        } // end if
                        if (_loc2.length > 6 && _loc2[6] != undefined)
                        {
                            _root[_loc2[0]].italic = convToBoolean(_loc2[6]);
                        } // end if
                        if (_loc2.length > 7 && _loc2[7] != undefined)
                        {
                            _root[_loc2[0]].underline = convToBoolean(_loc2[7]);
                        } // end if
                    } // end else if
                    break;
                } 
            } // End of switch
            continue;
        } // end if
        brand_fieldnames_arr = _loc5[_loc4 + 1].split("|");
        ++_loc4;
    } // end of for
    crImg.drawCR(copyRt.color);
    mainScreenBack.drawMainScreen(Graphic_arr.mainScr.FillC, Graphic_arr.mainScr.FillA, Graphic_arr.mainScr.LineT, Graphic_arr.mainScr.LineC, Graphic_arr.mainScr.LineA);
    clearHist.clearHB.buttonUp.drawClearHUp(Button_arr.contUp.FillC, Button_arr.contUp.FillA);
    clearHist.clearHB.buttonOver.drawClearHO(Button_arr.contOver.FillC, Button_arr.contOver.FillA);
    clearHist.clearHB.buttonDown.drawClearHO(Button_arr.contDown.FillC, Button_arr.contDown.FillA);
    notepad.np_rsym.drawResizeSymbol(Graphic_arr.npRSym.FillC, Graphic_arr.npRSym.FillA);
    notepad._visible = false;
    show_load_status();
    load_stat = load_stat + ("Brand.ini Loaded in: " + getTimer() / 1000 + " sec.\n");
};
proploader.load(brandLoc + "properties.ini");
proploader.onData = function (dat)
{
    var _loc8 = dat.split("\r\n");
    if (_loc8.length == 1)
    {
        _loc8 = dat.split("\n");
    } // end if
    prop_fieldnames_arr = _loc8[0].split("|");
    var _loc9 = _loc8.length;
    for (var _loc3 = 1; _loc3 < _loc9; ++_loc3)
    {
        var _loc5 = _loc8[_loc3].split("|");
        properties_arr.push({});
        var _loc7 = _loc5.length;
        if (_loc7 > 2)
        {
            properties_arr[_loc3 - 1][prop_fieldnames_arr[0]] = _loc5[0];
            properties_arr[_loc3 - 1][prop_fieldnames_arr[1]] = new Array();
            for (var _loc2 = 1; _loc2 < _loc7; ++_loc2)
            {
                if (_loc5[_loc2] != "" || _loc5[_loc2] != undefined)
                {
                    _root[properties_arr[_loc3 - 1][prop_fieldnames_arr[0]]].push(_loc5[_loc2]);
                } // end if
            } // end of for
            continue;
        } // end if
        for (var _loc4 = 0; _loc4 < _loc7; ++_loc4)
        {
            properties_arr[_loc3 - 1][prop_fieldnames_arr[_loc4]] = _loc5[_loc4];
        } // end of for
        _root[properties_arr[_loc3 - 1][prop_fieldnames_arr[0]]] = properties_arr[_loc3 - 1][prop_fieldnames_arr[1]];
    } // end of for
    if (demo_msg == "" || demo_msg == undefined)
    {
        Message.Message.messageText_mc.labelField.text = "This feature is only available in full version only.  To order, please contact one of our training specialists at 877-752-5329 or visit us at www.makaucorp.com";
    }
    else
    {
        trace (Message.messageText_mc.labelField.text);
        Message.messageText_mc.labelField.text = demo_msg;
    } // end else if
    if (brandCopyRight == "" || brandCopyRight == undefined)
    {
        crImg._visible = false;
        brandCR._visible = false;
    } // end if
    if (brandWebAddress == "" || brandWebAddress == undefined)
    {
        brandWA._visible = false;
    } // end if
    if (showOutlineTimeCode == "" || showOutlineTimeCode == undefined)
    {
        showOutlineTimeCode = "yes";
    } // end if
    if (checkMark == "" || checkMark == undefined)
    {
        checkMark = "no";
    } // end if
    if (degRound == "" || degRound == undefined || isNaN(degRound))
    {
        degRound = 6;
    } // end if
    if (sTxtWidth == "" || sTxtWidth == undefined || isNaN(sTxtWidth))
    {
        sTxtWidth = 54;
    }
    else
    {
        sTxtWidth = Number(sTxtWidth);
    } // end else if
    if (docDir == "" || docDir == undefined)
    {
        docDir = "doc/";
    } // end if
    if (subTSpacer == undefined)
    {
        subTSpacer = "";
    } // end if
    if (subTxtLbl == "" || subTxtLbl == undefined)
    {
        subTxtLbl = "Text";
    } // end if
    if (regP_msg == "" || regP_msg == undefined)
    {
        regP_msg = "Click on the forward button to continue.";
    } // end if
    if (courseRet_txt == "" || courseRet_txt == undefined)
    {
        courseRet_txt = "Continue";
    } // end if
    if (show_courseRet == "" || show_courseRet == undefined)
    {
        show_courseRet = "no";
    } // end if
    if (qBeginBT == "" || qBeginBT == undefined)
    {
        qBeginBT = "Start";
    } // end if
    if (quiz_inst == undefined)
    {
        quiz_inst = "";
    } // end if
    if (typeof(docTarg) == "string")
    {
        docTarg = new Array();
    } // end if
    for (var _loc6 = 0; _loc6 < 4; ++_loc6)
    {
        if (docTarg[_loc6] == "" || docTarg[_loc6] == undefined)
        {
            switch (_loc6)
            {
                case 0:
                {
                    docTarg[_loc6] = "outlines";
                    break;
                } 
                case 1:
                {
                    docTarg[_loc6] = "workbook.swf";
                    break;
                } 
                case 2:
                {
                    docTarg[_loc6] = "exercises.swf";
                    break;
                } 
                case 3:
                {
                    docTarg[_loc6] = "glossary.swf";
                    break;
                } 
            } // End of switch
        } // end if
    } // end of for
    if (typeof(outDotProp) == "string" || typeof(outDotProp) == "undefined")
    {
        if (outDotProp.length > 0)
        {
            tempVal = outDotProp;
            outDotProp = new Array();
            outDotProp[0] = tempVal;
        }
        else
        {
            outDotProp = new Array();
        } // end if
    } // end else if
    if (outDotProp[0] == "" || outDotProp[0] == undefined || isNaN(outDotProp[0]))
    {
        outDotProp[0] = 7.500000E+000;
    } // end if
    if (outDotProp[1] == "" || outDotProp[1] == undefined || isNaN(outDotProp[1]))
    {
        outDotProp[1] = 16764006;
    } // end if
    if (typeof(tocDotProp) == "string" || typeof(tocDotProp) == "undefined")
    {
        if (tocDotProp.length > 0)
        {
            tempVal = tocDotProp;
            tocDotProp = new Array();
            tocDotProp[0] = tempVal;
        }
        else
        {
            tocDotProp = new Array();
        } // end if
    } // end else if
    if (tocDotProp[0] == "" || tocDotProp[0] == undefined || isNaN(tocDotProp[0]))
    {
        tocDotProp[0] = 7.500000E+000;
    } // end if
    if (tocDotProp[1] == "" || tocDotProp[1] == undefined || isNaN(tocDotProp[1]))
    {
        tocDotProp[1] = 3355494;
    } // end if
    if (ddTargInst == "" || ddTargInst == undefined)
    {
        ddTargInst = "Drag the appropriate answer HERE:";
    } // end if
    if (outIndent != "" || outIndent != undefined || !isNaN(Number(outIndent)))
    {
        outIndent = Number(outIndent);
    } // end if
    if (tocItemSpace != "" || tocItemSpace != undefined || !isNaN(Number(tocItemSpace)))
    {
        tocItemSpace = Number(tocItemSpace);
    } // end if
    if ((tocCont1st != "" || tocCont1st != undefined) && tocCont1st.substr(0, 1).toLowerCase() == "t")
    {
        tocCont1st = true;
    }
    else
    {
        tocCont1st = false;
    } // end else if
    if (titleNudge != "" || titleNudge != undefined || !isNaN(Number(titleNudge)))
    {
        titleNudge = Number(titleNudge);
        maintitle._y = titleNudge;
    } // end if
    trace ("subTNudge[0] = " + subTNudge[0]);
    if (subTNudge[0] != "" || subTNudge[0] != undefined || !isNaN(Number(subTNudge[0])))
    {
        subTNudge[0] = Number(subTNudge[0]);
        titleInd._x = subTNudge[0];
    }
    else
    {
        titleInd._x = 9.800000E+000;
    } // end else if
    trace ("subTNudge[1] = " + subTNudge[1]);
    if (subTNudge[1] != "" || subTNudge[1] != undefined || !isNaN(Number(subTNudge[1])))
    {
        subTNudge[1] = Number(subTNudge[1]);
        titleInd._y = subTNudge[1];
    }
    else
    {
        titleInd._y = 6.510000E+001;
    } // end else if
    if (tocNudge != "" || tocNudge != undefined || !isNaN(Number(tocNudge)))
    {
        tocNudge = Number(tocNudge);
        bookMTitle._x = bookMTitle._x + tocNudge;
        bookM_list._x = bookM_list._x + tocNudge;
        bookM_add._x = bookM_add._x + tocNudge;
        bookM_goto._x = bookM_goto._x + tocNudge;
        bookM_del._x = bookM_del._x + tocNudge;
        clearHist._x = clearHist._x + tocNudge;
        quitButton._x = quitButton._x + tocNudge;
    } // end if
    brandCR.autoSize = "left";
    brandWA.autoSize = "left";
    _root.brandCR.text = brandCopyRight;
    _root.brandCR.setTextFormat(copyRt);
    _root.brandWA.htmlText = "<font size=\'" + webAdd.Size + "\' color=\'" + webAdd.Color + "\' face=\'" + webAdd.Font + "\'" + "><p align=\"right\"><a href=\"http://" + brandWebAddress + "\" onClick=\"window.open(" + "\'" + "http://" + brandWebAddress + "\'" + ", " + "\'" + "Company Website" + "\'" + ", " + "\'" + "width=400,height=200,scrollbars=yes" + "\'); return false;" + "\">" + brandWebAddress + "</a></p></font>";
    if (convToBoolean(webAdd.Bold))
    {
        _root.brandWA.htmlText = "<b>" + _root.brandWA.htmlText + "</b>";
    } // end if
    if (convToBoolean(webAdd.Italic))
    {
        _root.brandWA.htmlText = "<i>" + _root.brandWA.htmlText + "</i>";
    } // end if
    if (convToBoolean(webAdd.Underline))
    {
        _root.brandWA.htmlText = "<u>" + _root.brandWA.htmlText + "</u>";
    } // end if
    brandCR._y = crImg._y + crImg._height / 2 - brandCR._height / 2;
    brandWA._y = crImg._y + crImg._height / 2 - brandWA._height / 2;
    degRound = Number(degRound);
    _root.setStyle("themeColor", thmColor);
    quitButton.quitB.buttonUp.drawQuitUp(Button_arr.contUp.FillC, Button_arr.contUp.FillA);
    quitButton.quitB.buttonOver.drawQuitO(Button_arr.contOver.FillC, Button_arr.contOver.FillA);
    quitButton.quitB.buttonDown.drawQuitO(Button_arr.contDown.FillC, Button_arr.contDown.FillA);
    _root.setStyle("color", ansTxt.color);
    if (clearH_txt == "" || clearH_txt == undefined)
    {
        clearH_txt = "Clear History";
    } // end if
    clearHist.clearHB.tocUpText.text = clearH_txt;
    clearHist.clearHB.tocOverText.text = clearH_txt;
    clearHist.clearHB.tocDownText.text = clearH_txt;
    clearHist.clearHB.tocUpText.setTextFormat(contUp);
    clearHist.clearHB.tocOverText.setTextFormat(contOver);
    clearHist.clearHB.tocDownText.setTextFormat(contDown);
    if (quit_txt == "" || quit_txt == undefined)
    {
        quit_txt = "Quit";
    } // end if
    quitButton.quitB.tocUpText.text = quit_txt;
    quitButton.quitB.tocOverText.text = quit_txt;
    quitButton.quitB.tocDownText.text = quit_txt;
    quitButton.quitB.tocUpText.setTextFormat(contUp);
    quitButton.quitB.tocOverText.setTextFormat(contOver);
    quitButton.quitB.tocDownText.setTextFormat(contDown);
    if (typeof(bookNames) == "string")
    {
        bookNames = new Array();
    } // end if
    if (bookNames[0] == "" || bookNames[0] == undefined)
    {
        bookNames[0] = "Bookmarks";
    } // end if
    bookMTitle.text = bookNames[0];
    bookMTitle.setTextFormat(bookmarks);
    notepad.close_B.npcb_up.drawNotepadClose(_root.Button_arr.closeUp.FillC, _root.Button_arr.closeUp.FillA, _root.Button_arr.closeUp.LineT, _root.Button_arr.closeUp.LineC, _root.Button_arr.closeUp.LineA);
    notepad.close_B.npcb_over.drawNotepadClose(_root.Button_arr.closeOver.FillC, _root.Button_arr.closeOver.FillA, _root.Button_arr.closeOver.LineT, _root.Button_arr.closeOver.LineC, _root.Button_arr.closeOver.LineA);
    if (storeTxt == "" || storeTxt == undefined)
    {
        storeTxt = "Store";
    } // end if
    notepad.store_B.storeButton.bmB.bookTUp.text = storeTxt;
    notepad.store_B.storeButton.bmB.bookTOver.text = storeTxt;
    notepad.store_B.storeButton.bmB.bookTDown.text = storeTxt;
    notepad.store_B.bookMBDis.bookMDis.text = storeTxt;
    notepad.store_B.storeButton.bmB.bookTUp.setTextFormat(bookMUp);
    notepad.store_B.storeButton.bmB.bookTOver.setTextFormat(storOver);
    notepad.store_B.storeButton.bmB.bookTDown.setTextFormat(bookMDown);
    notepad.store_B.bookMBDis.bookMDis.setTextFormat(bookMDis);
    notepad.store_B.storeButton.bmB.bookMB.drawBookMButtons(_root.Button_arr.storeOver.FillC, _root.Button_arr.storeOver.FillA, _root.Button_arr.storeOver.LineT, _root.Button_arr.storeOver.LineC, _root.Button_arr.storeOver.LineA);
    notepad.store_B.bookMBDis.disBookM.drawDisabledBookM(_root.Button_arr.bookDis.FillC, _root.Button_arr.bookDis.FillA, _root.Button_arr.bookDis.LineT, _root.Button_arr.bookDis.LineC, _root.Button_arr.bookDis.LineA);
    if (prntTxt == "" || prntTxt == undefined)
    {
        prntTxt = "Print";
    } // end if
    notepad.print_B.printButton.bmB.bookTUp.text = prntTxt;
    notepad.print_B.printButton.bmB.bookTOver.text = prntTxt;
    notepad.print_B.printButton.bmB.bookTDown.text = prntTxt;
    notepad.print_B.bookMBDis.bookMDis.text = prntTxt;
    notepad.print_B.printButton.bmB.bookTUp.setTextFormat(bookMUp);
    notepad.print_B.printButton.bmB.bookTOver.setTextFormat(prntOver);
    notepad.print_B.printButton.bmB.bookTDown.setTextFormat(bookMDown);
    notepad.print_B.bookMBDis.bookMDis.setTextFormat(bookMDis);
    notepad.print_B.printButton.bmB.bookMB.drawBookMButtons(_root.Button_arr.prntOver.FillC, _root.Button_arr.prntOver.FillA, _root.Button_arr.prntOver.LineT, _root.Button_arr.prntOver.LineC, _root.Button_arr.prntOver.LineA);
    notepad.print_B.bookMBDis.disBookM.drawDisabledBookM(_root.Button_arr.bookDis.FillC, _root.Button_arr.bookDis.FillA, _root.Button_arr.bookDis.LineT, _root.Button_arr.bookDis.LineC, _root.Button_arr.bookDis.LineA);
    if (noteTxt == "" || noteTxt == undefined)
    {
        noteTxt = "Notes";
    } // end if
    notes_btn.notesButton.bmB.bookTUp.text = noteTxt;
    notes_btn.notesButton.bmB.bookTOver.text = noteTxt;
    notes_btn.notesButton.bmB.bookTDown.text = noteTxt;
    notes_btn.bookMBDis.bookMDis.text = noteTxt;
    notes_btn.notesButton.bmB.bookTUp.setTextFormat(bookMUp);
    notes_btn.notesButton.bmB.bookTOver.setTextFormat(noteOver);
    notes_btn.notesButton.bmB.bookTDown.setTextFormat(bookMDown);
    notes_btn.bookMBDis.bookMDis.setTextFormat(bookMDis);
    notes_btn.notesButton.bmB.bookMB.drawBookMButtons(_root.Button_arr.noteOver.FillC, _root.Button_arr.noteOver.FillA, _root.Button_arr.noteOver.LineT, _root.Button_arr.noteOver.LineC, _root.Button_arr.noteOver.LineA);
    notes_btn.bookMBDis.disBookM.drawDisabledBookM(_root.Button_arr.bookDis.FillC, _root.Button_arr.bookDis.FillA, _root.Button_arr.bookDis.LineT, _root.Button_arr.bookDis.LineC, _root.Button_arr.bookDis.LineA);
    notepad.np_title.text = noteTxt;
    notepad.np_title.setTextFormat(npTitle);
    if (returnTxt == "" || returnTxt == undefined)
    {
        returnTxt = "Return";
    } // end if
    return_btn.returnButton.bmB.bookTUp.text = returnTxt;
    return_btn.returnButton.bmB.bookTOver.text = returnTxt;
    return_btn.returnButton.bmB.bookTDown.text = returnTxt;
    return_btn.returnButton.bmB.bookTUp.setTextFormat(bookMUp);
    return_btn.returnButton.bmB.bookTOver.setTextFormat(retOver);
    return_btn.returnButton.bmB.bookTDown.setTextFormat(bookMDown);
    return_btn._visible = false;
    return_btn.returnButton.bmB.bookMB.drawBookMButtons(_root.Button_arr.retOver.FillC, _root.Button_arr.retOver.FillA, _root.Button_arr.retOver.LineT, _root.Button_arr.retOver.LineC, _root.Button_arr.retOver.LineA);
    if (bookNames[1] == "" || bookNames[1] == undefined)
    {
        bookNames[1] = "Add";
    } // end if
    bookM_add.addButton.bmB.bookTUp.text = bookNames[1];
    bookM_add.addButton.bmB.bookTOver.text = bookNames[1];
    bookM_add.addButton.bmB.bookTDown.text = bookNames[1];
    bookM_add.bookMBDis.bookMDis.text = bookNames[1];
    bookM_add.addButton.bmB.bookTUp.setTextFormat(bookMUp);
    bookM_add.addButton.bmB.bookTOver.setTextFormat(addOver);
    bookM_add.addButton.bmB.bookTDown.setTextFormat(bookMDown);
    bookM_add.bookMBDis.bookMDis.setTextFormat(bookMDis);
    if (bookNames[2] == "" || bookNames[2] == undefined)
    {
        bookNames[2] = "Go To";
    } // end if
    bookM_goto.gotoButton.bmB.bookTUp.text = bookNames[2];
    bookM_goto.gotoButton.bmB.bookTOver.text = bookNames[2];
    bookM_goto.gotoButton.bmB.bookTDown.text = bookNames[2];
    bookM_goto.bookMBDis.bookMDis.text = bookNames[2];
    bookM_goto.gotoButton.bmB.bookTUp.setTextFormat(bookMUp);
    bookM_goto.gotoButton.bmB.bookTOver.setTextFormat(gotoOver);
    bookM_goto.gotoButton.bmB.bookTDown.setTextFormat(bookMDown);
    bookM_goto.bookMBDis.bookMDis.setTextFormat(bookMDis);
    if (bookNames[3] == "" || bookNames[3] == undefined)
    {
        bookNames[3] = "Delete";
    } // end if
    bookM_del.delButton.bmB.bookTUp.text = bookNames[3];
    bookM_del.delButton.bmB.bookTOver.text = bookNames[3];
    bookM_del.delButton.bmB.bookTDown.text = bookNames[3];
    bookM_del.bookMBDis.bookMDis.text = bookNames[3];
    bookM_del.delButton.bmB.bookTUp.setTextFormat(bookMUp);
    bookM_del.delButton.bmB.bookTOver.setTextFormat(delOver);
    bookM_del.delButton.bmB.bookTDown.setTextFormat(bookMDown);
    bookM_del.bookMBDis.bookMDis.setTextFormat(bookMDis);
    bookM_add.addButton.bmB.bookMB.drawBookMButtons(_root.Button_arr.addOver.FillC, _root.Button_arr.addOver.FillA, _root.Button_arr.addOver.LineT, _root.Button_arr.addOver.LineC, _root.Button_arr.addOver.LineA);
    bookM_add.bookMBDis.disBookM.drawDisabledBookM(_root.Button_arr.bookDis.FillC, _root.Button_arr.bookDis.FillA, _root.Button_arr.bookDis.LineT, _root.Button_arr.bookDis.LineC, _root.Button_arr.bookDis.LineA);
    bookM_goto.gotoButton.bmB.bookMB.drawBookMButtons(_root.Button_arr.gotoOver.FillC, _root.Button_arr.gotoOver.FillA, _root.Button_arr.gotoOver.LineT, _root.Button_arr.gotoOver.LineC, _root.Button_arr.gotoOver.LineA);
    bookM_goto.bookMBDis.disBookM.drawDisabledBookM(_root.Button_arr.bookDis.FillC, _root.Button_arr.bookDis.FillA, _root.Button_arr.bookDis.LineT, _root.Button_arr.bookDis.LineC, _root.Button_arr.bookDis.LineA);
    bookM_del.delButton.bmB.bookMB.drawBookMButtons(_root.Button_arr.delOver.FillC, _root.Button_arr.delOver.FillA, _root.Button_arr.delOver.LineT, _root.Button_arr.delOver.LineC, _root.Button_arr.delOver.LineA);
    bookM_del.bookMBDis.disBookM.drawDisabledBookM(_root.Button_arr.bookDis.FillC, _root.Button_arr.bookDis.FillA, _root.Button_arr.bookDis.LineT, _root.Button_arr.bookDis.LineC, _root.Button_arr.bookDis.LineA);
    show_load_status();
    load_stat = load_stat + ("Properties.ini Loaded in: " + getTimer() / 1000 + " sec.\n");
};
setloader.load("dat/settings.ini");
setloader.onData = function (dat)
{
    var _loc7 = dat.split("\r\n");
    if (_loc7.length == 1)
    {
        _loc7 = dat.split("\n");
    } // end if
    set_fieldnames_arr = _loc7[0].split("|");
    var _loc8 = _loc7.length;
    for (var _loc2 = 1; _loc2 < _loc8; ++_loc2)
    {
        var _loc5 = _loc7[_loc2].split("|");
        settings_arr.push({});
        var _loc6 = _loc5.length;
        if (_loc6 > 2)
        {
            settings_arr[_loc2 - 1][set_fieldnames_arr[0]] = _loc5[0];
            settings_arr[_loc2 - 1][set_fieldnames_arr[1]] = new Array();
            for (var _loc4 = 1; _loc4 < _loc6; ++_loc4)
            {
                _root[settings_arr[_loc2 - 1][set_fieldnames_arr[0]]].push(_loc5[_loc4]);
            } // end of for
            continue;
        } // end if
        for (var _loc3 = 0; _loc3 < _loc6; ++_loc3)
        {
            settings_arr[_loc2 - 1][set_fieldnames_arr[_loc3]] = _loc5[_loc3];
        } // end of for
        _root[settings_arr[_loc2 - 1][set_fieldnames_arr[0]]] = settings_arr[_loc2 - 1][set_fieldnames_arr[1]];
    } // end of for
    if (cacheName == "" || cacheName == undefined)
    {
        cacheName = "default";
    } // end if
    if (cohesiveBlock == "" || cohesiveBlock == undefined)
    {
        cohesiveBlock = "yes";
    } // end if
    if (paragraphSpace == "" || paragraphSpace == undefined || isNaN(Number(paragraphSpace)))
    {
        paragraphSpace = 1;
    }
    else
    {
        paragraphSpace = Number(paragraphSpace);
    } // end else if
    if (subjSpace == "" || subjSpace == undefined || isNaN(Number(subjSpace)))
    {
        subjSpace = 20;
    }
    else
    {
        subjSpace = Number(subjSpace);
    } // end else if
    if (subjLimit == "" || subjLimit == undefined || isNaN(Number(subjLimit)))
    {
        subjLimit = 6;
    }
    else
    {
        subjLimit = Number(subjLimit);
    } // end else if
    if (initCol == "" || initCol == undefined || isNaN(Number(initCol)))
    {
        initCol = 2;
    }
    else
    {
        initCol = Number(initCol);
    } // end else if
    if (initSec == "" || initSec == undefined || isNaN(Number(initSec)))
    {
        initSec = 1;
    }
    else
    {
        initSec = Number(initSec);
    } // end else if
    if (showStudyG.toLowerCase() == "no")
    {
        button101._visible = false;
    } // end if
    if (showExercise.toLowerCase() == "no")
    {
        button102._visible = false;
    } // end if
    if (showGloss.toLowerCase() == "no")
    {
        button103._visible = false;
    } // end if
    if (version != "")
    {
        _root.verNum.text = "Version " + version;
        _root.verNum.setTextFormat(verStyle);
    } // end if
    outItemW = (mainScreenBack._width - wOut.oElem0.oText._x * initCol - subjSpace * (initCol + 1)) / initCol;
    maintitle.setTextFormat(mainTtl);
    show_load_status();
    load_stat = load_stat + ("Settings.ini Loaded in: " + getTimer() / 1000 + " sec.\n");
};
temploader.load(brandLoc + "templates.ini");
temploader.onData = function (dat)
{
    var _loc3 = dat.split("\r\n");
    if (_loc3.length == 1)
    {
        _loc3 = dat.split("\n");
    } // end if
    var _loc4 = _loc3.length;
    for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
    {
        var _loc2 = _loc3[_loc1].split("|");
        templates_arr[_loc2[0]] = _loc2.slice(1);
    } // end of for
    show_load_status();
    load_stat = load_stat + ("Templates.ini Loaded in: " + getTimer() / 1000 + " sec.\n");
};
docloader.load("dat/doc.ini");
docloader.onData = function (dat)
{
    var _loc5 = dat.split("\r\n");
    if (_loc5.length == 1)
    {
        _loc5 = dat.split("\n");
    } // end if
    doc_fieldnames_arr = _loc5[0].split("|");
    var _loc6 = _loc5.length;
    for (var _loc2 = 1; _loc2 < _loc6; ++_loc2)
    {
        var _loc3 = _loc5[_loc2].split("|");
        doc_arr.push({});
        var _loc4 = _loc3.length;
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            doc_arr[_loc2 - 1][doc_fieldnames_arr[_loc1]] = _loc3[_loc1];
        } // end of for
    } // end of for
    show_load_status();
};
objloader.load("dat/objects.ini");
objloader.onData = function (dat)
{
    var _loc23 = dat.split("\r\n");
    if (_loc23.length == 1)
    {
        _loc23 = dat.split("\n");
    } // end if
    obj_fieldnames_arr = _loc23[0].split("|");
    var _loc25 = _loc23.length;
    for (var _loc14 = 1; _loc14 < _loc25; ++_loc14)
    {
        var _loc5 = _loc23[_loc14].split("|");
        objects_set.addProperty(_loc5[0]);
        objects_set[_loc5[0]] = new Array();
        var _loc16 = _loc5.length;
        for (var _loc4 = 1; _loc4 < _loc16; ++_loc4)
        {
            if (_loc5[_loc4].indexOf(",") == -1)
            {
                objects_set[_loc5[0]][obj_fieldnames_arr[_loc4]] = _loc5[_loc4];
                continue;
            } // end if
            objects_set[_loc5[0]][obj_fieldnames_arr[_loc4]] = new Array();
            objects_set[_loc5[0]][obj_fieldnames_arr[_loc4]] = _loc5[_loc4].split(",");
        } // end of for
        if (objects_set[_loc5[0]].Active == 1)
        {
            genericloader.load("dat/" + _loc5[0] + ".ini");
        } // end if
    } // end of for
    genericloader.onData = function (dat)
    {
        var _loc9 = dat.split("\r\n");
        if (_loc9.length == 1)
        {
            _loc9 = dat.split("\n");
        } // end if
        var _loc17 = false;
        var _loc15 = false;
        var _loc4 = "";
        var _loc2 = _loc9[0];
        var _loc21 = false;
        var _loc16 = false;
        var _loc18 = false;
        var _loc8 = 0;
        var _loc13 = 0;
        var _loc14 = 0;
        _root[_loc2] = new Array();
        var _loc19 = _loc9.length;
        for (var _loc7 = 1; _loc7 < _loc19; ++_loc7)
        {
            if (_loc17)
            {
                _loc4 = _loc9[_loc7];
                _root[_loc2][_loc4] = new Array();
                _loc17 = false;
                if (objects_set[_loc2].Element.length != 0)
                {
                    _loc13 = 0;
                    _root[_loc2][_loc4].Element = new Array();
                } // end if
                if (objects_set[_loc2].Subject.length != 0)
                {
                    _loc8 = 0;
                    _root[_loc2][_loc4].Subject = new Array();
                } // end if
                if (objects_set[_loc2].Attribute.length != 0)
                {
                    _loc15 = true;
                } // end if
                continue;
            } // end if
            if (_loc9[_loc7] == "-" || _loc9[_loc7] == undefined)
            {
                _loc17 = true;
                continue;
            } // end if
            if (_loc9[_loc7] == "+")
            {
                _loc18 = true;
                ++_loc8;
                _root[_loc2][_loc4].Subject[_loc8] = new Array();
                _root[_loc2][_loc4].Subject[_loc8].Topic = new Array();
                _loc14 = 0;
                if (objects_set[_loc2].Subject.length != 0 && objects_set[_loc2].Subject != undefined)
                {
                    _loc16 = true;
                } // end if
                continue;
            } // end if
            var _loc3 = _loc9[_loc7].split("|");
            if (_loc15)
            {
                var _loc12 = _loc3.length;
                for (var _loc5 = 0; _loc5 < _loc12; ++_loc5)
                {
                    _root[_loc2][_loc4][objects_set[_loc2].Attribute[_loc5]] = _loc3[_loc5];
                } // end of for
                _loc15 = false;
                continue;
            } // end if
            if (_loc16)
            {
                _loc12 = _loc3.length;
                for (var _loc5 = 0; _loc5 < _loc12; ++_loc5)
                {
                    _root[_loc2][_loc4].Subject[_loc8][objects_set[_loc2].Subject[_loc5]] = _loc3[_loc5];
                } // end of for
                _loc16 = false;
                continue;
            } // end if
            if (_loc18)
            {
                var _loc10 = new Array();
                _loc12 = _loc3.length;
                for (var _loc5 = 0; _loc5 < _loc12; ++_loc5)
                {
                    if (objects_set[_loc2].Topic[_loc5] == "range")
                    {
                        var _loc6 = _loc3[_loc5];
                        _loc3[_loc5] = new Array();
                        if (isNaN(Number(_loc6)))
                        {
                            _loc3[_loc5] = parse_range(_loc6);
                        }
                        else
                        {
                            _loc3[_loc5][0] = Number(_loc6);
                        } // end if
                    } // end else if
                    _loc10[objects_set[_loc2].Topic[_loc5]] = _loc3[_loc5];
                } // end of for
                _root[_loc2][_loc4].Subject[_loc8].Topic[_loc14] = _loc10;
                ++_loc14;
                continue;
            } // end if
            var _loc11 = new Array();
            _loc12 = _loc3.length;
            for (var _loc5 = 0; _loc5 < _loc12; ++_loc5)
            {
                _loc11[objects_set[_loc2].Element[_loc5]] = _loc3[_loc5];
            } // end of for
            _root[_loc2][_loc4].Element[_loc13] = _loc11;
            ++_loc13;
        } // end of for
        if (_loc2 == "outlines")
        {
            for (outs in _root.outlines)
            {
                construct_outline(outs);
            } // end of for...in
        } // end if
    };
    show_load_status();
    load_stat = load_stat + ("Objects.ini Loaded in: " + getTimer() / 1000 + " sec.\n");
};
arrayloader.load("dat/array.ini");
arrayloader.onData = function (dat)
{
    var _loc5 = dat.split("\r\n");
    if (_loc5.length == 1)
    {
        _loc5 = dat.split("\n");
    } // end if
    var _loc6 = _loc5.length;
    for (var _loc2 = 0; _loc2 < _loc6; ++_loc2)
    {
        var _loc3 = _loc5[_loc2].split("|");
        array_list[_loc2] = new Array();
        array_list[_loc2].template = _loc3[0];
        var _loc4 = templates_arr[_loc3[0]].length;
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            array_list[_loc2][templates_arr[_loc3[0]][_loc1]] = _loc3[_loc1 + 1];
        } // end of for
    } // end of for
    show_load_status();
    load_stat = load_stat + ("Array.ini Loaded in: " + getTimer() / 1000 + " sec.\n");
};
if (head_graphic != "" && head_graphic != undefined)
{
    headGraphic_ph.loadMovie(head_graphic);
} // end if
toc_mc.tocIB._visible = false;

// [Action in Frame 4]
stop ();

// [Action in Frame 5]
construct_toc();
stop ();

// [Action in Frame 6]
switch (introMedia.substr(introMedia.lastIndexOf(".") + 1).toLowerCase())
{
    case "flv":
    {
        IntroMov.setMedia(brandLoc + introMedia);
        swfIntro.gotoAndStop(1);
        swfIntro._visible = false;
        imgIntro.gotoAndStop(1);
        imgIntro._visible = false;
        noIntro.gotoAndStop(1);
        noIntro._visible = false;
        break;
    } 
    case "swf":
    {
        var introLoader = new MovieClipLoader();
        var introListener = new Object();
        imgIntro.gotoAndStop(1);
        imgIntro._visible = false;
        noIntro.gotoAndStop(1);
        noIntro._visible = false;
        introListener.onLoadInit = function (target_mc)
        {
            target_mc._x = -target_mc._width / 2;
            target_mc._y = -target_mc._height / 2;
        };
        introLoader.addListener(introListener);
        introLoader.loadClip(brandLoc + introMedia, swfIntro.altIntro_ph);
        break;
    } 
    case "jpg":
    {
        var introLoader = new MovieClipLoader();
        var introListener = new Object();
        swfIntro.gotoAndStop(1);
        swfIntro._visible = false;
        noIntro.gotoAndStop(1);
        noIntro._visible = false;
        introListener.onLoadInit = function (target_mc)
        {
            target_mc._x = -target_mc._width / 2;
            target_mc._y = -target_mc._height / 2;
        };
        introLoader.addListener(introListener);
        introLoader.loadClip(brandLoc + introMedia, imgIntro.imgFade.altIntro_ph);
        break;
    } 
    default:
    {
        swfIntro._visible = false;
        imgIntro._visible = false;
        noIntro.gotoAndPlay(1);
    } 
} // End of switch

// [Action in Frame 7]
stop ();

// [Action in Frame 9]
curr_clip = 0;
set_curr_outline(toc_arr.Supp[curr_topic].Obj, curr_topic);
if (curr_outline == main_out)
{
    return_btn._visible = false;
}
else
{
    return_btn._visible = true;
} // end else if
out_obj["w_" + curr_outline]._visible = true;
out_obj["w_" + curr_outline]._x = outlines[curr_outline].x_pos;
_root.bookM_add.gotoAndStop("disable");
_root.titleInd.text = toc_arr.Supp[curr_topic].Name;
_root.titleInd.setTextFormat(subTtl);
if (_global.trackObj.data.bookM.length > 0)
{
    _root.bookM_goto.gotoAndStop("enable");
    _root.bookM_del.gotoAndStop("enable");
    _root.bookM_add.gotoAndStop("disable");
} // end if
toc_mc["toc_s" + curr_topic].gotoAndStop("disable");
trace ("toc_mc[toc_s" + curr_topic + "]._currentframe = " + toc_mc["toc_s" + curr_topic]._currentframe);
stop ();
clearInterval(_root.intervalID);
stop ();

// [Action in Frame 10]
function callback()
{
    if (_root.HeadMov.playheadTime > 2 && _root.HeadMov.bytesLoaded == _root.HeadMov.bytesTotal)
    {
        _root.rEnd = 0;
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1 && !_root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 60);
            _root.near_end = true;
        } // end if
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime > 1 && _root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 1000);
            _root.near_end = false;
        } // end if
        if (_root.near_end && _root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E-001;
        }
        else if (_root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E+000;
        } // end else if
        if (time_played > 1.130000E+000)
        {
            if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1.100000E-001)
            {
                _root.rEnd = 1;
                if (!pause_media)
                {
                    _root.nextload();
                }
                else if (_root.fftoggle._currentframe == 1)
                {
                    if (part_vids.length > 1 && part_vid_count < part_vids.length)
                    {
                        play_otherVid();
                    }
                    else
                    {
                        _root.fftoggle.gotoAndPlay(2);
                        HeadMov.pause();
                    } // end if
                } // end else if
            } // end else if
            if (!_root.user_pause)
            {
                if (_root.oPlaytime == _root.HeadMov.playheadTime)
                {
                    _root.rEnd = 1;
                    if (!pause_media)
                    {
                        _root.nextload();
                    }
                    else if (_root.fftoggle._currentframe == 1)
                    {
                        if (part_vids.length > 1 && part_vid_count < part_vids.length)
                        {
                            play_otherVid();
                        }
                        else
                        {
                            _root.fftoggle.gotoAndPlay(2);
                            HeadMov.pause();
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end else if
    } // end else if
    if (resume_time != 0)
    {
        if (resume_time / _root.HeadMov.totalTime > 9.500000E-001)
        {
            _root.oPlaytime = _root.HeadMov.playheadTime;
            resume_time = 0;
        }
        else
        {
            _root.HeadMov.playheadTime = resume_time;
            resume_time = 0;
        } // end else if
    }
    else
    {
        _root.oPlaytime = _root.HeadMov.playheadTime;
    } // end else if
} // End of the function
HeadMov._x = 244;
HeadMov._y = 2.732000E+002;
_root.fftoggle.gotoAndStop(1);
_root["mc_pVideo" + _root.selected_part].p_button.enabled = true;
_root["mc_pVideo" + _root.selected_part].gray_mask._visible = true;
_root.near_end = false;
_root.bookM_add.gotoAndStop("enable");
if (_global.trackObj.data.bookM.length > 0)
{
    _root.bookM_goto.gotoAndStop("enable");
    _root.bookM_del.gotoAndStop("enable");
} // end if
forward_click = false;
support_text.sub_text.text = "";
if (subtext[array_list[curr_index].subtxt].Element.length > 0)
{
    support_text._visible = true;
    var t = 0;
    while (t < subtext[array_list[curr_index].subtxt].Element.length)
    {
        support_text.sub_text.text = support_text.sub_text.text + ("\t" + subtext[array_list[curr_index].subtxt].Element[t].content + "\r\r");
        ++t;
    } // end while
    support_text.sub_text.setTextFormat(subttxt);
    if (_global.trackObj.data.st_state == "" || _global.trackObj.data.st_state == undefined)
    {
        if (array_list[curr_index].stip.substr(0, 1).toLowerCase() == "u")
        {
            support_text.gotoAndStop("line");
            support_text.resize_up = true;
        }
        else
        {
            support_text.gotoAndStop("min");
            support_text.resize_up = true;
        } // end else if
    }
    else
    {
        support_text.gotoAndStop(_global.trackObj.data.st_state);
        support_text.resize_up = true;
    } // end else if
}
else
{
    support_text._visible = false;
} // end else if
time_played = 0;
var time_diff = 1.000000E-003;
if (resume_time > time_diff)
{
    _root.oPlaytime = resume_time - time_diff;
}
else
{
    _root.oPlaytime = 0;
} // end else if
clearInterval(_root.intervalID);
_root.HeadMov.clear();
if ("shots/" + array_list[curr_index].file + ".flv" != _root.HeadMov.contentPath)
{
    if (curr_template.substr(0, 3).toLowerCase() != "aud")
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".flv", "FLV");
    }
    else
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".mp3", "MP3");
    } // end if
} // end else if
_root.HeadMov.play();
_root.intervalID = setInterval(callback, 1000);
var cue_name = array_list[curr_index].cues;
if (cue_name != "" && cue_name != undefined)
{
    _root.HeadMov.addEventListener("cuePoint", myCuePointListener);
    var e = 0;
    while (e < cues[cue_name].Element.length)
    {
        _root.HeadMov.addCuePoint(cues[cue_name].Element[e].name, Number(cues[cue_name].Element[e].time));
        ++e;
    } // end while
} // end if

// [Action in Frame 13]
callback();

// [Action in Frame 14]
stop ();

// [Action in Frame 15]
function callback()
{
    if (_root.HeadMov.playheadTime > 2 && _root.HeadMov.bytesLoaded == _root.HeadMov.bytesTotal)
    {
        _root.rEnd = 0;
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1 && !_root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 60);
            _root.near_end = true;
        } // end if
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime > 1 && _root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 1000);
            _root.near_end = false;
        } // end if
        if (_root.near_end && _root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E-001;
        }
        else if (_root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E+000;
        } // end else if
        if (time_played > 1.130000E+000)
        {
            if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1.100000E-001)
            {
                _root.rEnd = 1;
                if (!pause_media)
                {
                    _root.nextload();
                }
                else if (_root.fftoggle._currentframe == 1)
                {
                    if (part_vids.length > 1 && part_vid_count < part_vids.length)
                    {
                        play_otherVid();
                    }
                    else
                    {
                        _root.fftoggle.gotoAndPlay(2);
                        HeadMov.pause();
                    } // end if
                } // end else if
            } // end else if
            if (!_root.user_pause)
            {
                if (_root.oPlaytime == _root.HeadMov.playheadTime)
                {
                    _root.rEnd = 1;
                    if (!pause_media)
                    {
                        _root.nextload();
                    }
                    else if (_root.fftoggle._currentframe == 1)
                    {
                        if (part_vids.length > 1 && part_vid_count < part_vids.length)
                        {
                            play_otherVid();
                        }
                        else
                        {
                            _root.fftoggle.gotoAndPlay(2);
                            HeadMov.pause();
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end else if
    } // end else if
    if (resume_time != 0)
    {
        if (resume_time / _root.HeadMov.totalTime > 9.500000E-001)
        {
            _root.oPlaytime = _root.HeadMov.playheadTime;
            resume_time = 0;
        }
        else
        {
            _root.HeadMov.playheadTime = resume_time;
            resume_time = 0;
        } // end else if
    }
    else
    {
        _root.oPlaytime = _root.HeadMov.playheadTime;
    } // end else if
} // End of the function
function goto_page(page_index)
{
    if (pages[page_info].Element[page_index].zoom == undefined || pages[page_info].Element[page_index].zoom == "")
    {
        zoom_pref = 100;
    }
    else
    {
        zoom_pref = pages[page_info].Element[page_index].zoom;
    } // end else if
    change_title = true;
    marked_page = pages[page_info].Element[page_index].page;
    viewing_page = true;
    set_return_point(HeadMov.playheadTime);
    if (!isNaN(Number(pages[page_info].Element[page_index].doc_index)))
    {
        play_topic(0, Number(pages[page_info].Element[page_index].doc_index));
        start_point[0] = 0;
        start_point[1] = Number(pages[page_info].Element[page_index].doc_index);
    }
    else
    {
        var _loc1 = new Array();
        _loc1 = pages[page_info].Element[page_index].doc_index.split(",");
        set_curr_outline(toc_arr.Supp[Number(_loc1[0])].Obj, Number(_loc1[0]));
        find_place(Number(_loc1[1]), Number(_loc1[2]));
        play_topic(Number(_loc1[1]), Number(_loc1[2]));
        start_point[0] = Number(_loc1[1]);
        start_point[1] = Number(_loc1[2]);
    } // end else if
} // End of the function
function play_part(part_index)
{
    part_vids = new Array();
    part_cues = new Array();
    part_subtxt = new Array();
    if (participants[part_info].Element[part_index - 1].clip.indexOf(",") == -1)
    {
        part_vids[0] = participants[part_info].Element[part_index - 1].clip;
    }
    else
    {
        part_vids = participants[part_info].Element[part_index - 1].clip.split(",");
        part_vid_count = 1;
    } // end else if
    if ("shots/" + part_vids[0] + ".flv" != _root.HeadMov.contentPath)
    {
        _root.HeadMov.setMedia("shots/" + part_vids[0] + ".flv", "FLV");
        _root.HeadMov.play(0);
        HeadMov.removeAllCuePoints();
        no_cues = true;
        if (participants[part_info].Element[part_index - 1].cues.indexOf(",") == -1)
        {
            part_cues[0] = participants[part_info].Element[part_index - 1].cues;
        }
        else
        {
            part_cues = participants[part_info].Element[part_index - 1].cues.split(",");
        } // end else if
        if (participants[part_info].Element[part_index - 1].subtxt.indexOf(",") == -1)
        {
            part_subtxt[0] = participants[part_info].Element[part_index - 1].subtxt;
        }
        else
        {
            part_subtxt = participants[part_info].Element[part_index - 1].subtxt.split(",");
        } // end else if
        change_subtxt(part_subtxt[0]);
        if (part_cues[0] != "" && part_cues[0] != undefined)
        {
            if (part_cues[0].indexOf(".swf") != -1 || part_cues[0].indexOf(".jpg") != -1)
            {
                _root.Slideshow.loadMovie("slides/" + part_cues[0]);
            }
            else
            {
                _root.Slideshow.loadMovie("slides/" + cues[part_cues[0]].slide);
                _root.HeadMov.addEventListener("cuePoint", myCuePointListener);
                for (var _loc2 = 0; _loc2 < cues[part_cues[0]].Element.length; ++_loc2)
                {
                    _root.HeadMov.addCuePoint(cues[part_cues[0]].Element[_loc2].name, Number(cues[part_cues[0]].Element[_loc2].time));
                } // end of for
                _root.SlideShow.gotoAndStop(0);
            } // end if
        } // end else if
        _root["mc_pVideo" + _root.selected_part].p_button.enabled = true;
        _root["mc_pVideo" + _root.selected_part].gray_mask._visible = true;
        _root.selected_part = part_index;
        _root["mc_pVideo" + _root.selected_part].p_button.enabled = false;
        _root.fftoggle.gotoAndStop(1);
    } // end if
} // End of the function
function play_otherVid()
{
    change_subtxt(participants[part_info].Element[part_index - 1].subtxt);
    _root.HeadMov.setMedia("shots/" + part_vids[part_vid_count] + ".flv", "FLV");
    _root.HeadMov.play(0);
    HeadMov.removeAllCuePoints();
    no_cues = true;
    change_subtxt(part_subtxt[part_vid_count]);
    if (part_cues[part_vid_count] != "" && part_cues[part_vid_count] != undefined)
    {
        if (part_cues[part_vid_count].indexOf(".swf") != -1 || part_cues[part_vid_count].indexOf(".jpg") != -1)
        {
            _root.Slideshow.loadMovie("slides/" + part_cues[part_vid_count]);
        }
        else
        {
            _root.Slideshow.loadMovie("slides/" + cues[part_cues[part_vid_count]].slide);
            _root.HeadMov.addEventListener("cuePoint", myCuePointListener);
            for (var _loc2 = 0; _loc2 < cues[part_cues[part_vid_count]].Element.length; ++_loc2)
            {
                _root.HeadMov.addCuePoint(cues[part_cues[part_vid_count]].Element[_loc2].name, Number(cues[part_cues[part_vid_count]].Element[_loc2].time));
            } // end of for
            _root.SlideShow.gotoAndStop(0);
        } // end if
    } // end else if
    ++part_vid_count;
} // End of the function
function change_subtxt(stxt_name)
{
    _root.support_text.sub_text.scroll = 1;
    support_text.sub_text.text = "";
    if (subtext[stxt_name].Element.length > 0)
    {
        support_text._visible = true;
        for (var _loc3 = 0; _loc3 < subtext[stxt_name].Element.length; ++_loc3)
        {
            support_text.sub_text.text = support_text.sub_text.text + ("\t" + subtext[stxt_name].Element[_loc3].content + "\r\r");
        } // end of for
        support_text.sub_text.setTextFormat(subttxt);
        if (_global.trackObj.data.st_state == "" || _global.trackObj.data.st_state == undefined)
        {
            support_text.gotoAndStop("min");
            support_text.resize_up = true;
        }
        else
        {
            support_text.gotoAndStop(_global.trackObj.data.st_state);
            support_text.resize_up = true;
        } // end else if
    }
    else
    {
        support_text._visible = false;
    } // end else if
} // End of the function
HeadMov._x = 20;
HeadMov._y = 116;
var part_info = array_list[curr_index].parts;
var page_info = array_list[curr_index].pages;
var max_parts = 6;
var max_pages = 12;
var p_col1_maxW = 0;
var p_col2_maxW = 0;
var p_col1_X = 0;
var p_col2_X = 0;
var par_col1_X = 0;
var par_col2_X = 0;
var cue_name = array_list[curr_index].cues;
var part_vid_count = 0;
page_title.text = "";
part_title.text = "";
trace ("cue_name = " + cue_name);
if (cue_name.indexOf(".swf") != -1 || cue_name.indexOf(".jpg") != -1)
{
    _root.Slideshow.loadMovie("slides/" + cue_name);
}
else
{
    trace ("cues[" + cue_name + "][slide] = " + cues[cue_name].slide);
    _root.Slideshow.loadMovie("slides/" + cues[cue_name].slide);
    _root.HeadMov.addEventListener("cuePoint", myCuePointListener);
    trace ("cues[" + cue_name + "].Element.length = " + cues[cue_name].Element.length);
    var e = 0;
    while (e < cues[cue_name].Element.length)
    {
        _root.HeadMov.addCuePoint(cues[cue_name].Element[e].name, Number(cues[cue_name].Element[e].time));
        ++e;
    } // end while
    _root.SlideShow.gotoAndStop(0);
} // end else if
if (part_info == "" || part_info == undefined)
{
    if (page_info == "" || page_info == undefined)
    {
        var p = 0;
        while (p < max_parts)
        {
            this["mc_pVideo" + (p + 1)]._visible = false;
            ++p;
        } // end while
        var g = 0;
        while (g < max_pages)
        {
            this["mc_page" + (g + 1)]._visible = false;
            ++g;
        } // end while
    }
    else
    {
        var p = 0;
        while (p < max_parts)
        {
            this["mc_pVideo" + (p + 1)]._visible = false;
            ++p;
        } // end while
        page_title.autoSize = "center";
        if (pages[page_info].title != "" && pages[page_info].title != undefined)
        {
            page_title.text = pages[page_info].title;
            page_title.setTextFormat(partTtl);
        }
        else if (pageTitle != "" && pageTitle != undefined)
        {
            page_title.text = pageTitle;
            page_title.setTextFormat(partTtl);
        } // end else if
        var g = 0;
        while (g < max_pages)
        {
            if (g >= pages[page_info].Element.length)
            {
                this["mc_page" + (g + 1)]._visible = false;
            }
            else
            {
                this["mc_page" + (g + 1)]._visible = true;
                this["mc_page" + (g + 1)].page_num.text = pages[page_info].Element[g].page;
                this["mc_page" + (g + 1)].page_num.setTextFormat(pgNum);
                if (pages[page_info].show_label.substr(0, 1).toLowerCase() == "y")
                {
                    if (pages[page_info].Element[g].label != "" && pages[page_info].Element[g].label != undefined)
                    {
                        this["mc_page" + (g + 1)].txt_label._x = this["mc_page" + (g + 1)].txt_button._x = 37;
                        this["mc_page" + (g + 1)].txt_label.autoSize = true;
                        this["mc_page" + (g + 1)].txt_label.text = pages[page_info].Element[g].label;
                        this["mc_page" + (g + 1)].txt_label.setTextFormat(pgLblG);
                        this["mc_page" + (g + 1)].txt_button._width = this["mc_page" + (g + 1)].txt_label._width;
                        if (g < max_pages / 2)
                        {
                            if (this["mc_page" + (g + 1)]._width > p_col1_maxW)
                            {
                                p_col1_maxW = this["mc_page" + (g + 1)]._width;
                            } // end if
                        }
                        else if (this["mc_page" + (g + 1)]._width > p_col2_maxW)
                        {
                            p_col2_maxW = this["mc_page" + (g + 1)]._width;
                        } // end if
                    } // end else if
                }
                else if (g < max_pages / 2)
                {
                    if (this["mc_page" + (g + 1)]._width > p_col1_maxW)
                    {
                        p_col1_maxW = this["mc_page" + (g + 1)]._width;
                    } // end if
                }
                else if (this["mc_page" + (g + 1)]._width > p_col2_maxW)
                {
                    p_col2_maxW = this["mc_page" + (g + 1)]._width;
                } // end else if
            } // end else if
            ++g;
        } // end while
        if (p_col2_maxW > 0)
        {
            p_col1_X = bottom_Slideshow._x + (bottom_Slideshow._width - (p_col1_maxW + subjSpace + p_col2_maxW)) / 2;
            p_col2_X = p_col1_X + p_col1_maxW + subjSpace;
        }
        else
        {
            p_col1_X = bottom_Slideshow._x + (bottom_Slideshow._width - p_col1_maxW) / 2;
        } // end else if
        var r = 0;
        while (r < pages[page_info].Element.length)
        {
            if (r < max_pages / 2)
            {
                this["mc_page" + (r + 1)]._x = p_col1_X;
            }
            else
            {
                this["mc_page" + (r + 1)]._x = p_col2_X;
            } // end else if
            ++r;
        } // end while
        page_title._x = bottom_Slideshow._x + (bottom_Slideshow._width - page_title._width) / 2;
    } // end else if
}
else if (page_info == "" || page_info == undefined)
{
    part_title.autoSize = "center";
    if (!(participants[part_info].title == "" || participants[part_info].title == undefined))
    {
        part_title.text = participants[part_info].title;
        part_title.setTextFormat(partTtl);
    }
    else if (partTitle == "" || partTitle == undefined)
    {
        part_title.text = partTitle;
        part_title.setTextFormat(partTtl);
    } // end else if
    part_title._x = bottom_Slideshow._x + (bottom_Slideshow._width - part_title._width) / 2;
    if (participants[part_info].Element.length > max_parts / 2)
    {
        par_col1_X = bottom_Slideshow._x + (bottom_Slideshow._width - mc_pVideo1._width * 2 - subjSpace) / 2;
        par_col2_X = par_col1_X + mc_pVideo1._width + subjSpace;
    }
    else
    {
        par_col1_X = bottom_Slideshow._x + (bottom_Slideshow._width - mc_pVideo1._width) / 2;
    } // end else if
    var p = 0;
    while (p < max_parts)
    {
        if (p >= participants[part_info].Element.length)
        {
            this["mc_pVideo" + (p + 1)]._visible = false;
        }
        else
        {
            this["mc_pVideo" + (p + 1)]._visible = true;
            this["mc_pVideo" + (p + 1)].photo_ph.loadMovie("media/" + participants[part_info].Element[p].image);
            if (participants[part_info].show_name.substr(0, 1).toLowerCase() == "n")
            {
                this["mc_pVideo" + (p + 1)].part_name._visible = false;
                this["mc_pVideo" + (p + 1)].pnb._visible = false;
            }
            else
            {
                this["mc_pVideo" + (p + 1)].part_name.text = participants[part_info].Element[p].name;
                this["mc_pVideo" + (p + 1)].part_name.setTextFormat(partName);
                this["mc_pVideo" + (p + 1)].part_name._visible = true;
                this["mc_pVideo" + (p + 1)].pnb._visible = true;
                if (p < max_parts / 2)
                {
                    this["mc_pVideo" + (p + 1)]._x = par_col1_X;
                }
                else
                {
                    this["mc_pVideo" + (p + 1)]._x = par_col2_X;
                } // end else if
            } // end else if
        } // end else if
        ++p;
    } // end while
    selected_part = 0;
    var g = 0;
    while (g < max_pages)
    {
        this["mc_page" + (g + 1)]._visible = false;
        ++g;
    } // end while
}
else
{
    part_title.autoSize = "center";
    if (!(participants[part_info].title == "" || participants[part_info].title == undefined))
    {
        part_title.text = participants[part_info].title;
        part_title.setTextFormat(partTtl);
    }
    else if (partTitle != "" && partTitle != undefined)
    {
        part_title.text = partTitle;
        part_title.setTextFormat(partTtl);
    } // end else if
    page_title.autoSize = "center";
    if (pages[page_info].title != "" && pages[page_info].title != undefined)
    {
        page_title.text = pages[page_info].title;
        page_title.setTextFormat(partTtl);
    }
    else if (pageTitle != "" && pageTitle != undefined)
    {
        page_title.text = pageTitle;
        page_title.setTextFormat(partTtl);
    } // end else if
    var g = 0;
    while (g < max_pages)
    {
        if (g >= pages[page_info].Element.length)
        {
            this["mc_page" + (g + 1)]._visible = false;
        }
        else
        {
            this["mc_page" + (g + 1)]._visible = true;
            this["mc_page" + (g + 1)].page_num.text = pages[page_info].Element[g].page;
            this["mc_page" + (g + 1)].page_num.setTextFormat(pgNum);
            if (pages[page_info].Element.length <= max_pages / 2 && participants[part_info].Element.length <= max_parts / 2)
            {
                if (pages[page_info].show_label.substr(0, 1).toLowerCase() == "y")
                {
                    if (pages[page_info].Element[g].label != "" && pages[page_info].Element[g].label != undefined)
                    {
                        this["mc_page" + (g + 1)].txt_label._x = this["mc_page" + (g + 1)].txt_button._x = 37;
                        this["mc_page" + (g + 1)].txt_label.autoSize = true;
                        this["mc_page" + (g + 1)].txt_label.text = pages[page_info].Element[g].label;
                        this["mc_page" + (g + 1)].txt_label.setTextFormat(pgLblG);
                        this["mc_page" + (g + 1)].txt_button._width = this["mc_page" + (g + 1)].txt_label._width;
                        if (this["mc_page" + (g + 1)]._width > p_col1_maxW)
                        {
                            p_col1_maxW = this["mc_page" + (g + 1)]._width;
                        } // end if
                    } // end if
                } // end if
            }
            else if (g < max_pages / 2)
            {
                if (this["mc_page" + (g + 1)]._width > p_col1_maxW)
                {
                    p_col1_maxW = this["mc_page" + (g + 1)]._width;
                } // end if
            }
            else if (this["mc_page" + (g + 1)]._width > p_col2_maxW)
            {
                p_col2_maxW = this["mc_page" + (g + 1)]._width;
            } // end else if
        } // end else if
        ++g;
    } // end while
    if (pages[page_info].Element.length <= max_pages / 2 && participants[part_info].Element.length <= max_parts / 2)
    {
        if (page_title._width > p_col1_maxW)
        {
            if (part_title._width > mc_pVideo1._width)
            {
                page_title._x = bottom_Slideshow._x + (bottom_Slideshow._width - page_title._width - part_title._width - subjSpace) / 2;
                part_title._x = page_title._x + page_title._width + subjSpace;
                p_col1_X = page_title._x + (page_title._width - p_col1_maxW) / 2;
                par_col1_X = part_title._x + (part_title._width - mc_pVideo1._width);
            }
            else
            {
                page_title._x = bottom_Slideshow._x + (bottom_Slideshow._width - page_title._width - mc_pVideo1._width - subjSpace) / 2;
                p_col1_X = page_title._x + (page_title._width - p_col1_maxW) / 2;
                par_col1_X = page_title._x + page_title._width + subjSpace;
                part_title._x = par_col1_X + (mc_pVideo1._width - part_title._width) / 2;
            } // end else if
        }
        else if (part_title._width > mc_pVideo1._width)
        {
            p_col1_X = bottom_Slideshow._x + (bottom_Slideshow._width - p_col1_maxW - subjSpace - part_title._width) / 2;
            page_title._x = p_col1_X + (p_col1_maxW - page_title._width) / 2;
            part_title._x = p_col1_X + p_col1_maxW + subjSpace;
            par_col1_X = part_title._x + (part_title._width - mc_pVideo1._width);
        }
        else
        {
            p_col1_X = bottom_Slideshow._x + (bottom_Slideshow._width - p_col1_maxW - subjSpace - mc_pVideo1._width) / 2;
            page_title._x = p_col1_X + (p_col1_maxW - page_title._width) / 2;
            par_col1_X = p_col1_X + p_col1_maxW + subjSpace;
            part_title._x = par_col1_X + (mc_pVideo1._width - part_title._width);
        } // end else if
    }
    else if (pages[page_info].Element.length > max_pages / 2 && participants[part_info].Element.length <= max_parts / 2)
    {
        if (page_title._width > p_col1_maxW + p_col2_maxW + subjSpace / 2)
        {
            if (part_title._width > mc_pVideo1._width)
            {
                page_title._x = bottom_Slideshow._x + (bottom_Slideshow._width - page_title._width - part_title._width - subjSpace) / 2;
                part_title._x = page_title._x + page_title._width + subjSpace;
                p_col1_X = page_title._x + (page_title._width - (p_col1_maxW + p_col2_maxW + subjSpace / 2)) / 2;
                p_col2_X = p_col1_X + p_col1_maxW + subjSpace / 2;
                par_col1_X = part_title._x + (part_title._width - mc_pVideo1._width) / 2;
            }
            else
            {
                page_title._x = bottom_Slideshow._x + (bottom_Slideshow._width - page_title._width - mc_pVideo1._width - subjSpace) / 2;
                p_col1_X = page_title._x + (page_title._width - (p_col1_maxW + p_col2_maxW + subjSpace / 2)) / 2;
                p_col2_X = p_col1_X + p_col1_maxW + subjSpace / 2;
                par_col1_X = page_title._x + page_title._width + subjSpace;
                part_title._x = par_col1_X + (mc_pVideo1._width - part_title._width) / 2;
            } // end else if
        }
        else
        {
            p_col1_X = bottom_Slideshow._x + (bottom_Slideshow._width - part_title._width - subjSpace - (p_col1_maxW + p_col2_maxW + subjSpace / 2)) / 2;
            p_col2_X = p_col1_X + p_col1_maxW + subjSpace / 2;
            page_title._x = p_col2_X - subjSpace / 8 - page_title._width / 2;
            if (part_title._width > mc_pVideo1._width)
            {
                part_title._x = p_col2_X + p_col2_maxW + subjSpace;
                par_col1_X = part_title._x + (part_title._width - mc_pVideo1._width) / 2;
            }
            else
            {
                par_col1_X = p_col2_X + p_col2_maxW + subjSpace;
                part_title._x = par_col1_X + (mc_pVideo1._width - part_title._width) / 2;
            } // end else if
        } // end else if
    }
    else if (pages[page_info].Element.length <= max_pages / 2 && participants[part_info].Element.length > max_parts / 2)
    {
        if (page_title._width > p_col1_maxW)
        {
            page_title._x = bottom_Slideshow._x + (bottom_Slideshow._width - page_title._width - 2 * mc_pVideo1._width - 1.500000E+000 * subjSpace) / 2;
            p_col1_X = page_title._x + (page_title._width - p_col1_maxW) / 2;
            par_col1_X = page_title._x + page_title._width + subjSpace;
        }
        else
        {
            p_col1_X = bottom_Slideshow._x + (bottom_Slideshow._width - p_col1_maxW - 2 * mc_pVideo1._width - 1.500000E+000 * subjSpace) / 2;
            page_title._x = p_col1_X + (p_col1_maxW - page_title._width) / 2;
            par_col1_X = p_col1_X + p_col1_maxW + subjSpace;
        } // end else if
        par_col2_X = par_col1_X + mc_pVideo1._width + subjSpace / 2;
        part_title._x = par_col2_X - subjSpace / 4 - part_title._width / 2;
    }
    else
    {
        p_col1_X = bottom_Slideshow._x + (bottom_Slideshow._width - 2 * (mc_page1._width + subjSpace + mc_pVideo1._width)) / 2;
        p_col2_X = p_col1_X + mc_page1._width + subjSpace / 2;
        par_col1_X = p_col2_X + mc_page4._width + subjSpace;
        par_col2_X = par_col1_X + mc_pVideo1._width + subjSpace / 2;
        page_title._x = p_col2_X - subjSpace / 4 - page_title._width / 2;
        part_title._x = par_col2_X - subjSpace / 4 - part_title._width / 2;
    } // end else if
    var p = 0;
    while (p < max_parts)
    {
        if (p >= participants[part_info].Element.length)
        {
            this["mc_pVideo" + (p + 1)]._visible = false;
        }
        else
        {
            this["mc_pVideo" + (p + 1)]._visible = true;
            this["mc_pVideo" + (p + 1)].photo_ph.loadMovie("media/" + participants[part_info].Element[p].image);
            if (participants[part_info].show_name.substr(0, 1).toLowerCase() == "n")
            {
                this["mc_pVideo" + (p + 1)].part_name._visible = false;
                this["mc_pVideo" + (p + 1)].pnb._visible = false;
            }
            else
            {
                this["mc_pVideo" + (p + 1)].part_name.text = participants[part_info].Element[p].name;
                this["mc_pVideo" + (p + 1)].part_name.setTextFormat(partName);
                this["mc_pVideo" + (p + 1)].part_name._visible = true;
                this["mc_pVideo" + (p + 1)].pnb._visible = true;
            } // end else if
            if (p < max_parts / 2)
            {
                this["mc_pVideo" + (p + 1)]._x = par_col1_X;
            }
            else
            {
                this["mc_pVideo" + (p + 1)]._x = par_col2_X;
            } // end else if
        } // end else if
        ++p;
    } // end while
    var r = 0;
    while (r < pages[page_info].Element.length)
    {
        if (r < max_pages / 2)
        {
            this["mc_page" + (r + 1)]._x = p_col1_X;
        }
        else
        {
            this["mc_page" + (r + 1)]._x = p_col2_X;
        } // end else if
        ++r;
    } // end while
    selected_part = 0;
} // end else if
_root.fftoggle.gotoAndStop(1);
_root["mc_pVideo" + _root.selected_part].p_button.enabled = true;
_root["mc_pVideo" + _root.selected_part].gray_mask._visible = true;
_root.near_end = false;
_root.bookM_add.gotoAndStop("enable");
if (_global.trackObj.data.bookM.length > 0)
{
    _root.bookM_goto.gotoAndStop("enable");
    _root.bookM_del.gotoAndStop("enable");
} // end if
forward_click = false;
support_text.sub_text.text = "";
if (subtext[array_list[curr_index].subtxt].Element.length > 0)
{
    support_text._visible = true;
    var t = 0;
    while (t < subtext[array_list[curr_index].subtxt].Element.length)
    {
        support_text.sub_text.text = support_text.sub_text.text + ("\t" + subtext[array_list[curr_index].subtxt].Element[t].content + "\r\r");
        ++t;
    } // end while
    support_text.sub_text.setTextFormat(subttxt);
    if (_global.trackObj.data.st_state == "" || _global.trackObj.data.st_state == undefined)
    {
        if (array_list[curr_index].stip.substr(0, 1).toLowerCase() == "u")
        {
            support_text.gotoAndStop("line");
            support_text.resize_up = true;
        }
        else
        {
            support_text.gotoAndStop("min");
            support_text.resize_up = true;
        } // end else if
    }
    else
    {
        support_text.gotoAndStop(_global.trackObj.data.st_state);
        support_text.resize_up = true;
    } // end else if
}
else
{
    support_text._visible = false;
} // end else if
time_played = 0;
var time_diff = 1.000000E-003;
if (resume_time > time_diff)
{
    _root.oPlaytime = resume_time - time_diff;
}
else
{
    _root.oPlaytime = 0;
} // end else if
clearInterval(_root.intervalID);
_root.HeadMov.clear();
if ("shots/" + array_list[curr_index].file + ".flv" != _root.HeadMov.contentPath)
{
    if (curr_template.substr(0, 3).toLowerCase() != "aud")
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".flv", "FLV");
    }
    else
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".mp3", "MP3");
    } // end if
} // end else if
_root.HeadMov.play();
_root.intervalID = setInterval(callback, 1000);

// [Action in Frame 18]
callback();

// [Action in Frame 19]
stop ();

// [Action in Frame 20]
function callback()
{
    if (_root.HeadMov.playheadTime > 2 && _root.HeadMov.bytesLoaded == _root.HeadMov.bytesTotal)
    {
        _root.rEnd = 0;
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1 && !_root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 60);
            _root.near_end = true;
        } // end if
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime > 1 && _root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 1000);
            _root.near_end = false;
        } // end if
        if (_root.near_end && _root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E-001;
        }
        else if (_root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E+000;
        } // end else if
        if (time_played > 1.130000E+000)
        {
            if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1.100000E-001)
            {
                _root.rEnd = 1;
                if (!pause_media)
                {
                    _root.nextload();
                }
                else if (_root.fftoggle._currentframe == 1)
                {
                    if (part_vids.length > 1 && part_vid_count < part_vids.length)
                    {
                        play_otherVid();
                    }
                    else
                    {
                        _root.fftoggle.gotoAndPlay(2);
                        HeadMov.pause();
                    } // end if
                } // end else if
            } // end else if
            if (!_root.user_pause)
            {
                if (_root.oPlaytime == _root.HeadMov.playheadTime)
                {
                    _root.rEnd = 1;
                    if (!pause_media)
                    {
                        _root.nextload();
                    }
                    else if (_root.fftoggle._currentframe == 1)
                    {
                        if (part_vids.length > 1 && part_vid_count < part_vids.length)
                        {
                            play_otherVid();
                        }
                        else
                        {
                            _root.fftoggle.gotoAndPlay(2);
                            HeadMov.pause();
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end else if
    } // end else if
    if (resume_time != 0)
    {
        if (resume_time / _root.HeadMov.totalTime > 9.500000E-001)
        {
            _root.oPlaytime = _root.HeadMov.playheadTime;
            resume_time = 0;
        }
        else
        {
            _root.HeadMov.playheadTime = resume_time;
            resume_time = 0;
        } // end else if
    }
    else
    {
        _root.oPlaytime = _root.HeadMov.playheadTime;
    } // end else if
} // End of the function
HeadMov._x = 2.512000E+002;
HeadMov._y = 1.762000E+002;
_root.fftoggle.gotoAndStop(1);
_root["mc_pVideo" + _root.selected_part].p_button.enabled = true;
_root["mc_pVideo" + _root.selected_part].gray_mask._visible = true;
_root.near_end = false;
_root.bookM_add.gotoAndStop("enable");
if (_global.trackObj.data.bookM.length > 0)
{
    _root.bookM_goto.gotoAndStop("enable");
    _root.bookM_del.gotoAndStop("enable");
} // end if
forward_click = false;
support_text.sub_text.text = "";
if (subtext[array_list[curr_index].subtxt].Element.length > 0)
{
    support_text._visible = true;
    var t = 0;
    while (t < subtext[array_list[curr_index].subtxt].Element.length)
    {
        support_text.sub_text.text = support_text.sub_text.text + ("\t" + subtext[array_list[curr_index].subtxt].Element[t].content + "\r\r");
        ++t;
    } // end while
    support_text.sub_text.setTextFormat(subttxt);
    if (_global.trackObj.data.st_state == "" || _global.trackObj.data.st_state == undefined)
    {
        if (array_list[curr_index].stip.substr(0, 1).toLowerCase() == "u")
        {
            support_text.gotoAndStop("line");
            support_text.resize_up = true;
        }
        else
        {
            support_text.gotoAndStop("min");
            support_text.resize_up = true;
        } // end else if
    }
    else
    {
        support_text.gotoAndStop(_global.trackObj.data.st_state);
        support_text.resize_up = true;
    } // end else if
}
else
{
    support_text._visible = false;
} // end else if
time_played = 0;
var time_diff = 1.000000E-003;
if (resume_time > time_diff)
{
    _root.oPlaytime = resume_time - time_diff;
}
else
{
    _root.oPlaytime = 0;
} // end else if
clearInterval(_root.intervalID);
_root.HeadMov.clear();
if ("shots/" + array_list[curr_index].file + ".flv" != _root.HeadMov.contentPath)
{
    if (curr_template.substr(0, 3).toLowerCase() != "aud")
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".flv", "FLV");
    }
    else
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".mp3", "MP3");
    } // end if
} // end else if
_root.HeadMov.play();
_root.intervalID = setInterval(callback, 1000);
var cue_name = array_list[curr_index].cues;
if (cue_name != "" && cue_name != undefined)
{
    if (cue_name.indexOf(".swf") != -1 || cue_name.indexOf(".jpg") != -1)
    {
        _root.Slideshow.loadMovie("slides/" + cue_name);
    }
    else
    {
        _root.Slideshow.loadMovie("slides/" + cues[cue_name].slide);
        _root.HeadMov.addEventListener("cuePoint", myCuePointListener);
        var e = 0;
        while (e < cues[cue_name].Element.length)
        {
            _root.HeadMov.addCuePoint(cues[cue_name].Element[e].name, Number(cues[cue_name].Element[e].time));
            ++e;
        } // end while
        _root.SlideShow.gotoAndStop(0);
    } // end if
} // end else if

// [Action in Frame 23]
callback();

// [Action in Frame 24]
stop ();

// [Action in Frame 25]
function callback()
{
    if (_root.HeadMov.playheadTime > 2 && _root.HeadMov.bytesLoaded == _root.HeadMov.bytesTotal)
    {
        _root.rEnd = 0;
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1 && !_root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 60);
            _root.near_end = true;
        } // end if
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime > 1 && _root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 1000);
            _root.near_end = false;
        } // end if
        if (_root.near_end && _root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E-001;
        }
        else if (_root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E+000;
        } // end else if
        if (time_played > 1.130000E+000)
        {
            if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1.100000E-001)
            {
                _root.rEnd = 1;
                if (!pause_media)
                {
                    _root.nextload();
                }
                else if (_root.fftoggle._currentframe == 1)
                {
                    if (part_vids.length > 1 && part_vid_count < part_vids.length)
                    {
                        play_otherVid();
                    }
                    else
                    {
                        _root.fftoggle.gotoAndPlay(2);
                        HeadMov.pause();
                    } // end if
                } // end else if
            } // end else if
            if (!_root.user_pause)
            {
                if (_root.oPlaytime == _root.HeadMov.playheadTime)
                {
                    _root.rEnd = 1;
                    if (!pause_media)
                    {
                        _root.nextload();
                    }
                    else if (_root.fftoggle._currentframe == 1)
                    {
                        if (part_vids.length > 1 && part_vid_count < part_vids.length)
                        {
                            play_otherVid();
                        }
                        else
                        {
                            _root.fftoggle.gotoAndPlay(2);
                            HeadMov.pause();
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end else if
    } // end else if
    if (resume_time != 0)
    {
        if (resume_time / _root.HeadMov.totalTime > 9.500000E-001)
        {
            _root.oPlaytime = _root.HeadMov.playheadTime;
            resume_time = 0;
        }
        else
        {
            _root.HeadMov.playheadTime = resume_time;
            resume_time = 0;
        } // end else if
    }
    else
    {
        _root.oPlaytime = _root.HeadMov.playheadTime;
    } // end else if
} // End of the function
function play_scene(scene_index)
{
    agreeB._visible = true;
    disagreeB._visible = true;
    trace ("(_root[pVideo" + button_index + "][0]+\".flv\" != _root.HeadMov.contentPath) = (" + _root["pVideo" + button_index][0] + ".flv" + " != " + _root.HeadMov.contentPath + ") = " + (_root["pVideo" + button_index][0] + ".flv" != _root.HeadMov.contentPath));
    if ("shots/" + scenarios[scene_info].Element[scene_index - 1].clip + ".flv" != _root.HeadMov.contentPath)
    {
        trace ("shots/" + scenarios[scene_info].Element[scene_index - 1].clip + ".flv");
        _root.HeadMov.setMedia("shots/" + scenarios[scene_info].Element[scene_index - 1].clip + ".flv", "FLV");
        _root.HeadMov.play(0);
        trace ("_root.selected_scene = " + _root.selected_scene);
        trace ("_root[mc_pVideo" + _root.selected_scene + "]._currentframe = " + _root["mc_pVideo" + _root.selected_scene]._currentframe);
        _root["mc_pVideo" + _root.selected_scene].p_button.enabled = true;
        _root["mc_pVideo" + _root.selected_scene].gray_mask._visible = true;
        _root.selected_scene = scene_index;
        _root["mc_pVideo" + _root.selected_scene].p_button.enabled = false;
        responded = false;
        _root.fftoggle.gotoAndStop(1);
    } // end if
} // End of the function
function disagree_vid()
{
    trace ("You Disagreed!");
    _root.HeadMov.setMedia("shots/" + scenarios[scene_info].Element[_root.selected_scene - 1].disagree + ".flv", "FLV");
    _root.HeadMov.play(0);
    _root.fftoggle.gotoAndStop(1);
    responded = true;
} // End of the function
function agree_vid()
{
    trace ("You agreed!");
    _root.HeadMov.setMedia("shots/" + scenarios[scene_info].Element[_root.selected_scene - 1].agree + ".flv", "FLV");
    _root.HeadMov.play(0);
    _root.fftoggle.gotoAndStop(1);
    responded = true;
} // End of the function
HeadMov._x = 20;
HeadMov._y = 116;
trace ("_root.VideoArray[" + _root.CurrentVid + "][\"Pause\"] = " + _root.VideoArray[_root.CurrentVid].Pause);
trace ("array_list[" + curr_index + "][scenarios] = " + array_list[curr_index].scenarios);
agreeB._visible = false;
disagreeB._visible = false;
var scene_info = array_list[curr_index].scenarios;
var max_parts = 5;
var p = 0;
while (p < max_parts)
{
    for (things in scenarios[scene_info].Element[p])
    {
        trace ("scenarios[" + scene_info + "].Element[" + p + "][" + things + "] = " + scenarios[scene_info].Element[p][things]);
    } // end of for...in
    if (p >= scenarios[scene_info].Element.length)
    {
        this["mc_pVideo" + (p + 1)]._visible = false;
    }
    else
    {
        this["mc_pVideo" + (p + 1)]._visible = true;
        this["mc_pVideo" + (p + 1)].photo_ph.loadMovie("media/" + scenarios[scene_info].Element[p].image);
        this["mc_pVideo" + (p + 1)].part_name.text = scenarios[scene_info].Element[p].name;
        this["statement" + (p + 1)].text = scenarios[scene_info].Element[p].situation;
    } // end else if
    ++p;
} // end while
selected_scene = 0;
responded = false;
_root.fftoggle.gotoAndStop(1);
_root["mc_pVideo" + _root.selected_part].p_button.enabled = true;
_root["mc_pVideo" + _root.selected_part].gray_mask._visible = true;
_root.near_end = false;
_root.bookM_add.gotoAndStop("enable");
if (_global.trackObj.data.bookM.length > 0)
{
    _root.bookM_goto.gotoAndStop("enable");
    _root.bookM_del.gotoAndStop("enable");
} // end if
forward_click = false;
support_text.sub_text.text = "";
if (subtext[array_list[curr_index].subtxt].Element.length > 0)
{
    support_text._visible = true;
    var t = 0;
    while (t < subtext[array_list[curr_index].subtxt].Element.length)
    {
        support_text.sub_text.text = support_text.sub_text.text + ("\t" + subtext[array_list[curr_index].subtxt].Element[t].content + "\r\r");
        ++t;
    } // end while
    support_text.sub_text.setTextFormat(subttxt);
    if (_global.trackObj.data.st_state == "" || _global.trackObj.data.st_state == undefined)
    {
        if (array_list[curr_index].stip.substr(0, 1).toLowerCase() == "u")
        {
            support_text.gotoAndStop("line");
            support_text.resize_up = true;
        }
        else
        {
            support_text.gotoAndStop("min");
            support_text.resize_up = true;
        } // end else if
    }
    else
    {
        support_text.gotoAndStop(_global.trackObj.data.st_state);
        support_text.resize_up = true;
    } // end else if
}
else
{
    support_text._visible = false;
} // end else if
time_played = 0;
var time_diff = 1.000000E-003;
if (resume_time > time_diff)
{
    _root.oPlaytime = resume_time - time_diff;
}
else
{
    _root.oPlaytime = 0;
} // end else if
clearInterval(_root.intervalID);
_root.HeadMov.clear();
if ("shots/" + array_list[curr_index].file + ".flv" != _root.HeadMov.contentPath)
{
    if (curr_template.substr(0, 3).toLowerCase() != "aud")
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".flv", "FLV");
    }
    else
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".mp3", "MP3");
    } // end if
} // end else if
_root.HeadMov.play();
_root.intervalID = setInterval(callback, 1000);

// [Action in Frame 28]
callback();

// [Action in Frame 29]
stop ();

// [Action in Frame 30]
function callback()
{
    if (_root.HeadMov.playheadTime > 2 && _root.HeadMov.bytesLoaded == _root.HeadMov.bytesTotal)
    {
        _root.rEnd = 0;
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1 && !_root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 60);
            _root.near_end = true;
        } // end if
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime > 1 && _root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 1000);
            _root.near_end = false;
        } // end if
        if (_root.near_end && _root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E-001;
        }
        else if (_root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E+000;
        } // end else if
        if (time_played > 1.130000E+000)
        {
            if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1.100000E-001)
            {
                _root.rEnd = 1;
                if (!pause_media)
                {
                    _root.nextload();
                }
                else if (_root.fftoggle._currentframe == 1)
                {
                    if (part_vids.length > 1 && part_vid_count < part_vids.length)
                    {
                        play_otherVid();
                    }
                    else
                    {
                        _root.fftoggle.gotoAndPlay(2);
                        HeadMov.pause();
                    } // end if
                } // end else if
            } // end else if
            if (!_root.user_pause)
            {
                if (_root.oPlaytime == _root.HeadMov.playheadTime)
                {
                    _root.rEnd = 1;
                    if (!pause_media)
                    {
                        _root.nextload();
                    }
                    else if (_root.fftoggle._currentframe == 1)
                    {
                        if (part_vids.length > 1 && part_vid_count < part_vids.length)
                        {
                            play_otherVid();
                        }
                        else
                        {
                            _root.fftoggle.gotoAndPlay(2);
                            HeadMov.pause();
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end else if
    } // end else if
    if (resume_time != 0)
    {
        if (resume_time / _root.HeadMov.totalTime > 9.500000E-001)
        {
            _root.oPlaytime = _root.HeadMov.playheadTime;
            resume_time = 0;
        }
        else
        {
            _root.HeadMov.playheadTime = resume_time;
            resume_time = 0;
        } // end else if
    }
    else
    {
        _root.oPlaytime = _root.HeadMov.playheadTime;
    } // end else if
} // End of the function
function play_scene(scene_index)
{
    agreeB._visible = true;
    disagreeB._visible = true;
    if ("shots/" + statements[scene_info].Element[scene_index - 1].clip + ".flv" != _root.HeadMov.contentPath)
    {
        _root.HeadMov.setMedia("shots/" + statements[scene_info].Element[scene_index - 1].clip + ".flv", "FLV");
        _root.HeadMov.play(0);
        _root["mc_pVideo" + _root.selected_scene].p_button.enabled = true;
        _root["mc_pVideo" + _root.selected_scene].gray_mask._visible = true;
        _root.selected_scene = scene_index;
        _root["mc_pVideo" + _root.selected_scene].p_button.enabled = false;
        responded = false;
        _root.fftoggle.gotoAndStop(1);
    } // end if
} // End of the function
function disagree_vid(stmnt_num)
{
    change_subtxt(statements[scene_info].Element[stmnt_num - 1].disag_txt, statements[scene_info].Element[stmnt_num - 1].disag_cue);
    _root.HeadMov.setMedia("shots/" + statements[scene_info].Element[stmnt_num - 1].disagree + ".flv", "FLV");
    _root.HeadMov.play(0);
    _root.fftoggle.gotoAndStop(1);
    responded = true;
} // End of the function
function agree_vid(stmnt_num)
{
    change_subtxt(statements[scene_info].Element[stmnt_num - 1].agree_txt, statements[scene_info].Element[stmnt_num - 1].agree_cue);
    _root.HeadMov.setMedia("shots/" + statements[scene_info].Element[stmnt_num - 1].agree + ".flv", "FLV");
    _root.HeadMov.play(0);
    _root.fftoggle.gotoAndStop(1);
    responded = true;
} // End of the function
function change_subtxt(stxt_name, st_cue)
{
    _root.support_text.sub_text.scroll = 1;
    support_text.sub_text.text = "";
    if (subtext[stxt_name].Element.length > 0)
    {
        support_text._visible = true;
        for (var _loc4 = 0; _loc4 < subtext[stxt_name].Element.length; ++_loc4)
        {
            support_text.sub_text.text = support_text.sub_text.text + ("\t" + subtext[stxt_name].Element[_loc4].content + "\r\r");
        } // end of for
        support_text.sub_text.setTextFormat(subttxt);
        if (_global.trackObj.data.st_state == "" || _global.trackObj.data.st_state == undefined)
        {
            support_text.gotoAndStop("min");
            support_text.resize_up = true;
        }
        else
        {
            support_text.gotoAndStop(_global.trackObj.data.st_state);
            support_text.resize_up = true;
        } // end else if
    }
    else
    {
        support_text._visible = false;
    } // end else if
    HeadMov.removeAllCuePoints();
    no_cues = true;
    if (st_cue != "" && st_cue != undefined)
    {
        _root.HeadMov.addEventListener("cuePoint", myCuePointListener);
        for (var _loc3 = 0; _loc3 < cues[st_cue].Element.length; ++_loc3)
        {
            _root.HeadMov.addCuePoint(cues[st_cue].Element[_loc3].name, Number(cues[st_cue].Element[_loc3].time));
        } // end of for
    } // end if
} // End of the function
HeadMov._x = 20;
HeadMov._y = 116;
agreeB._visible = false;
disagreeB._visible = false;
var scene_info = array_list[curr_index].statements;
var max_stmnts = 5;
var cont_height = 0;
var ag_space = 0;
var num_stmnts = statements[scene_info].Element.length;
var dist = 5;
var cue_name = array_list[curr_index].cues;
if (cue_name != "" && cue_name != undefined)
{
    _root.HeadMov.addEventListener("cuePoint", myCuePointListener);
    var e = 0;
    while (e < cues[cue_name].Element.length)
    {
        _root.HeadMov.addCuePoint(cues[cue_name].Element[e].name, Number(cues[cue_name].Element[e].time));
        ++e;
    } // end while
} // end if
var p = 0;
while (p < max_stmnts)
{
    if (p >= num_stmnts)
    {
        _root["agree" + (p + 1)]._visible = false;
        _root["disagree" + (p + 1)]._visible = false;
    }
    else
    {
        if (agreeTxt == "" || agreeTxt == undefined)
        {
            agreeTxt = "Agree";
        } // end if
        _root["agree" + (p + 1)].agreeButton.bmB.bookTUp.text = agreeTxt;
        _root["agree" + (p + 1)].agreeButton.bmB.bookTOver.text = agreeTxt;
        _root["agree" + (p + 1)].agreeButton.bmB.bookTDown.text = agreeTxt;
        _root["agree" + (p + 1)].agreeButton.bmB.bookTUp.setTextFormat(agreeUp);
        _root["agree" + (p + 1)].agreeButton.bmB.bookTOver.setTextFormat(agreeOver);
        _root["agree" + (p + 1)].agreeButton.bmB.bookTDown.setTextFormat(agreeDown);
        if (disagTxt == "" || disagTxt == undefined)
        {
            disagTxt = "Disagree";
        } // end if
        _root["disagree" + (p + 1)].disagreeButton.bmB.bookTUp.text = disagTxt;
        _root["disagree" + (p + 1)].disagreeButton.bmB.bookTOver.text = disagTxt;
        _root["disagree" + (p + 1)].disagreeButton.bmB.bookTDown.text = disagTxt;
        _root["disagree" + (p + 1)].disagreeButton.bmB.bookTUp.setTextFormat(agreeUp);
        _root["disagree" + (p + 1)].disagreeButton.bmB.bookTOver.setTextFormat(disagOver);
        _root["disagree" + (p + 1)].disagreeButton.bmB.bookTDown.setTextFormat(agreeDown);
        _root["statement" + (p + 1)].autoSize = true;
        _root["statement" + (p + 1)].text = statements[scene_info].Element[p].txt;
        cont_height = cont_height + (_root["statement" + (p + 1)]._height + _root["agree" + (p + 1)]._height + dist);
    } // end else if
    ++p;
} // end while
ag_space = (stmnt_back._height - cont_height) / num_stmnts;
statement1._y = stmnt_back._y + ag_space;
agree1._y = disagree1._y = statement1._y + statement1._height + dist;
var s = 2;
while (s <= num_stmnts)
{
    _root["statement" + s]._y = _root["agree" + (s - 1)]._y + _root["agree" + (s - 1)]._height + ag_space;
    _root["agree" + s]._y = _root["disagree" + s]._y = _root["statement" + s]._y + _root["statement" + s]._height + dist;
    ++s;
} // end while
selected_scene = 0;
responded = false;
_root.fftoggle.gotoAndStop(1);
_root["mc_pVideo" + _root.selected_part].p_button.enabled = true;
_root["mc_pVideo" + _root.selected_part].gray_mask._visible = true;
_root.near_end = false;
_root.bookM_add.gotoAndStop("enable");
if (_global.trackObj.data.bookM.length > 0)
{
    _root.bookM_goto.gotoAndStop("enable");
    _root.bookM_del.gotoAndStop("enable");
} // end if
forward_click = false;
support_text.sub_text.text = "";
if (subtext[array_list[curr_index].subtxt].Element.length > 0)
{
    support_text._visible = true;
    var t = 0;
    while (t < subtext[array_list[curr_index].subtxt].Element.length)
    {
        support_text.sub_text.text = support_text.sub_text.text + ("\t" + subtext[array_list[curr_index].subtxt].Element[t].content + "\r\r");
        ++t;
    } // end while
    support_text.sub_text.setTextFormat(subttxt);
    if (_global.trackObj.data.st_state == "" || _global.trackObj.data.st_state == undefined)
    {
        if (array_list[curr_index].stip.substr(0, 1).toLowerCase() == "u")
        {
            support_text.gotoAndStop("line");
            support_text.resize_up = true;
        }
        else
        {
            support_text.gotoAndStop("min");
            support_text.resize_up = true;
        } // end else if
    }
    else
    {
        support_text.gotoAndStop(_global.trackObj.data.st_state);
        support_text.resize_up = true;
    } // end else if
}
else
{
    support_text._visible = false;
} // end else if
time_played = 0;
var time_diff = 1.000000E-003;
if (resume_time > time_diff)
{
    _root.oPlaytime = resume_time - time_diff;
}
else
{
    _root.oPlaytime = 0;
} // end else if
clearInterval(_root.intervalID);
_root.HeadMov.clear();
if ("shots/" + array_list[curr_index].file + ".flv" != _root.HeadMov.contentPath)
{
    if (curr_template.substr(0, 3).toLowerCase() != "aud")
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".flv", "FLV");
    }
    else
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".mp3", "MP3");
    } // end if
} // end else if
_root.HeadMov.play();
_root.intervalID = setInterval(callback, 1000);

// [Action in Frame 33]
callback();

// [Action in Frame 34]
stop ();

// [Action in Frame 35]
function callback()
{
    if (_root.HeadMov.playheadTime > 2 && _root.HeadMov.bytesLoaded == _root.HeadMov.bytesTotal)
    {
        _root.rEnd = 0;
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1 && !_root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 60);
            _root.near_end = true;
        } // end if
        if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime > 1 && _root.near_end)
        {
            clearInterval(_root.intervalID);
            _root.intervalID = setInterval(callback, 1000);
            _root.near_end = false;
        } // end if
        if (_root.near_end && _root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E-001;
        }
        else if (_root.HeadMov.playing)
        {
            time_played = time_played + 1.120000E+000;
        } // end else if
        if (time_played > 1.130000E+000)
        {
            if (_root.HeadMov.totalTime - _root.HeadMov.playheadTime < 1.100000E-001)
            {
                _root.rEnd = 1;
                if (!pause_media)
                {
                    _root.nextload();
                }
                else if (_root.fftoggle._currentframe == 1)
                {
                    if (part_vids.length > 1 && part_vid_count < part_vids.length)
                    {
                        play_otherVid();
                    }
                    else
                    {
                        _root.fftoggle.gotoAndPlay(2);
                        HeadMov.pause();
                    } // end if
                } // end else if
            } // end else if
            if (!_root.user_pause)
            {
                if (_root.oPlaytime == _root.HeadMov.playheadTime)
                {
                    _root.rEnd = 1;
                    if (!pause_media)
                    {
                        _root.nextload();
                    }
                    else if (_root.fftoggle._currentframe == 1)
                    {
                        if (part_vids.length > 1 && part_vid_count < part_vids.length)
                        {
                            play_otherVid();
                        }
                        else
                        {
                            _root.fftoggle.gotoAndPlay(2);
                            HeadMov.pause();
                        } // end if
                    } // end if
                } // end if
            } // end if
        } // end else if
    } // end else if
    if (resume_time != 0)
    {
        if (resume_time / _root.HeadMov.totalTime > 9.500000E-001)
        {
            _root.oPlaytime = _root.HeadMov.playheadTime;
            resume_time = 0;
        }
        else
        {
            _root.HeadMov.playheadTime = resume_time;
            resume_time = 0;
        } // end else if
    }
    else
    {
        _root.oPlaytime = _root.HeadMov.playheadTime;
    } // end else if
} // End of the function
HeadMov._x = -3.311000E+002;
HeadMov._y = 116;
_root.fftoggle.gotoAndStop(1);
_root["mc_pVideo" + _root.selected_part].p_button.enabled = true;
_root["mc_pVideo" + _root.selected_part].gray_mask._visible = true;
_root.near_end = false;
_root.bookM_add.gotoAndStop("enable");
if (_global.trackObj.data.bookM.length > 0)
{
    _root.bookM_goto.gotoAndStop("enable");
    _root.bookM_del.gotoAndStop("enable");
} // end if
forward_click = false;
support_text.sub_text.text = "";
if (subtext[array_list[curr_index].subtxt].Element.length > 0)
{
    support_text._visible = true;
    var t = 0;
    while (t < subtext[array_list[curr_index].subtxt].Element.length)
    {
        support_text.sub_text.text = support_text.sub_text.text + ("\t" + subtext[array_list[curr_index].subtxt].Element[t].content + "\r\r");
        ++t;
    } // end while
    support_text.sub_text.setTextFormat(subttxt);
    if (_global.trackObj.data.st_state == "" || _global.trackObj.data.st_state == undefined)
    {
        if (array_list[curr_index].stip.substr(0, 1).toLowerCase() == "u")
        {
            support_text.gotoAndStop("line");
            support_text.resize_up = true;
        }
        else
        {
            support_text.gotoAndStop("min");
            support_text.resize_up = true;
        } // end else if
    }
    else
    {
        support_text.gotoAndStop(_global.trackObj.data.st_state);
        support_text.resize_up = true;
    } // end else if
}
else
{
    support_text._visible = false;
} // end else if
time_played = 0;
var time_diff = 1.000000E-003;
if (resume_time > time_diff)
{
    _root.oPlaytime = resume_time - time_diff;
}
else
{
    _root.oPlaytime = 0;
} // end else if
clearInterval(_root.intervalID);
_root.HeadMov.clear();
if ("shots/" + array_list[curr_index].file + ".flv" != _root.HeadMov.contentPath)
{
    if (curr_template.substr(0, 3).toLowerCase() != "aud")
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".flv", "FLV");
    }
    else
    {
        _root.HeadMov.setMedia("shots/" + array_list[curr_index].file + ".mp3", "MP3");
    } // end if
} // end else if
_root.HeadMov.play();
_root.intervalID = setInterval(callback, 1000);
var cue_name = array_list[curr_index].cues;
trace ("cue_name = " + cue_name);
if (cue_name != "" && cue_name != undefined)
{
    if (cue_name.indexOf(".swf") != -1 || cue_name.indexOf(".jpg") != -1)
    {
        _root.Slideshow.loadMovie("slides/" + cue_name);
    }
    else
    {
        _root.Slideshow.loadMovie("slides/" + cues[cue_name].slide);
        _root.HeadMov.addEventListener("cuePoint", myCuePointListener);
        var e = 0;
        while (e < cues[cue_name].Element.length)
        {
            trace ("cues[" + cue_name + "].Element[" + e + "].name = " + cues[cue_name].Element[e].name);
            trace ("cues[" + cue_name + "].Element[" + e + "].time = " + cues[cue_name].Element[e].time);
            _root.HeadMov.addCuePoint(cues[cue_name].Element[e].name, Number(cues[cue_name].Element[e].time));
            ++e;
        } // end while
        _root.SlideShow.gotoAndStop(0);
    } // end if
} // end else if

// [Action in Frame 38]
callback();

// [Action in Frame 39]
stop ();

// [Action in Frame 40]
_root.Slideshow.loadMovie("slides/" + array_list[curr_index].file);
if (pause_media)
{
    fftoggle.gotoAndStop(2);
} // end if

// [Action in Frame 41]
stop ();

// [Action in Frame 42]
function resize_paper()
{
    trace ("//////////////////// resize_paper function executed \\\\\\\\\\\\\\\\\\\\\\");
    _root.HeadMov.stop();
    _root.HeadMov.clear();
    if (marked_page != 0)
    {
        _root.FlashPaperHolder.setCurrentPage(marked_page);
        marked_page = 0;
    } // end if
    if (ex_Ltarg != "")
    {
        _root.FlashPaperHolder.goToLinkTarget(ex_Ltarg);
        ex_Ltarg = "";
    } // end if
    _root.FlashPaperHolder.setSize(800, 600);
    _root.FlashPaperHolder.setCurrentZoom(zoom_pref);
    zoom_pref = 100;
    _root.FlashPaperHolder._alpha = 100;
    _root.fixFlashPaper2SelectionManagement(_root.FlashPaperHolder);
    zoom_pref = 0;
    marked_page = 0;
} // End of the function
_root.bookM_add.gotoAndStop("enable");
if (curr_outline != main_out || start_point[0] == 0 || viewing_page)
{
    if (!return_btn._visible)
    {
        return_btn._visible = true;
    } // end if
} // end if
if (start_point[0] == 0)
{
    fp_ffButton._visible = false;
    fp_rewButton._visible = false;
    itemTrack.text = "";
}
else
{
    fp_ffButton._visible = true;
    fp_rewButton._visible = true;
} // end else if
if (curr_subj == 0)
{
    _root.FlashPaperHolder.loadMovie(docDir + toc_arr.Supp[curr_topic].Obj);
    trace ("toc_arr[Supp][" + curr_topic + "][Obj] = " + toc_arr.Supp[curr_topic].Obj);
    if (zoom_pref == 0 && marked_page == 0)
    {
        zoom_pref = 100;
        marked_page = 1;
    } // end if
}
else
{
    if (zoom_pref == 0 && marked_page == 0)
    {
        zoom_pref = array_list[curr_index].zoom;
        marked_page = array_list[curr_index].page;
    } // end if
    _root.FlashPaperHolder.loadMovie(docDir + array_list[curr_index].file + ".swf");
    trace ("array_list[" + curr_index + "][file] = " + array_list[curr_index].file);
} // end else if
trace ("<------------------------------- as/flashpaper.as is finished loading ------------------------->");

// [Action in Frame 54]
resize_paper();
stop ();

// [Action in Frame 55]

// [Action in Frame 56]
function show_quiz()
{
    load_status.gotoAndStop("done");
    trace ("sqb._y = " + sqb._y);
    trace ("instructions._y + instructions._height + ((mainScreenBack._height - (instructions._y - mainScreenBack._y) - instructions._height - sqb._height)/2) = " + instructions._y + " + " + instructions._height + " + ((" + mainScreenBack._height + " - " + (instructions._y - mainScreenBack._y) + " - " + instructions._height + " - " + sqb._height + ")/2) = " + (instructions._y + instructions._height) + " + (" + (mainScreenBack._height - (instructions._y - mainScreenBack._y) - instructions._height - sqb._height) + "/2) = " + (instructions._y + instructions._height + (mainScreenBack._height - (instructions._y - mainScreenBack._y) - instructions._height - sqb._height) / 2));
    sqb._y = instructions._y + instructions._height + (mainScreenBack._height - (instructions._y - mainScreenBack._y) - instructions._height - sqb._height) / 2;
    trace ("sqb._y = " + sqb._y);
    sqb.take_quiz._visible = true;
    if (array_list[curr_index].b_text == "" || array_list[curr_index].b_text == undefined)
    {
        trace ("qBeginBT = " + qBeginBT);
        sqb.take_quiz.label = qBeginBT;
        sqb.take_quiz.setStyle("color", qbuttons.color);
    }
    else
    {
        trace ("array_list[" + curr_index + "][b_text] = " + array_list[curr_index].b_text);
        sqb.take_quiz.label = array_list[curr_index].b_text;
        sqb.take_quiz.setStyle("color", qbuttons.color);
    } // end else if
} // End of the function
function starttest()
{
    gotoAndPlay("InitQuiz");
} // End of the function
_root.titleInd.setTextFormat(subTtl);
quiz_name.text = _root.titleInd.text = outlines[main_out].Subject[curr_subj].Topic[curr_topic].name;
quiz_name.setTextFormat(quizTitle);
if (array_list[curr_index].quest == "" || array_list[curr_index].quest == undefined)
{
    num_quest.text = "";
}
else
{
    num_quest.text = "( " + array_list[curr_index].quest + " questions )";
    num_quest.setTextFormat(qqNum);
} // end else if
if (array_list[curr_index].instruct == "" || array_list[curr_index].instruct == undefined)
{
    instructios.autoSize = true;
    if (quiz_inst == "" || quiz_inst == "")
    {
        instructions.text = "";
    }
    else
    {
        instructions._height = 10;
        instructions.autoSize = true;
        instructions.htmlText = quiz_inst;
        instructions.setTextFormat(quizInst);
    } // end else if
}
else
{
    instructions._height = 10;
    instructions.autoSize = true;
    instructions.htmlText = array_list[curr_index].instruct;
    instructions.setTextFormat(quizInst);
} // end else if
_root.titleInd.setTextFormat(subTtl);
if (_root.lms == "TRUE")
{
    _root.VidFile = "";
    _root.TestID = array_list[curr_index].file;
    myTest = new XML();
    myTest.load("/quizxml.asp?TestID=" + _root.TestID + "&CourseID=" + _root.CourseID);
    load_status._visible = true;
    load_status.gotoAndPlay("loading");
    load_status._y = instructions._y + instructions._height + (mainScreenBack._height - (instructions._y - mainScreenBack._y) - instructions._height - load_status._height) / 2;
    myTest.onLoad = show_quiz;
    myTest.ignoreWhite = true;
}
else
{
    myTest = new XML();
    trace ("array_list[" + curr_index + "][file] = " + array_list[curr_index].file);
    myTest.load("dat/" + array_list[curr_index].file + ".xml");
    trace ("outlines[main_out].Subject[" + curr_subj + "].Topic[" + curr_topic + "].name = " + outlines[main_out].Subject[curr_subj].Topic[curr_topic].name);
    myTest.onLoad = show_quiz;
    myTest.ignoreWhite = true;
} // end else if
stop ();

// [Action in Frame 57]
function decimal_place(num, places)
{
    var _loc2 = "";
    var _loc5 = "";
    var _loc3 = num;
    if (num != Math.round(num))
    {
        _loc2 = String(num).substring(String(num).indexOf(".") + places + 1);
        if (_loc2 != "" || _loc2 != undefined)
        {
            _loc3 = Number(String(num).substring(0, String(num).indexOf(".") + places + 1));
            if (Number(_loc2.substr(0, 1)) >= 5 && !isNaN(Number(_loc2.substr(0, 1))))
            {
                _loc3 = _loc3 + 1 / Math.pow(10, places);
            } // end if
        } // end if
    } // end if
    return (_loc3);
} // End of the function
function record_Qdata(sr, ca, pp, scr)
{
    detail_record[qCount - 1].push(section);
    switch (qType)
    {
        case "mchoice":
        {
            detail_record[qCount - 1].push("Multiple Choice");
            break;
        } 
        case "truefalse":
        {
            detail_record[qCount - 1].push("True and False");
            break;
        } 
        case "shortans":
        {
            detail_record[qCount - 1].push("Short Answer");
            break;
        } 
        case "match":
        {
            detail_record[qCount - 1].push("Matching");
            break;
        } 
        case "order":
        {
            detail_record[qCount - 1].push("Ordering");
            break;
        } 
        case "group":
        {
            detail_record[qCount - 1].push("Grouping");
            break;
        } 
        case "hotspot":
        {
            detail_record[qCount - 1].push("Hot Spot");
            break;
        } 
        case "hotobj":
        {
            detail_record[qCount - 1].push("Hot Object");
            break;
        } 
    } // End of switch
    detail_record[qCount - 1].push(sr);
    detail_record[qCount - 1].push(ca);
    detail_record[qCount - 1].push(pp);
    detail_record[qCount - 1].push(scr);
} // End of the function
function countThis()
{
    ans_record[qCount] = ans_order;
    ++qCount;
} // End of the function
_global.styles.TextInput.setStyle("backgroundColor", _root.BackColor);
_global.styles.TextInput.setStyle("border styles", "solid");
_global.styles.TextInput.setStyle("fontSize", 16);
_global.styles.TextInput.setStyle("marginLeft", 5);
Template_ControlButton.setStyle("color", 51);
_global.percent_format = 0;
_global.total_wrong = 0;
_global.total_correct = 0;
rootNode = myTest.firstChild;
totalQuestions = rootNode.childNodes.length;
qCount = 0;
trace ("(rootNode.attributes.OpenNote.substr(0,1).toLowerCase() != t) = " + (rootNode.attributes.OpenNote.substr(0, 1).toLowerCase() != "t"));
trace ("(rootNode.attributes.OpenNote == undefined) = " + (rootNode.attributes.OpenNote == undefined));
if (rootNode.attributes.OpenNote.substr(0, 1).toLowerCase() != "t" || rootNode.attributes.OpenNote == undefined)
{
    close_notepad();
    notes_btn.gotoAndStop("disable");
    trace ("Also make notepad disapear if it\'s currently open.");
} // end if
if (rootNode.attributes.Quest != undefined)
{
    if (!isNaN(Number(rootNode.attributes.Quest)) && Number(rootNode.attributes.Quest) < totalQuestions)
    {
        totalQuestions = Number(rootNode.attributes.Quest);
    } // end if
} // end if
if (rootNode.attributes.SectionID != undefined)
{
    _root.sectID = rootNode.attributes.SectionID;
} // end if
var quest_order = Array(totalQuestions);
var possible_quest = Array(totalQuestions);
var question_pos = Array();
var ans_record = Array();
var letters = ["A. ", "B. ", "C. ", "D. ", "E. ", "F. ", "G. ", "H. "];
var detail_record = Array();
var exponents = [1];
var breaks = ["<br>"];
var spaces = [" "];
var max_ans = 8;
var correct_ans = 0;
var rand_num = 0;
var num_ans = 0;
var subClass = "";
var extension = "";
var expNum = 8;
var weighted = false;
var points_pos = 0;
var text_entered = false;
var detail_record = Array();
var resend_data = Array();
var show_detail = true;
var quizSec = 0;
bookM_add.gotoAndStop("disable");
bookM_goto.gotoAndStop("disable");
bookM_del.gotoAndStop("disable");
var e = exponents.length;
while (e < expNum)
{
    breaks.push(breaks[e - 1] + breaks[e - 1]);
    spaces.push(spaces[e - 1] + spaces[e - 1]);
    exponents.push(exponents[e - 1] + exponents[e - 1]);
    ++e;
} // end while
var x = 0;
while (x < totalQuestions)
{
    detail_record[x] = new Array();
    ++x;
} // end while
if (rootNode.attributes.Detail != undefined)
{
    if (rootNode.attributes.Detail.toLowerCase() == "false")
    {
        show_detail = false;
    } // end if
} // end if
if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "quest")
{
    var i = 0;
    while (i < rootNode.childNodes.length)
    {
        possible_quest[i] = i;
        if (i < totalQuestions)
        {
            question_pos[i] = i;
        } // end if
        ++i;
    } // end while
    var i = 0;
    while (i < rootNode.childNodes.length)
    {
        if (rootNode.childNodes[i].attributes.Include.toLowerCase() == "yes" || rootNode.childNodes[i].attributes.Include.toLowerCase() == "true")
        {
            rand_num = Math.round(Math.random() * (question_pos.length - 1));
            quest_order[question_pos[rand_num]] = i;
            possible_quest.splice(i, 1);
            question_pos.splice(rand_num, 1);
        } // end if
        ++i;
    } // end while
    var j = question_pos.length - 1;
    while (j >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_quest.length - 1));
        quest_order[question_pos[j]] = possible_quest[rand_num];
        possible_quest.splice(rand_num, 1);
        --j;
    } // end while
}
else
{
    var k = 0;
    while (k < totalQuestions)
    {
        quest_order[k] = k;
        ++k;
    } // end while
} // end else if
if (_root.lms == "TRUE")
{
    fscommand("reset");
} // end if

// [Action in Frame 58]
quizLoader._visible = false;
if (qCount < totalQuestions)
{
    gotoAndPlay(rootNode.childNodes[quest_order[qCount]].nodeName);
}
else
{
    _global.total_correct = decimal_place(_global.total_correct, 1);
    _global.percent_format = Math.round(_global.total_correct / points_pos * 100);
    _global.percent_format = String(_global.percent_format) + "%";
    gotoAndPlay("results");
} // end else if

// [Action in Frame 59]
if (rootNode.childNodes[quest_order[qCount]].attributes.Media != undefined)
{
    extension = rootNode.childNodes[quest_order[qCount]].attributes.Media.substring(rootNode.childNodes[quest_order[qCount]].attributes.Media.indexOf(".") + 1);
    extension = extension.toLowerCase();
    switch (extension)
    {
        case "mp3":
        {
            subClass = "mc_aud";
            break;
        } 
        case "flv":
        {
            subClass = "mc_vid";
            break;
        } 
        case "jpg":
        {
            subClass = "mc_img";
            break;
        } 
        default:
        {
            subClass = "mc_plain";
        } 
    } // End of switch
}
else
{
    subClass = "mc_plain";
} // end else if
gotoAndPlay(subClass);

// [Action in Frame 60]
fade.play();

// [Action in Frame 61]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
Q_Component._visible = false;
var h = 1;
while (h <= max_ans)
{
    this["Checkbox" + h]._visible = false;
    this["txt_mc" + h]._visible = false;
    ++h;
} // end while
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var mclListener = new Object();
var numLines = 0;
var numSpaces = 0;
var remainder = 0;
var remainderH = 0;
var scrollInc = 10;
var linesFull = 10;
var emptySpace = "";
var tempLines = 0;
var tempSpaces = 0;
var ref_text = Array();
corr_ans = 0;
text_scroll._visible = false;
var a = 1;
while (a <= max_ans)
{
    _root["txt_mc" + a].setNewTextFormat(ansTxt);
    ++a;
} // end while
assignQtext();
if (rootNode.childNodes[quest_order[qCount]].attributes.ResizeImage.toLowerCase() == "false")
{
    resizeimage = false;
} // end if
switch (subClass)
{
    case "mc_vid":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "FLV");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "mc_aud":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "MP3");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "mc_img":
    {
        if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "true")
        {
            cropimage = true;
        }
        else
        {
            cropimage = false;
        } // end else if
        mclListener.onLoadError = function (target_mc, errorCode)
        {
            trace ("ERROR!");
            switch (errorCode)
            {
                case "URLNotFound":
                {
                    trace ("\t Unable to connect to URL: " + target_mc._url);
                    break;
                } 
                case "LoadNeverCompleted":
                {
                    trace ("\t Unable to complete download: " + target_mc);
                    break;
                } 
            } // End of switch
        };
        mclListener.onLoadInit = function (target_mc)
        {
            if (resizeimage)
            {
                percW = targ_imgW / target_mc._width;
                percH = targ_imgH / target_mc._height;
                if (cropimage)
                {
                    if (percW > percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                        alignment = "W";
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                        alignment = "H";
                    } // end else if
                }
                else
                {
                    alignment = "C";
                    if (percW < percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                    } // end else if
                } // end else if
            }
            else if (target_mc._height < targ_imgH)
            {
                target_mc._y = (targ_imgH - target_mc._height) / 2;
                imgPane.imgOutline._y = target_mc._y;
            } // end else if
            if (target_mc._width > targ_imgW)
            {
                target_mc._x = 0;
            }
            else
            {
                target_mc._x = (targ_imgW - target_mc._width) / 2;
            } // end else if
            numLines = (imgPane.image._height - targ_imgH) / scrollInc;
            remainder = numLines - Math.floor(numLines);
            numLines = Math.floor(numLines);
            numSpaces = (imgPane.image._width - targ_imgW) / scrollInc;
            remainderH = numSpaces - Math.floor(numSpaces);
            numSpaces = Math.floor(numSpaces);
            if (target_mc._width > targ_imgW)
            {
                imgPane.imgOutline._width = targ_imgW;
            }
            else
            {
                imgPane.imgOutline._x = target_mc._x;
                imgPane.imgOutline._width = target_mc._width;
            } // end else if
            if (imgPane.imgOutline._height >= target_mc._height)
            {
                imgPane.imgOutline._height = target_mc._height;
                numLines = 0;
                target_mc._x = target_mc._x + image_scroll._width / 2;
                imgPane.imgOutline._x = imgPane.imgOutline._x + image_scroll._width / 2;
                image_scroll._visible = false;
            }
            else if (target_mc._width <= targ_imgW)
            {
                image_scroll._x = target_mc._x + target_mc._width + imgPane._x;
            }
            else
            {
                image_scroll._x = target_mc._x + imgPane.imgOutline._width + imgPane._x;
            } // end else if
            if (numLines > 0)
            {
                tempLines = numLines + linesFull;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempLines / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + breaks[_loc1];
                        tempLines = tempLines - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scroll.htmlText = text_scroll.htmlText + emptySpace;
                image_scroll._visible = true;
            } // end if
            emptySpace = "";
            if (numSpaces > 0)
            {
                tempSpaces = numSpaces;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempSpaces / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + spaces[_loc1];
                        tempSpaces = tempSpaces - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scrollH.text = text_scrollH.text + emptySpace;
                cornerFill._visible = true;
                image_scrollH._visible = true;
                image_scrollH._x = imgPane._x;
                image_scrollH._y = cornerFill._y;
            } // end if
        };
        var image_mcl = new MovieClipLoader();
        image_mcl.addListener(mclListener);
        targ_imgW = imgPane.image._width;
        targ_imgH = imgPane.image._height;
        image_mcl.loadClip(rootNode.childNodes[quest_order[qCount]].attributes.Media, imgPane.image);
        break;
    } 
} // End of switch
var a = 0;
while (a < num_ans)
{
    ansID[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.aID;
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct.toLowerCase() == "yes")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        _global.correctletter = letters[a];
        CResponse[a] = true;
        ++corr_ans;
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct.toLowerCase() == "no")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        CResponse[a] = false;
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue != undefined || rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue != "")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        CResponse[a] = false;
    }
    else
    {
        CResponse[a] = false;
        Distractors[a] = "";
    } // end else if
    ++a;
} // end while
if (corr_ans == 1)
{
    feedback_text = "Sorry, the correct answer is ";
}
else
{
    feedback_text = "Sorry, the correct answers are ";
} // end else if
countThis();
stop ();

// [Action in Frame 62]
fade.play();

// [Action in Frame 63]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
cornerFill._visible = false;
Q_Component._visible = false;
var h = 1;
while (h <= max_ans)
{
    this["Checkbox" + h]._visible = false;
    this["txt_mc" + h]._visible = false;
    ++h;
} // end while
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var mclListener = new Object();
var numLines = 0;
var numSpaces = 0;
var remainder = 0;
var remainderH = 0;
var scrollInc = 10;
var linesFull = 10;
var emptySpace = "";
var tempLines = 0;
var tempSpaces = 0;
var ref_text = Array();
corr_ans = 0;
text_scroll._visible = false;
var a = 1;
while (a <= max_ans)
{
    _root["txt_mc" + a].setNewTextFormat(ansTxt);
    ++a;
} // end while
assignQtext();
if (rootNode.childNodes[quest_order[qCount]].attributes.ResizeImage.toLowerCase() == "false")
{
    resizeimage = false;
} // end if
switch (subClass)
{
    case "mc_vid":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "FLV");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "mc_aud":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "MP3");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "mc_img":
    {
        if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "true")
        {
            cropimage = true;
        }
        else
        {
            cropimage = false;
        } // end else if
        mclListener.onLoadError = function (target_mc, errorCode)
        {
            trace ("ERROR!");
            switch (errorCode)
            {
                case "URLNotFound":
                {
                    trace ("\t Unable to connect to URL: " + target_mc._url);
                    break;
                } 
                case "LoadNeverCompleted":
                {
                    trace ("\t Unable to complete download: " + target_mc);
                    break;
                } 
            } // End of switch
        };
        mclListener.onLoadInit = function (target_mc)
        {
            if (resizeimage)
            {
                percW = targ_imgW / target_mc._width;
                percH = targ_imgH / target_mc._height;
                if (cropimage)
                {
                    if (percW > percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                        alignment = "W";
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                        alignment = "H";
                    } // end else if
                }
                else
                {
                    alignment = "C";
                    if (percW < percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                    } // end else if
                } // end else if
            }
            else if (target_mc._height < targ_imgH)
            {
                target_mc._y = (targ_imgH - target_mc._height) / 2;
                imgPane.imgOutline._y = target_mc._y;
            } // end else if
            if (target_mc._width > targ_imgW)
            {
                target_mc._x = 0;
            }
            else
            {
                target_mc._x = (targ_imgW - target_mc._width) / 2;
            } // end else if
            numLines = (imgPane.image._height - targ_imgH) / scrollInc;
            remainder = numLines - Math.floor(numLines);
            numLines = Math.floor(numLines);
            numSpaces = (imgPane.image._width - targ_imgW) / scrollInc;
            remainderH = numSpaces - Math.floor(numSpaces);
            numSpaces = Math.floor(numSpaces);
            if (target_mc._width > targ_imgW)
            {
                imgPane.imgOutline._width = targ_imgW;
            }
            else
            {
                imgPane.imgOutline._x = target_mc._x;
                imgPane.imgOutline._width = target_mc._width;
            } // end else if
            if (imgPane.imgOutline._height >= target_mc._height)
            {
                imgPane.imgOutline._height = target_mc._height;
                numLines = 0;
                target_mc._x = target_mc._x + image_scroll._width / 2;
                imgPane.imgOutline._x = imgPane.imgOutline._x + image_scroll._width / 2;
                image_scroll._visible = false;
            }
            else if (target_mc._width <= targ_imgW)
            {
                image_scroll._x = target_mc._x + target_mc._width + imgPane._x;
            }
            else
            {
                image_scroll._x = target_mc._x + imgPane.imgOutline._width + imgPane._x;
            } // end else if
            if (numLines > 0)
            {
                tempLines = numLines + linesFull;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempLines / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + breaks[_loc1];
                        tempLines = tempLines - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scroll.htmlText = text_scroll.htmlText + emptySpace;
                image_scroll._visible = true;
            } // end if
            emptySpace = "";
            if (numSpaces > 0)
            {
                tempSpaces = numSpaces;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempSpaces / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + spaces[_loc1];
                        tempSpaces = tempSpaces - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scrollH.text = text_scrollH.text + emptySpace;
                cornerFill._visible = true;
                image_scrollH._visible = true;
                image_scrollH._x = imgPane._x;
                image_scrollH._y = cornerFill._y;
            } // end if
        };
        var image_mcl = new MovieClipLoader();
        image_mcl.addListener(mclListener);
        targ_imgW = imgPane.image._width;
        targ_imgH = imgPane.image._height;
        image_mcl.loadClip(rootNode.childNodes[quest_order[qCount]].attributes.Media, imgPane.image);
        break;
    } 
} // End of switch
var a = 0;
while (a < num_ans)
{
    ansID[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.aID;
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct.toLowerCase() == "yes")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        _global.correctletter = letters[a];
        CResponse[a] = true;
        ++corr_ans;
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct.toLowerCase() == "no")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        CResponse[a] = false;
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue != undefined || rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue != "")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        CResponse[a] = false;
    }
    else
    {
        CResponse[a] = false;
        Distractors[a] = "";
    } // end else if
    ++a;
} // end while
if (corr_ans == 1)
{
    feedback_text = "Sorry, the correct answer is ";
}
else
{
    feedback_text = "Sorry, the correct answers are ";
} // end else if
countThis();
stop ();

// [Action in Frame 64]
fade.play();

// [Action in Frame 65]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
Q_Component._visible = false;
var h = 1;
while (h <= max_ans)
{
    this["Checkbox" + h]._visible = false;
    this["txt_mc" + h]._visible = false;
    ++h;
} // end while
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var mclListener = new Object();
var numLines = 0;
var numSpaces = 0;
var remainder = 0;
var remainderH = 0;
var scrollInc = 10;
var linesFull = 10;
var emptySpace = "";
var tempLines = 0;
var tempSpaces = 0;
var ref_text = Array();
corr_ans = 0;
text_scroll._visible = false;
var a = 1;
while (a <= max_ans)
{
    _root["txt_mc" + a].setNewTextFormat(ansTxt);
    ++a;
} // end while
assignQtext();
if (rootNode.childNodes[quest_order[qCount]].attributes.ResizeImage.toLowerCase() == "false")
{
    resizeimage = false;
} // end if
switch (subClass)
{
    case "mc_vid":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "FLV");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "mc_aud":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "MP3");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "mc_img":
    {
        if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "true")
        {
            cropimage = true;
        }
        else
        {
            cropimage = false;
        } // end else if
        mclListener.onLoadError = function (target_mc, errorCode)
        {
            trace ("ERROR!");
            switch (errorCode)
            {
                case "URLNotFound":
                {
                    trace ("\t Unable to connect to URL: " + target_mc._url);
                    break;
                } 
                case "LoadNeverCompleted":
                {
                    trace ("\t Unable to complete download: " + target_mc);
                    break;
                } 
            } // End of switch
        };
        mclListener.onLoadInit = function (target_mc)
        {
            if (resizeimage)
            {
                percW = targ_imgW / target_mc._width;
                percH = targ_imgH / target_mc._height;
                if (cropimage)
                {
                    if (percW > percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                        alignment = "W";
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                        alignment = "H";
                    } // end else if
                }
                else
                {
                    alignment = "C";
                    if (percW < percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                    } // end else if
                } // end else if
            }
            else if (target_mc._height < targ_imgH)
            {
                target_mc._y = (targ_imgH - target_mc._height) / 2;
                imgPane.imgOutline._y = target_mc._y;
            } // end else if
            if (target_mc._width > targ_imgW)
            {
                target_mc._x = 0;
            }
            else
            {
                target_mc._x = (targ_imgW - target_mc._width) / 2;
            } // end else if
            numLines = (imgPane.image._height - targ_imgH) / scrollInc;
            remainder = numLines - Math.floor(numLines);
            numLines = Math.floor(numLines);
            numSpaces = (imgPane.image._width - targ_imgW) / scrollInc;
            remainderH = numSpaces - Math.floor(numSpaces);
            numSpaces = Math.floor(numSpaces);
            if (target_mc._width > targ_imgW)
            {
                imgPane.imgOutline._width = targ_imgW;
            }
            else
            {
                imgPane.imgOutline._x = target_mc._x;
                imgPane.imgOutline._width = target_mc._width;
            } // end else if
            if (imgPane.imgOutline._height >= target_mc._height)
            {
                imgPane.imgOutline._height = target_mc._height;
                numLines = 0;
                target_mc._x = target_mc._x + image_scroll._width / 2;
                imgPane.imgOutline._x = imgPane.imgOutline._x + image_scroll._width / 2;
                image_scroll._visible = false;
            }
            else if (target_mc._width <= targ_imgW)
            {
                image_scroll._x = target_mc._x + target_mc._width + imgPane._x;
            }
            else
            {
                image_scroll._x = target_mc._x + imgPane.imgOutline._width + imgPane._x;
            } // end else if
            if (numLines > 0)
            {
                tempLines = numLines + linesFull;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempLines / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + breaks[_loc1];
                        tempLines = tempLines - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scroll.htmlText = text_scroll.htmlText + emptySpace;
                image_scroll._visible = true;
            } // end if
            emptySpace = "";
            if (numSpaces > 0)
            {
                tempSpaces = numSpaces;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempSpaces / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + spaces[_loc1];
                        tempSpaces = tempSpaces - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scrollH.text = text_scrollH.text + emptySpace;
                cornerFill._visible = true;
                image_scrollH._visible = true;
                image_scrollH._x = imgPane._x;
                image_scrollH._y = cornerFill._y;
            } // end if
        };
        var image_mcl = new MovieClipLoader();
        image_mcl.addListener(mclListener);
        targ_imgW = imgPane.image._width;
        targ_imgH = imgPane.image._height;
        image_mcl.loadClip(rootNode.childNodes[quest_order[qCount]].attributes.Media, imgPane.image);
        break;
    } 
} // End of switch
var a = 0;
while (a < num_ans)
{
    ansID[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.aID;
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct.toLowerCase() == "yes")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        _global.correctletter = letters[a];
        CResponse[a] = true;
        ++corr_ans;
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct.toLowerCase() == "no")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        CResponse[a] = false;
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue != undefined || rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue != "")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        CResponse[a] = false;
    }
    else
    {
        CResponse[a] = false;
        Distractors[a] = "";
    } // end else if
    ++a;
} // end while
if (corr_ans == 1)
{
    feedback_text = "Sorry, the correct answer is ";
}
else
{
    feedback_text = "Sorry, the correct answers are ";
} // end else if
countThis();
_root.QuizMov.play();
stop ();

// [Action in Frame 66]
fade.play();

// [Action in Frame 67]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
Q_Component._visible = false;
var h = 1;
while (h <= max_ans)
{
    this["Checkbox" + h]._visible = false;
    this["txt_mc" + h]._visible = false;
    ++h;
} // end while
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var mclListener = new Object();
var numLines = 0;
var numSpaces = 0;
var remainder = 0;
var remainderH = 0;
var scrollInc = 10;
var linesFull = 10;
var emptySpace = "";
var tempLines = 0;
var tempSpaces = 0;
var ref_text = Array();
corr_ans = 0;
text_scroll._visible = false;
var a = 1;
while (a <= max_ans)
{
    _root["txt_mc" + a].setNewTextFormat(ansTxt);
    ++a;
} // end while
assignQtext();
if (rootNode.childNodes[quest_order[qCount]].attributes.ResizeImage.toLowerCase() == "false")
{
    resizeimage = false;
} // end if
switch (subClass)
{
    case "mc_vid":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "FLV");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "mc_aud":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "MP3");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "mc_img":
    {
        if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "true")
        {
            cropimage = true;
        }
        else
        {
            cropimage = false;
        } // end else if
        mclListener.onLoadError = function (target_mc, errorCode)
        {
            trace ("ERROR!");
            switch (errorCode)
            {
                case "URLNotFound":
                {
                    trace ("\t Unable to connect to URL: " + target_mc._url);
                    break;
                } 
                case "LoadNeverCompleted":
                {
                    trace ("\t Unable to complete download: " + target_mc);
                    break;
                } 
            } // End of switch
        };
        mclListener.onLoadInit = function (target_mc)
        {
            if (resizeimage)
            {
                percW = targ_imgW / target_mc._width;
                percH = targ_imgH / target_mc._height;
                if (cropimage)
                {
                    if (percW > percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                        alignment = "W";
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                        alignment = "H";
                    } // end else if
                }
                else
                {
                    alignment = "C";
                    if (percW < percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                    } // end else if
                } // end else if
            }
            else if (target_mc._height < targ_imgH)
            {
                target_mc._y = (targ_imgH - target_mc._height) / 2;
                imgPane.imgOutline._y = target_mc._y;
            } // end else if
            if (target_mc._width > targ_imgW)
            {
                target_mc._x = 0;
            }
            else
            {
                target_mc._x = (targ_imgW - target_mc._width) / 2;
            } // end else if
            numLines = (imgPane.image._height - targ_imgH) / scrollInc;
            remainder = numLines - Math.floor(numLines);
            numLines = Math.floor(numLines);
            numSpaces = (imgPane.image._width - targ_imgW) / scrollInc;
            remainderH = numSpaces - Math.floor(numSpaces);
            numSpaces = Math.floor(numSpaces);
            if (target_mc._width > targ_imgW)
            {
                imgPane.imgOutline._width = targ_imgW;
            }
            else
            {
                imgPane.imgOutline._x = target_mc._x;
                imgPane.imgOutline._width = target_mc._width;
            } // end else if
            if (imgPane.imgOutline._height >= target_mc._height)
            {
                imgPane.imgOutline._height = target_mc._height;
                numLines = 0;
                target_mc._x = target_mc._x + image_scroll._width / 2;
                imgPane.imgOutline._x = imgPane.imgOutline._x + image_scroll._width / 2;
                image_scroll._visible = false;
            }
            else if (target_mc._width <= targ_imgW)
            {
                image_scroll._x = target_mc._x + target_mc._width + imgPane._x;
            }
            else
            {
                image_scroll._x = target_mc._x + imgPane.imgOutline._width + imgPane._x;
            } // end else if
            if (numLines > 0)
            {
                tempLines = numLines + linesFull;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempLines / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + breaks[_loc1];
                        tempLines = tempLines - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scroll.htmlText = text_scroll.htmlText + emptySpace;
                image_scroll._visible = true;
            } // end if
            emptySpace = "";
            if (numSpaces > 0)
            {
                tempSpaces = numSpaces;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempSpaces / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + spaces[_loc1];
                        tempSpaces = tempSpaces - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scrollH.text = text_scrollH.text + emptySpace;
                cornerFill._visible = true;
                image_scrollH._visible = true;
                image_scrollH._x = imgPane._x;
                image_scrollH._y = cornerFill._y;
            } // end if
        };
        var image_mcl = new MovieClipLoader();
        image_mcl.addListener(mclListener);
        targ_imgW = imgPane.image._width;
        targ_imgH = imgPane.image._height;
        image_mcl.loadClip(rootNode.childNodes[quest_order[qCount]].attributes.Media, imgPane.image);
        break;
    } 
} // End of switch
var a = 0;
while (a < num_ans)
{
    ansID[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.aID;
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct.toLowerCase() == "yes")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        _global.correctletter = letters[a];
        CResponse[a] = true;
        ++corr_ans;
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct.toLowerCase() == "no")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        CResponse[a] = false;
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue != undefined || rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue != "")
    {
        if (mcq_info[ans_order[a]][2] == 1)
        {
            Distractors[a] = "";
            ref_text = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue.split("~~");
            var i = 0;
            while (i < ref_text.length)
            {
                if (ref_text[i] != "")
                {
                    var j = 0;
                    while (j < ans_order.length)
                    {
                        if (ref_text[i] == mcq_info[ans_order[j]][0])
                        {
                            ref_text[i] = String.fromCharCode(j + 65);
                        } // end if
                        ++j;
                    } // end while
                    Distractors[a] = Distractors[a] + ref_text[i];
                } // end if
                ++i;
            } // end while
        }
        else
        {
            Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        } // end else if
        CResponse[a] = false;
    }
    else
    {
        CResponse[a] = false;
        Distractors[a] = "";
    } // end else if
    ++a;
} // end while
if (corr_ans == 1)
{
    feedback_text = "Sorry, the correct answer is ";
}
else
{
    feedback_text = "Sorry, the correct answers are ";
} // end else if
countThis();
_root.QuizMov.play();
stop ();

// [Action in Frame 68]
if (rootNode.childNodes[quest_order[qCount]].attributes.Media != undefined)
{
    extension = rootNode.childNodes[quest_order[qCount]].attributes.Media.substring(rootNode.childNodes[quest_order[qCount]].attributes.Media.indexOf(".") + 1);
    extension = extension.toLowerCase();
    switch (extension)
    {
        case "mp3":
        {
            subClass = "tf_aud";
            break;
        } 
        case "flv":
        {
            subClass = "tf_vid";
            break;
        } 
        case "jpg":
        {
            subClass = "tf_img";
            break;
        } 
        default:
        {
            subClass = "tf_plain";
        } 
    } // End of switch
}
else
{
    subClass = "tf_plain";
} // end else if
gotoAndPlay(subClass);

// [Action in Frame 69]
fade.play();

// [Action in Frame 70]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var mclListener = new Object();
var numLines = 0;
var numSpaces = 0;
var remainder = 0;
var remainderH = 0;
var scrollInc = 10;
var tempSpaces = 0;
var linesFull = 14;
var emptySpace = "";
var tempLines = 0;
var tf_ans = false;
text_scroll._visible = false;
assignQtext();
if (rootNode.childNodes[quest_order[qCount]].attributes.ResizeImage.toLowerCase() == "false")
{
    resizeimage = false;
} // end if
switch (subClass)
{
    case "tf_vid":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "FLV");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "tf_aud":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "MP3");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "tf_img":
    {
        if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "true")
        {
            cropimage = true;
        }
        else
        {
            cropimage = false;
        } // end else if
        mclListener.onLoadError = function (target_mc, errorCode)
        {
            trace ("ERROR!");
            switch (errorCode)
            {
                case "URLNotFound":
                {
                    trace ("\t Unable to connect to URL: " + target_mc._url);
                    break;
                } 
                case "LoadNeverCompleted":
                {
                    trace ("\t Unable to complete download: " + target_mc);
                    break;
                } 
            } // End of switch
        };
        mclListener.onLoadInit = function (target_mc)
        {
            if (resizeimage)
            {
                percW = targ_imgW / target_mc._width;
                percH = targ_imgH / target_mc._height;
                if (cropimage)
                {
                    if (percW > percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                        alignment = "W";
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                        alignment = "H";
                    } // end else if
                }
                else
                {
                    alignment = "C";
                    if (percW < percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                    } // end else if
                } // end else if
            }
            else if (target_mc._height < targ_imgH)
            {
                target_mc._y = (targ_imgH - target_mc._height) / 2;
            } // end else if
            if (target_mc._width > targ_imgW)
            {
                target_mc._x = 0;
            }
            else
            {
                target_mc._x = (targ_imgW - target_mc._width) / 2;
                imgPane.imgOutline._y = target_mc._y;
            } // end else if
            numLines = (imgPane.image._height - targ_imgH) / scrollInc;
            remainder = numLines - Math.floor(numLines);
            numLines = Math.floor(numLines);
            numSpaces = (imgPane.image._width - targ_imgW) / scrollInc;
            remainderH = numSpaces - Math.floor(numSpaces);
            numSpaces = Math.floor(numSpaces);
            if (target_mc._width > targ_imgW)
            {
                imgPane.imgOutline._width = targ_imgW;
            }
            else
            {
                imgPane.imgOutline._x = target_mc._x;
                imgPane.imgOutline._width = target_mc._width;
            } // end else if
            if (imgPane.imgOutline._height >= target_mc._height)
            {
                imgPane.imgOutline._height = target_mc._height;
                numLines = 0;
                target_mc._x = target_mc._x + image_scroll._width / 2;
                imgPane.imgOutline._x = imgPane.imgOutline._x + image_scroll._width / 2;
                image_scroll._visible = false;
            }
            else if (target_mc._width <= targ_imgW)
            {
                image_scroll._x = target_mc._x + target_mc._width + imgPane._x;
            }
            else
            {
                image_scroll._x = target_mc._x + imgPane.imgOutline._width + imgPane._x;
            } // end else if
            if (numLines > 0)
            {
                tempLines = numLines + linesFull;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempLines / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + breaks[_loc1];
                        tempLines = tempLines - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scroll.htmlText = text_scroll.htmlText + emptySpace;
                image_scroll._visible = true;
            } // end if
            emptySpace = "";
            if (numSpaces > 0)
            {
                tempSpaces = numSpaces;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempSpaces / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + spaces[_loc1];
                        tempSpaces = tempSpaces - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scrollH.text = text_scrollH.text + emptySpace;
                cornerFill._visible = true;
                image_scrollH._visible = true;
                image_scrollH._x = imgPane._x;
                image_scrollH._y = cornerFill._y;
            } // end if
        };
        var image_mcl = new MovieClipLoader();
        image_mcl.addListener(mclListener);
        targ_imgW = imgPane.image._width;
        targ_imgH = imgPane.image._height;
        image_mcl.loadClip(rootNode.childNodes[quest_order[qCount]].attributes.Media, imgPane.image);
        break;
    } 
} // End of switch
Distractors[0] = letters[0] + rootNode.childNodes[quest_order[qCount]].childNodes[1].childNodes[0].nodeValue;
ansID[0] = rootNode.childNodes[quest_order[qCount]].childNodes[1].attributes.aID;
Distractors[1] = letters[1] + rootNode.childNodes[quest_order[qCount]].childNodes[2].childNodes[0].nodeValue;
ansID[1] = rootNode.childNodes[quest_order[qCount]].childNodes[2].attributes.aID;
if (rootNode.childNodes[quest_order[qCount]].childNodes[1].attributes.Correct == "Yes")
{
    tf_ans = true;
}
else
{
    tf_ans = false;
} // end else if
Q_Component.Correct_Response = tf_ans;
feedback_text = "Sorry, the correct answer is ";
countThis();
stop ();

// [Action in Frame 71]
fade.play();

// [Action in Frame 72]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
cornerFill._visible = false;
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var mclListener = new Object();
var numLines = 0;
var numSpaces = 0;
var remainder = 0;
var remainderH = 0;
var scrollInc = 10;
var tempSpaces = 0;
var linesFull = 14;
var emptySpace = "";
var tempLines = 0;
var tf_ans = false;
text_scroll._visible = false;
assignQtext();
if (rootNode.childNodes[quest_order[qCount]].attributes.ResizeImage.toLowerCase() == "false")
{
    resizeimage = false;
} // end if
switch (subClass)
{
    case "tf_vid":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "FLV");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "tf_aud":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "MP3");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "tf_img":
    {
        if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "true")
        {
            cropimage = true;
        }
        else
        {
            cropimage = false;
        } // end else if
        mclListener.onLoadError = function (target_mc, errorCode)
        {
            trace ("ERROR!");
            switch (errorCode)
            {
                case "URLNotFound":
                {
                    trace ("\t Unable to connect to URL: " + target_mc._url);
                    break;
                } 
                case "LoadNeverCompleted":
                {
                    trace ("\t Unable to complete download: " + target_mc);
                    break;
                } 
            } // End of switch
        };
        mclListener.onLoadInit = function (target_mc)
        {
            if (resizeimage)
            {
                percW = targ_imgW / target_mc._width;
                percH = targ_imgH / target_mc._height;
                if (cropimage)
                {
                    if (percW > percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                        alignment = "W";
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                        alignment = "H";
                    } // end else if
                }
                else
                {
                    alignment = "C";
                    if (percW < percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                    } // end else if
                } // end else if
            }
            else if (target_mc._height < targ_imgH)
            {
                target_mc._y = (targ_imgH - target_mc._height) / 2;
            } // end else if
            if (target_mc._width > targ_imgW)
            {
                target_mc._x = 0;
            }
            else
            {
                target_mc._x = (targ_imgW - target_mc._width) / 2;
                imgPane.imgOutline._y = target_mc._y;
            } // end else if
            numLines = (imgPane.image._height - targ_imgH) / scrollInc;
            remainder = numLines - Math.floor(numLines);
            numLines = Math.floor(numLines);
            numSpaces = (imgPane.image._width - targ_imgW) / scrollInc;
            remainderH = numSpaces - Math.floor(numSpaces);
            numSpaces = Math.floor(numSpaces);
            if (target_mc._width > targ_imgW)
            {
                imgPane.imgOutline._width = targ_imgW;
            }
            else
            {
                imgPane.imgOutline._x = target_mc._x;
                imgPane.imgOutline._width = target_mc._width;
            } // end else if
            if (imgPane.imgOutline._height >= target_mc._height)
            {
                imgPane.imgOutline._height = target_mc._height;
                numLines = 0;
                target_mc._x = target_mc._x + image_scroll._width / 2;
                imgPane.imgOutline._x = imgPane.imgOutline._x + image_scroll._width / 2;
                image_scroll._visible = false;
            }
            else if (target_mc._width <= targ_imgW)
            {
                image_scroll._x = target_mc._x + target_mc._width + imgPane._x;
            }
            else
            {
                image_scroll._x = target_mc._x + imgPane.imgOutline._width + imgPane._x;
            } // end else if
            if (numLines > 0)
            {
                tempLines = numLines + linesFull;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempLines / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + breaks[_loc1];
                        tempLines = tempLines - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scroll.htmlText = text_scroll.htmlText + emptySpace;
                image_scroll._visible = true;
            } // end if
            emptySpace = "";
            if (numSpaces > 0)
            {
                tempSpaces = numSpaces;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempSpaces / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + spaces[_loc1];
                        tempSpaces = tempSpaces - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scrollH.text = text_scrollH.text + emptySpace;
                cornerFill._visible = true;
                image_scrollH._visible = true;
                image_scrollH._x = imgPane._x;
                image_scrollH._y = cornerFill._y;
            } // end if
        };
        var image_mcl = new MovieClipLoader();
        image_mcl.addListener(mclListener);
        targ_imgW = imgPane.image._width;
        targ_imgH = imgPane.image._height;
        image_mcl.loadClip(rootNode.childNodes[quest_order[qCount]].attributes.Media, imgPane.image);
        break;
    } 
} // End of switch
Distractors[0] = letters[0] + rootNode.childNodes[quest_order[qCount]].childNodes[1].childNodes[0].nodeValue;
ansID[0] = rootNode.childNodes[quest_order[qCount]].childNodes[1].attributes.aID;
Distractors[1] = letters[1] + rootNode.childNodes[quest_order[qCount]].childNodes[2].childNodes[0].nodeValue;
ansID[1] = rootNode.childNodes[quest_order[qCount]].childNodes[2].attributes.aID;
if (rootNode.childNodes[quest_order[qCount]].childNodes[1].attributes.Correct == "Yes")
{
    tf_ans = true;
}
else
{
    tf_ans = false;
} // end else if
Q_Component.Correct_Response = tf_ans;
feedback_text = "Sorry, the correct answer is ";
countThis();
stop ();

// [Action in Frame 73]
fade.play();

// [Action in Frame 74]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
Q_Component._visible = false;
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var mclListener = new Object();
var numLines = 0;
var numSpaces = 0;
var remainder = 0;
var remainderH = 0;
var scrollInc = 10;
var tempSpaces = 0;
var linesFull = 14;
var emptySpace = "";
var tempLines = 0;
var tf_ans = false;
text_scroll._visible = false;
assignQtext();
if (rootNode.childNodes[quest_order[qCount]].attributes.ResizeImage.toLowerCase() == "false")
{
    resizeimage = false;
} // end if
switch (subClass)
{
    case "tf_vid":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "FLV");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "tf_aud":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "MP3");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "tf_img":
    {
        if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "true")
        {
            cropimage = true;
        }
        else
        {
            cropimage = false;
        } // end else if
        mclListener.onLoadError = function (target_mc, errorCode)
        {
            trace ("ERROR!");
            switch (errorCode)
            {
                case "URLNotFound":
                {
                    trace ("\t Unable to connect to URL: " + target_mc._url);
                    break;
                } 
                case "LoadNeverCompleted":
                {
                    trace ("\t Unable to complete download: " + target_mc);
                    break;
                } 
            } // End of switch
        };
        mclListener.onLoadInit = function (target_mc)
        {
            if (resizeimage)
            {
                percW = targ_imgW / target_mc._width;
                percH = targ_imgH / target_mc._height;
                if (cropimage)
                {
                    if (percW > percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                        alignment = "W";
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                        alignment = "H";
                    } // end else if
                }
                else
                {
                    alignment = "C";
                    if (percW < percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                    } // end else if
                } // end else if
            }
            else if (target_mc._height < targ_imgH)
            {
                target_mc._y = (targ_imgH - target_mc._height) / 2;
            } // end else if
            if (target_mc._width > targ_imgW)
            {
                target_mc._x = 0;
            }
            else
            {
                target_mc._x = (targ_imgW - target_mc._width) / 2;
                imgPane.imgOutline._y = target_mc._y;
            } // end else if
            numLines = (imgPane.image._height - targ_imgH) / scrollInc;
            remainder = numLines - Math.floor(numLines);
            numLines = Math.floor(numLines);
            numSpaces = (imgPane.image._width - targ_imgW) / scrollInc;
            remainderH = numSpaces - Math.floor(numSpaces);
            numSpaces = Math.floor(numSpaces);
            if (target_mc._width > targ_imgW)
            {
                imgPane.imgOutline._width = targ_imgW;
            }
            else
            {
                imgPane.imgOutline._x = target_mc._x;
                imgPane.imgOutline._width = target_mc._width;
            } // end else if
            if (imgPane.imgOutline._height >= target_mc._height)
            {
                imgPane.imgOutline._height = target_mc._height;
                numLines = 0;
                target_mc._x = target_mc._x + image_scroll._width / 2;
                imgPane.imgOutline._x = imgPane.imgOutline._x + image_scroll._width / 2;
                image_scroll._visible = false;
            }
            else if (target_mc._width <= targ_imgW)
            {
                image_scroll._x = target_mc._x + target_mc._width + imgPane._x;
            }
            else
            {
                image_scroll._x = target_mc._x + imgPane.imgOutline._width + imgPane._x;
            } // end else if
            if (numLines > 0)
            {
                tempLines = numLines + linesFull;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempLines / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + breaks[_loc1];
                        tempLines = tempLines - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scroll.htmlText = text_scroll.htmlText + emptySpace;
                image_scroll._visible = true;
            } // end if
            emptySpace = "";
            if (numSpaces > 0)
            {
                tempSpaces = numSpaces;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempSpaces / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + spaces[_loc1];
                        tempSpaces = tempSpaces - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scrollH.text = text_scrollH.text + emptySpace;
                cornerFill._visible = true;
                image_scrollH._visible = true;
                image_scrollH._x = imgPane._x;
                image_scrollH._y = cornerFill._y;
            } // end if
        };
        var image_mcl = new MovieClipLoader();
        image_mcl.addListener(mclListener);
        targ_imgW = imgPane.image._width;
        targ_imgH = imgPane.image._height;
        image_mcl.loadClip(rootNode.childNodes[quest_order[qCount]].attributes.Media, imgPane.image);
        break;
    } 
} // End of switch
Distractors[0] = letters[0] + rootNode.childNodes[quest_order[qCount]].childNodes[1].childNodes[0].nodeValue;
ansID[0] = rootNode.childNodes[quest_order[qCount]].childNodes[1].attributes.aID;
Distractors[1] = letters[1] + rootNode.childNodes[quest_order[qCount]].childNodes[2].childNodes[0].nodeValue;
ansID[1] = rootNode.childNodes[quest_order[qCount]].childNodes[2].attributes.aID;
if (rootNode.childNodes[quest_order[qCount]].childNodes[1].attributes.Correct == "Yes")
{
    tf_ans = true;
}
else
{
    tf_ans = false;
} // end else if
Q_Component.Correct_Response = tf_ans;
feedback_text = "Sorry, the correct answer is ";
countThis();
_root.QuizMov.play();
stop ();

// [Action in Frame 75]
fade.play();

// [Action in Frame 76]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
Q_Component._visible = false;
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var mclListener = new Object();
var numLines = 0;
var numSpaces = 0;
var remainder = 0;
var remainderH = 0;
var scrollInc = 10;
var tempSpaces = 0;
var linesFull = 14;
var emptySpace = "";
var tempLines = 0;
var tf_ans = false;
text_scroll._visible = false;
assignQtext();
if (rootNode.childNodes[quest_order[qCount]].attributes.ResizeImage.toLowerCase() == "false")
{
    resizeimage = false;
} // end if
switch (subClass)
{
    case "tf_vid":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "FLV");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "tf_aud":
    {
        _root.QuizMov.setMedia(rootNode.childNodes[quest_order[qCount]].attributes.Media, "MP3");
        quizScroller.associateDisplay(QuizMov);
        _root.QuizMov.play();
        break;
    } 
    case "tf_img":
    {
        if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "true")
        {
            cropimage = true;
        }
        else
        {
            cropimage = false;
        } // end else if
        mclListener.onLoadError = function (target_mc, errorCode)
        {
            trace ("ERROR!");
            switch (errorCode)
            {
                case "URLNotFound":
                {
                    trace ("\t Unable to connect to URL: " + target_mc._url);
                    break;
                } 
                case "LoadNeverCompleted":
                {
                    trace ("\t Unable to complete download: " + target_mc);
                    break;
                } 
            } // End of switch
        };
        mclListener.onLoadInit = function (target_mc)
        {
            if (resizeimage)
            {
                percW = targ_imgW / target_mc._width;
                percH = targ_imgH / target_mc._height;
                if (cropimage)
                {
                    if (percW > percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                        alignment = "W";
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                        alignment = "H";
                    } // end else if
                }
                else
                {
                    alignment = "C";
                    if (percW < percH)
                    {
                        target_mc._width = target_mc._width * percW;
                        target_mc._height = target_mc._height * percW;
                    }
                    else
                    {
                        target_mc._width = target_mc._width * percH;
                        target_mc._height = target_mc._height * percH;
                    } // end else if
                } // end else if
            }
            else if (target_mc._height < targ_imgH)
            {
                target_mc._y = (targ_imgH - target_mc._height) / 2;
            } // end else if
            if (target_mc._width > targ_imgW)
            {
                target_mc._x = 0;
            }
            else
            {
                target_mc._x = (targ_imgW - target_mc._width) / 2;
                imgPane.imgOutline._y = target_mc._y;
            } // end else if
            numLines = (imgPane.image._height - targ_imgH) / scrollInc;
            remainder = numLines - Math.floor(numLines);
            numLines = Math.floor(numLines);
            numSpaces = (imgPane.image._width - targ_imgW) / scrollInc;
            remainderH = numSpaces - Math.floor(numSpaces);
            numSpaces = Math.floor(numSpaces);
            if (target_mc._width > targ_imgW)
            {
                imgPane.imgOutline._width = targ_imgW;
            }
            else
            {
                imgPane.imgOutline._x = target_mc._x;
                imgPane.imgOutline._width = target_mc._width;
            } // end else if
            if (imgPane.imgOutline._height >= target_mc._height)
            {
                imgPane.imgOutline._height = target_mc._height;
                numLines = 0;
                target_mc._x = target_mc._x + image_scroll._width / 2;
                imgPane.imgOutline._x = imgPane.imgOutline._x + image_scroll._width / 2;
                image_scroll._visible = false;
            }
            else if (target_mc._width <= targ_imgW)
            {
                image_scroll._x = target_mc._x + target_mc._width + imgPane._x;
            }
            else
            {
                image_scroll._x = target_mc._x + imgPane.imgOutline._width + imgPane._x;
            } // end else if
            if (numLines > 0)
            {
                tempLines = numLines + linesFull;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempLines / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + breaks[_loc1];
                        tempLines = tempLines - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scroll.htmlText = text_scroll.htmlText + emptySpace;
                image_scroll._visible = true;
            } // end if
            emptySpace = "";
            if (numSpaces > 0)
            {
                tempSpaces = numSpaces;
                for (var _loc1 = exponents.length - 1; _loc1 >= 0; --_loc1)
                {
                    for (var _loc2 = Math.floor(tempSpaces / exponents[_loc1]); _loc2 > 0; --_loc2)
                    {
                        emptySpace = emptySpace + spaces[_loc1];
                        tempSpaces = tempSpaces - exponents[_loc1];
                    } // end of for
                } // end of for
                text_scrollH.text = text_scrollH.text + emptySpace;
                cornerFill._visible = true;
                image_scrollH._visible = true;
                image_scrollH._x = imgPane._x;
                image_scrollH._y = cornerFill._y;
            } // end if
        };
        var image_mcl = new MovieClipLoader();
        image_mcl.addListener(mclListener);
        targ_imgW = imgPane.image._width;
        targ_imgH = imgPane.image._height;
        image_mcl.loadClip(rootNode.childNodes[quest_order[qCount]].attributes.Media, imgPane.image);
        break;
    } 
} // End of switch
Distractors[0] = letters[0] + rootNode.childNodes[quest_order[qCount]].childNodes[1].childNodes[0].nodeValue;
ansID[0] = rootNode.childNodes[quest_order[qCount]].childNodes[1].attributes.aID;
Distractors[1] = letters[1] + rootNode.childNodes[quest_order[qCount]].childNodes[2].childNodes[0].nodeValue;
ansID[1] = rootNode.childNodes[quest_order[qCount]].childNodes[2].attributes.aID;
if (rootNode.childNodes[quest_order[qCount]].childNodes[1].attributes.Correct == "Yes")
{
    tf_ans = true;
}
else
{
    tf_ans = false;
} // end else if
Q_Component.Correct_Response = tf_ans;
feedback_text = "Sorry, the correct answer is ";
countThis();
_root.QuizMov.play();
stop ();

// [Action in Frame 77]
fade.play();

// [Action in Frame 78]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var exception = false;
var exact = false;
var case_sense = false;
var feedback_code = "";
var space_pos = -1;
saInstuct.setTextFormat(saInst);
assignQtext();
if (rootNode.childNodes[quest_order[qCount]].attributes.Exact != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Exact.toLowerCase() == "true")
    {
        exact = true;
        feedback_code = "1";
    }
    else
    {
        exact = false;
        feedback_code = "0";
    } // end else if
    if (exact)
    {
        var x = 0;
        while (x < num_ans)
        {
            space_pos = rootNode.childNodes[quest_order[qCount]].childNodes[x + 1].childNodes[0].nodeValue.indexOf(" ");
            if (space_pos != -1)
            {
                exact = false;
                feedback_code = "0";
                break;
            } // end if
            ++x;
        } // end while
    } // end if
} // end if
if (rootNode.childNodes[quest_order[qCount]].attributes.Case_Sense != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Case_Sense.toLowerCase() == "true")
    {
        case_sense = true;
        feedback_code = feedback_code + "1";
    }
    else
    {
        case_sense = false;
        feedback_code = feedback_code + "0";
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Except != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Except.toLowerCase() == "true")
    {
        exception = true;
        feedback_code = feedback_code + "1";
    }
    else
    {
        exception = false;
        feedback_code = feedback_code + "0";
    } // end if
} // end else if
switch (feedback_code)
{
    case "000":
    {
        feedback_text = "Sorry, the correct answer should contain ";
        break;
    } 
    case "100":
    {
        feedback_text = "Sorry, the correct answer is ";
        break;
    } 
    case "010":
    {
        feedback_text = "Sorry, the correct answer should contain, exactly ";
        break;
    } 
    case "101":
    case "001":
    {
        feedback_text = "Sorry, the correct answer shouldn\'t contain ";
        break;
    } 
    case "111":
    case "011":
    {
        feedback_text = "Sorry, the correct answer shouldn\'t contain, exactly ";
        break;
    } 
    case "110":
    {
        feedback_text = "Sorry, the correct answer is exactly ";
        break;
    } 
} // End of switch
switch (num_ans)
{
    case 0:
    {
        trace ("No answers entered for Short answer question #" + quest_order[qCount] + ".");
        break;
    } 
    case 1:
    {
        Q_Component.Response1 = rootNode.childNodes[quest_order[qCount]].childNodes[1].childNodes[0].nodeValue;
        Q_Component.Response2 = "";
        Q_Component.Response3 = "";
        break;
    } 
    case 2:
    {
        Q_Component.Response1 = rootNode.childNodes[quest_order[qCount]].childNodes[1].childNodes[0].nodeValue;
        Q_Component.Response2 = rootNode.childNodes[quest_order[qCount]].childNodes[2].childNodes[0].nodeValue;
        Q_Component.Response3 = "";
        break;
    } 
    case 3:
    {
        Q_Component.Response1 = rootNode.childNodes[quest_order[qCount]].childNodes[1].childNodes[0].nodeValue;
        Q_Component.Response2 = rootNode.childNodes[quest_order[qCount]].childNodes[2].childNodes[0].nodeValue;
        Q_Component.Response3 = rootNode.childNodes[quest_order[qCount]].childNodes[3].childNodes[0].nodeValue;
        break;
    } 
    default:
    {
        Q_Component.Response1 = rootNode.childNodes[quest_order[qCount]].childNodes[1].childNodes[0].nodeValue;
        Q_Component.Response2 = rootNode.childNodes[quest_order[qCount]].childNodes[2].childNodes[0].nodeValue;
        Q_Component.Response3 = rootNode.childNodes[quest_order[qCount]].childNodes[3].childNodes[0].nodeValue;
        trace ("Too many answers entered for Short answer question #" + quest_order[qCount] + ".  You can only have 3 possible correct answers.");
    } 
} // End of switch
countThis();
stop ();

// [Action in Frame 79]
var subClass_ind = -1;
var s = 0;
while (s < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    subClass_ind = rootNode.childNodes[quest_order[qCount]].childNodes[s].childNodes[0].nodeValue.indexOf(quizMediaLoc);
    if (subClass_ind != -1)
    {
        subClass = "o_img";
        break;
    }
    else
    {
        subClass = "o_txt";
    } // end else if
    ++s;
} // end while
gotoAndPlay(subClass);

// [Action in Frame 80]
fade.play();

// [Action in Frame 81]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var targ_imgH = 0;
var targ_imgW = 0;
var percH = 0;
var percW = 0;
var answer = 0;
var Hpos = 0;
var Vpos = 0;
var drag_obj = Array();
var targ_obj = Array();
var temp_order = Array();
var label_order = Array();
var label_text = Array();
var wrong_drag = Array();
var out_o_bound = Array();
var empty_slots = Array();
var show_limit1 = true;
var show_limit2 = false;
var show_labels = true;
var user_labels = false;
var total_height = ansArea._height;
var targ_height = 0;
var targ_perc = 0;
var label_width = 0;
var max_label_width = 0;
var padding = 4;
var max_title_lines = 2;
var max_targets = 6;
var alignment = "";
var temp = "";
var autoNumber = false;
var wrong_answer = false;
var perc_limit = 1.250000E+000;
var number_valid = 0;
Vspace = 10;
Hspace = 10;
var mclListener = new Object();
assignQtext();
mclListener.onLoadError = function (target_mc, errorCode)
{
    trace ("ERROR!");
    switch (errorCode)
    {
        case "URLNotFound":
        {
            trace ("\t Unable to connect to URL: " + target_mc._url);
            break;
        } 
        case "LoadNeverCompleted":
        {
            trace ("\t Unable to complete download: " + target_mc);
            break;
        } 
    } // End of switch
};
mclListener.onLoadInit = function (target_mc)
{
    percW = targ_imgW / target_mc._width;
    percH = targ_imgH / target_mc._height;
    if (cropimage)
    {
        if (percW > percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
            outW = target_mc._width / 2;
            outH = targ_imgH / 2;
            alignment = "W";
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
            outW = targ_imgW / 2;
            outH = target_mc._height / 2;
            alignment = "H";
        } // end else if
    }
    else
    {
        alignment = "C";
        if (percW < percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
        } // end else if
        outW = target_mc._width / 2;
        outH = target_mc._height / 2;
    } // end else if
    target_mc._x = target_mc._x + (targ_imgW - target_mc._width) / 2;
    target_mc._y = target_mc._y + (targ_imgH - target_mc._height) / 2;
    target_mc._parent.drawImgOutline(outH, outW);
};
var image_mcl = new MovieClipLoader();
image_mcl.addListener(mclListener);
if (subClass == "o_img")
{
    prefix = "oi";
}
else
{
    prefix = "ot";
    max_targets = 8;
} // end else if
var m = 0;
while (m < ans_order.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].nodeName.toLowerCase() == "answer")
    {
        ++answer;
        ++state_num;
        Distractors[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].childNodes[0].nodeValue;
        targ_pair[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.OrderID;
        drag_pair[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.OrderID;
        drag_obj[answer - 1] = prefix + "_Drag" + answer;
        targ_obj[state_num - 1] = prefix + "_Target" + state_num;
        ansID.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.aID);
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].nodeName.toLowerCase() == "label")
    {
        user_labels = true;
        autoNumber = false;
        label_text.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].childNodes[0].nodeValue);
        if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.OrderID != undefined)
        {
            label_order.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.OrderID);
        } // end if
    }
    else if (!user_labels)
    {
        Statements[state_num - 1] = m + 1 + ".";
        autoNumber = true;
    } // end else if
    ++m;
} // end while
var e = 0;
while (e < drag_pair.length)
{
    if (drag_pair[e] == undefined)
    {
        if (e < num_ans)
        {
            empty_slots.push(e);
        } // end if
    }
    else
    {
        ++number_valid;
        if (e >= num_ans)
        {
            if (empty_slots.length > 0)
            {
                var temp_rand = Math.floor(Math.random() * empty_slots.length);
                temp = drag_pair[e];
                drag_pair[e] = drag_pair[empty_slots[temp_rand]];
                drag_pair[empty_slots[temp_rand]] = temp;
                temp = targ_pair[e];
                targ_pair[e] = targ_pair[empty_slots[temp_rand]];
                targ_pair[empty_slots[temp_rand]] = temp;
                temp = Distractors[e];
                Distractors[e] = Distractors[empty_slots[temp_rand]];
                Distractors[empty_slots[temp_rand]] = temp;
                empty_slots.splice(temp_rand, 1);
            } // end if
        } // end if
    } // end else if
    ++e;
} // end while
if (!autoNumber)
{
    var i = label_order.length - 1;
    while (i >= 0)
    {
        var j = 1;
        while (j <= i)
        {
            if (label_order[j - 1] > label_order[j])
            {
                temp = label_text[j - 1];
                label_text[j - 1] = label_text[j];
                label_text[j] = temp;
                temp = label_order[j - 1];
                label_order[j - 1] = label_order[j];
                label_order[j] = temp;
            } // end if
            ++j;
        } // end while
        --i;
    } // end while
} // end if
if (user_labels)
{
    var ul = 0;
    while (ul < ans_order.length)
    {
        if (label_text[ul] != undefined)
        {
            Statements[ul] = label_text[ul];
        }
        else
        {
            Statements[ul] = "";
        } // end else if
        ++ul;
    } // end while
}
else
{
    var al = 0;
    while (al < ans_order.length)
    {
        Statements[al] = al + 1 + ".";
        ++al;
    } // end while
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Targ != undefined)
{
    if (!isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Targ)))
    {
        state_num = rootNode.childNodes[quest_order[qCount]].attributes.Targ;
        if (state_num > max_targets)
        {
            state_num = max_targets;
        } // end if
        var r = 0;
        while (r < targ_pair.length)
        {
            if (targ_pair[r] == undefined)
            {
                targ_pair.splice(r, 1);
                wrong_drag.push(drag_obj[r]);
                drag_obj.splice(r, 1);
                drag_pair.splice(r, 1);
                targ_obj.splice(targ_pair.length);
                wrong_answer = true;
                --r;
            } // end if
            ++r;
        } // end while
        if (wrong_answer)
        {
            if (targ_pair.length > state_num)
            {
                targ_pair.splice(state_num);
                targ_obj.splice(state_num);
            } // end if
        }
        else
        {
            targ_pair.splice(state_num);
            targ_obj.splice(state_num);
        } // end if
    } // end else if
}
else
{
    if (num_ans <= max_targets)
    {
        if (label_text.length > 0)
        {
            state_num = label_text.length;
        }
        else if (number_valid < num_ans)
        {
            state_num = number_valid;
        }
        else
        {
            state_num = num_ans;
        } // end else if
    }
    else
    {
        state_num = max_targets;
    } // end else if
    var r = 0;
    while (r < targ_pair.length)
    {
        if (targ_pair[r] == undefined)
        {
            targ_pair.splice(r, 1);
            targ_obj.splice(targ_pair.length);
            wrong_drag.push(drag_obj[r]);
            drag_obj.splice(r, 1);
            drag_pair.splice(r, 1);
            wrong_answer = true;
            --r;
        } // end if
        ++r;
    } // end while
    if (wrong_answer)
    {
        if (targ_pair.length > state_num)
        {
            targ_pair.splice(state_num);
            targ_obj.splice(state_num);
        } // end if
    }
    else
    {
        targ_pair.splice(state_num);
        targ_obj.splice(state_num);
    } // end else if
} // end else if
if (wrong_drag.length > 0)
{
    var p = 0;
    while (p < wrong_drag.length)
    {
        drag_obj.push(wrong_drag[p]);
        drag_pair.push(undefined);
        ++p;
    } // end while
} // end if
drag_obj.splice(num_ans);
drag_pair.splice(num_ans);
if (rootNode.childNodes[quest_order[qCount]].attributes.Limit1 != undefined)
{
    limit1.text = rootNode.childNodes[quest_order[qCount]].attributes.Limit1;
    limit1.setTextFormat(ansTxt);
    if (subClass == "o_img")
    {
        limit1.autoSize = true;
    } // end if
    total_height = total_height - (limit1._height + Vspace * 2);
    Vpos = Vpos + (limit1._height + Vspace * 2);
}
else
{
    limit1._visible = false;
    show_limit1 = false;
    total_height = total_height - Vspace;
    Vpos = Vpos + Vspace;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Limit2 != undefined)
{
    limit2.text = rootNode.childNodes[quest_order[qCount]].attributes.Limit2;
    limit2.setTextFormat(ansTxt);
    if (subClass == "o_img")
    {
        limit2.autoSize = true;
    } // end if
    limit2._y = ansArea._y + ansArea._height - (limit2._height + Vspace);
    total_height = total_height - (limit2._height + Vspace * 2);
}
else
{
    limit2._visible = false;
    show_limit2 = false;
    total_height = total_height - Vspace;
} // end else if
var d = 0;
while (d < num_ans)
{
    if (subClass == "o_img")
    {
        targ_imgW = this[prefix + "_Drag" + (d + 1)].placeHold._width;
        targ_imgH = this[prefix + "_Drag" + (d + 1)].placeHold._height;
        image_mcl.loadClip(Distractors[d], this[prefix + "_Drag" + (d + 1)].placeHold.image);
        image_mcl.loadClip(Distractors[d], this[prefix + "_Back" + (d + 1)].placeHold.image);
        this[prefix + "_Back" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Drag" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Back" + (d + 1)].letter.setTextFormat(ddIbackL);
        this[prefix + "_Drag" + (d + 1)].letter.setTextFormat(ddIansL);
        this[prefix + "_Drag" + (d + 1)].letter._visible = false;
        if (!cropimage)
        {
            this[prefix + "_Back" + (d + 1)].letter._visible = false;
        } // end if
    }
    else
    {
        this[prefix + "_Drag" + (d + 1)].dragTxt.text = letters[d] + Distractors[d];
        this[prefix + "_Drag" + (d + 1)].dragTxt.setTextFormat(ddTxtAns);
    } // end else if
    ++d;
} // end while
if (!autoNumber)
{
    var i = targ_pair.length - 1;
    while (i >= 0)
    {
        var j = 1;
        while (j <= i)
        {
            if (targ_pair[j - 1] > targ_pair[j])
            {
                temp = targ_pair[j - 1];
                targ_pair[j - 1] = targ_pair[j];
                targ_pair[j] = temp;
                temp = drag_obj[j - 1];
                drag_obj[j - 1] = drag_obj[j];
                drag_obj[j] = temp;
                temp = drag_pair[j - 1];
                drag_pair[j - 1] = drag_pair[j];
                drag_pair[j] = temp;
                temp = Distractors[j - 1];
                Distractors[j - 1] = Distractors[j];
                Distractors[j] = temp;
            } // end if
            ++j;
        } // end while
        --i;
    } // end while
} // end if
drag_obj.push(undefined);
targ_obj.push(undefined);
var c = 0;
while (c < state_num)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Labels.toLowerCase() == "false")
    {
        this["order" + (c + 1)]._visible = false;
        show_labels = false;
    }
    else
    {
        this["order" + (c + 1)].text = Statements[c];
        this["order" + (c + 1)].setTextFormat(ansTxt);
    } // end else if
    ++c;
} // end while
var x = Number(num_ans) + 1;
while (x <= max_ans)
{
    if (subClass == "o_img")
    {
        this[prefix + "_Drag" + x]._visible = false;
        this[prefix + "_Back" + x]._visible = false;
    }
    else
    {
        this[prefix + "_Drag" + x]._visible = false;
    } // end else if
    ++x;
} // end while
if (subClass == "o_img")
{
    Vpos = Vpos + ansArea._y;
    Hpos = Hpos + ansArea._x;
    targ_height = (total_height - Vspace * (state_num - 1)) / state_num;
    targ_perc = targ_height / this[prefix + "_Target1"]._height;
    if (targ_perc > perc_limit)
    {
        targ_perc = perc_limit;
        targ_height = perc_limit * this[prefix + "_Target1"]._height;
    } // end if
    var ts = 0;
    while (ts < state_num)
    {
        this[prefix + "_Target" + (ts + 1)]._height = this[prefix + "_Target" + (ts + 1)]._height * targ_perc;
        this[prefix + "_Target" + (ts + 1)]._width = this[prefix + "_Target" + (ts + 1)]._width * targ_perc;
        this[prefix + "_Target" + (ts + 1)]._y = Vpos + targ_height / 2;
        Vpos = Vpos + (targ_height + Vspace);
        ++ts;
    } // end while
    max_label_width = Math.round(ansArea._width / 2 - (this[prefix + "_Target1"]._width + Hspace * 3));
    var lw = 0;
    while (lw < state_num)
    {
        if (this["order" + (lw + 1)].textWidth > max_label_width)
        {
            this["order" + (lw + 1)]._width = max_label_width;
            label_width = max_label_width;
            this["order" + (lw + 1)].autoSize = "left";
            this["order" + (lw + 1)].wordWrap = true;
        }
        else
        {
            this["order" + (lw + 1)]._width = this["order" + (lw + 1)].textWidth + padding;
            if (this["order" + (lw + 1)]._width > label_width)
            {
                label_width = this["order" + (lw + 1)]._width;
            } // end if
        } // end else if
        ++lw;
    } // end while
    var pt = 0;
    while (pt < state_num)
    {
        if (show_labels)
        {
            this[prefix + "_Target" + (pt + 1)]._x = Hpos + (ansArea._width / 2 - (this[prefix + "_Target" + (pt + 1)]._width + label_width + Hspace)) / 2 + label_width + Hspace + this[prefix + "_Target" + (pt + 1)]._width / 2;
            this["order" + (pt + 1)]._x = this[prefix + "_Target" + (pt + 1)]._x - (this[prefix + "_Target" + (pt + 1)]._width / 2 + Hspace + this["order" + (pt + 1)]._width);
            this["order" + (pt + 1)]._y = this[prefix + "_Target" + (pt + 1)]._y + -this["order" + (pt + 1)]._height / 2;
        }
        else
        {
            this[prefix + "_Target" + (pt + 1)]._x = Hpos + (ansArea._width / 2 - this[prefix + "_Target" + (pt + 1)]._width) / 2 + this[prefix + "_Target" + (pt + 1)]._width / 2;
        } // end else if
        ++pt;
    } // end while
}
else
{
    var u = 0;
    while (u < state_num)
    {
        if (this["order" + (u + 1)].maxscroll <= max_title_lines)
        {
            this["order" + (u + 1)]._height = this["order" + (u + 1)]._height * this["order" + (u + 1)].maxscroll;
            this["order" + (u + 1)]._y = this[prefix + "_Target" + (u + 1)]._y + -this["order" + (u + 1)]._height / 2;
        }
        else
        {
            this["order" + (u + 1)]._height = this["order" + (u + 1)]._height * max_title_lines;
            this["order" + (u + 1)]._y = this[prefix + "_Target" + (u + 1)]._y + -this["order" + (u + 1)]._height / 2;
        } // end else if
        ++u;
    } // end while
} // end else if
var x = Number(state_num) + 1;
while (x <= max_ans)
{
    this["order" + x]._visible = false;
    if (subClass == "o_img")
    {
        this[prefix + "_Target" + x]._visible = false;
    }
    else
    {
        if (x == Number(state_num) + 1)
        {
            limit2._y = this[prefix + "_Target" + x]._y - this[prefix + "_Target" + x]._height / 2;
        } // end if
        this[prefix + "_Target" + x]._visible = false;
    } // end else if
    ++x;
} // end while
feedback_text = "Sorry, the correct order is ";
countThis();

// [Action in Frame 82]
stop ();

// [Action in Frame 83]
fade.play();

// [Action in Frame 84]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var targ_imgH = 0;
var targ_imgW = 0;
var percH = 0;
var percW = 0;
var answer = 0;
var Hpos = 0;
var Vpos = 0;
var drag_obj = Array();
var targ_obj = Array();
var temp_order = Array();
var label_order = Array();
var label_text = Array();
var wrong_drag = Array();
var out_o_bound = Array();
var empty_slots = Array();
var show_limit1 = true;
var show_limit2 = false;
var show_labels = true;
var user_labels = false;
var total_height = ansArea._height;
var targ_height = 0;
var targ_perc = 0;
var label_width = 0;
var max_label_width = 0;
var padding = 4;
var max_title_lines = 2;
var max_targets = 6;
var alignment = "";
var temp = "";
var autoNumber = false;
var wrong_answer = false;
var perc_limit = 1.250000E+000;
var number_valid = 0;
Vspace = 10;
Hspace = 10;
var mclListener = new Object();
assignQtext();
mclListener.onLoadError = function (target_mc, errorCode)
{
    trace ("ERROR!");
    switch (errorCode)
    {
        case "URLNotFound":
        {
            trace ("\t Unable to connect to URL: " + target_mc._url);
            break;
        } 
        case "LoadNeverCompleted":
        {
            trace ("\t Unable to complete download: " + target_mc);
            break;
        } 
    } // End of switch
};
mclListener.onLoadInit = function (target_mc)
{
    percW = targ_imgW / target_mc._width;
    percH = targ_imgH / target_mc._height;
    if (cropimage)
    {
        if (percW > percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
            outW = target_mc._width / 2;
            outH = targ_imgH / 2;
            alignment = "W";
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
            outW = targ_imgW / 2;
            outH = target_mc._height / 2;
            alignment = "H";
        } // end else if
    }
    else
    {
        alignment = "C";
        if (percW < percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
        } // end else if
        outW = target_mc._width / 2;
        outH = target_mc._height / 2;
    } // end else if
    target_mc._x = target_mc._x + (targ_imgW - target_mc._width) / 2;
    target_mc._y = target_mc._y + (targ_imgH - target_mc._height) / 2;
    target_mc._parent.drawImgOutline(outH, outW);
};
var image_mcl = new MovieClipLoader();
image_mcl.addListener(mclListener);
if (subClass == "o_img")
{
    prefix = "oi";
}
else
{
    prefix = "ot";
    max_targets = 8;
} // end else if
var m = 0;
while (m < ans_order.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].nodeName.toLowerCase() == "answer")
    {
        ++answer;
        ++state_num;
        Distractors[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].childNodes[0].nodeValue;
        targ_pair[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.OrderID;
        drag_pair[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.OrderID;
        drag_obj[answer - 1] = prefix + "_Drag" + answer;
        targ_obj[state_num - 1] = prefix + "_Target" + state_num;
        ansID.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.aID);
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].nodeName.toLowerCase() == "label")
    {
        user_labels = true;
        autoNumber = false;
        label_text.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].childNodes[0].nodeValue);
        if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.OrderID != undefined)
        {
            label_order.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.OrderID);
        } // end if
    }
    else if (!user_labels)
    {
        Statements[state_num - 1] = m + 1 + ".";
        autoNumber = true;
    } // end else if
    ++m;
} // end while
var e = 0;
while (e < drag_pair.length)
{
    if (drag_pair[e] == undefined)
    {
        if (e < num_ans)
        {
            empty_slots.push(e);
        } // end if
    }
    else
    {
        ++number_valid;
        if (e >= num_ans)
        {
            if (empty_slots.length > 0)
            {
                var temp_rand = Math.floor(Math.random() * empty_slots.length);
                temp = drag_pair[e];
                drag_pair[e] = drag_pair[empty_slots[temp_rand]];
                drag_pair[empty_slots[temp_rand]] = temp;
                temp = targ_pair[e];
                targ_pair[e] = targ_pair[empty_slots[temp_rand]];
                targ_pair[empty_slots[temp_rand]] = temp;
                temp = Distractors[e];
                Distractors[e] = Distractors[empty_slots[temp_rand]];
                Distractors[empty_slots[temp_rand]] = temp;
                empty_slots.splice(temp_rand, 1);
            } // end if
        } // end if
    } // end else if
    ++e;
} // end while
if (!autoNumber)
{
    var i = label_order.length - 1;
    while (i >= 0)
    {
        var j = 1;
        while (j <= i)
        {
            if (label_order[j - 1] > label_order[j])
            {
                temp = label_text[j - 1];
                label_text[j - 1] = label_text[j];
                label_text[j] = temp;
                temp = label_order[j - 1];
                label_order[j - 1] = label_order[j];
                label_order[j] = temp;
            } // end if
            ++j;
        } // end while
        --i;
    } // end while
} // end if
if (user_labels)
{
    var ul = 0;
    while (ul < ans_order.length)
    {
        if (label_text[ul] != undefined)
        {
            Statements[ul] = label_text[ul];
        }
        else
        {
            Statements[ul] = "";
        } // end else if
        ++ul;
    } // end while
}
else
{
    var al = 0;
    while (al < ans_order.length)
    {
        Statements[al] = al + 1 + ".";
        ++al;
    } // end while
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Targ != undefined)
{
    if (!isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Targ)))
    {
        state_num = rootNode.childNodes[quest_order[qCount]].attributes.Targ;
        if (state_num > max_targets)
        {
            state_num = max_targets;
        } // end if
        var r = 0;
        while (r < targ_pair.length)
        {
            if (targ_pair[r] == undefined)
            {
                targ_pair.splice(r, 1);
                wrong_drag.push(drag_obj[r]);
                drag_obj.splice(r, 1);
                drag_pair.splice(r, 1);
                targ_obj.splice(targ_pair.length);
                wrong_answer = true;
                --r;
            } // end if
            ++r;
        } // end while
        if (wrong_answer)
        {
            if (targ_pair.length > state_num)
            {
                targ_pair.splice(state_num);
                targ_obj.splice(state_num);
            } // end if
        }
        else
        {
            targ_pair.splice(state_num);
            targ_obj.splice(state_num);
        } // end if
    } // end else if
}
else
{
    if (num_ans <= max_targets)
    {
        if (label_text.length > 0)
        {
            state_num = label_text.length;
        }
        else if (number_valid < num_ans)
        {
            state_num = number_valid;
        }
        else
        {
            state_num = num_ans;
        } // end else if
    }
    else
    {
        state_num = max_targets;
    } // end else if
    var r = 0;
    while (r < targ_pair.length)
    {
        if (targ_pair[r] == undefined)
        {
            targ_pair.splice(r, 1);
            targ_obj.splice(targ_pair.length);
            wrong_drag.push(drag_obj[r]);
            drag_obj.splice(r, 1);
            drag_pair.splice(r, 1);
            wrong_answer = true;
            --r;
        } // end if
        ++r;
    } // end while
    if (wrong_answer)
    {
        if (targ_pair.length > state_num)
        {
            targ_pair.splice(state_num);
            targ_obj.splice(state_num);
        } // end if
    }
    else
    {
        targ_pair.splice(state_num);
        targ_obj.splice(state_num);
    } // end else if
} // end else if
if (wrong_drag.length > 0)
{
    var p = 0;
    while (p < wrong_drag.length)
    {
        drag_obj.push(wrong_drag[p]);
        drag_pair.push(undefined);
        ++p;
    } // end while
} // end if
drag_obj.splice(num_ans);
drag_pair.splice(num_ans);
if (rootNode.childNodes[quest_order[qCount]].attributes.Limit1 != undefined)
{
    limit1.text = rootNode.childNodes[quest_order[qCount]].attributes.Limit1;
    limit1.setTextFormat(ansTxt);
    if (subClass == "o_img")
    {
        limit1.autoSize = true;
    } // end if
    total_height = total_height - (limit1._height + Vspace * 2);
    Vpos = Vpos + (limit1._height + Vspace * 2);
}
else
{
    limit1._visible = false;
    show_limit1 = false;
    total_height = total_height - Vspace;
    Vpos = Vpos + Vspace;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Limit2 != undefined)
{
    limit2.text = rootNode.childNodes[quest_order[qCount]].attributes.Limit2;
    limit2.setTextFormat(ansTxt);
    if (subClass == "o_img")
    {
        limit2.autoSize = true;
    } // end if
    limit2._y = ansArea._y + ansArea._height - (limit2._height + Vspace);
    total_height = total_height - (limit2._height + Vspace * 2);
}
else
{
    limit2._visible = false;
    show_limit2 = false;
    total_height = total_height - Vspace;
} // end else if
var d = 0;
while (d < num_ans)
{
    if (subClass == "o_img")
    {
        targ_imgW = this[prefix + "_Drag" + (d + 1)].placeHold._width;
        targ_imgH = this[prefix + "_Drag" + (d + 1)].placeHold._height;
        image_mcl.loadClip(Distractors[d], this[prefix + "_Drag" + (d + 1)].placeHold.image);
        image_mcl.loadClip(Distractors[d], this[prefix + "_Back" + (d + 1)].placeHold.image);
        this[prefix + "_Back" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Drag" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Back" + (d + 1)].letter.setTextFormat(ddIbackL);
        this[prefix + "_Drag" + (d + 1)].letter.setTextFormat(ddIansL);
        this[prefix + "_Drag" + (d + 1)].letter._visible = false;
        if (!cropimage)
        {
            this[prefix + "_Back" + (d + 1)].letter._visible = false;
        } // end if
    }
    else
    {
        this[prefix + "_Drag" + (d + 1)].dragTxt.text = letters[d] + Distractors[d];
        this[prefix + "_Drag" + (d + 1)].dragTxt.setTextFormat(ddTxtAns);
    } // end else if
    ++d;
} // end while
if (!autoNumber)
{
    var i = targ_pair.length - 1;
    while (i >= 0)
    {
        var j = 1;
        while (j <= i)
        {
            if (targ_pair[j - 1] > targ_pair[j])
            {
                temp = targ_pair[j - 1];
                targ_pair[j - 1] = targ_pair[j];
                targ_pair[j] = temp;
                temp = drag_obj[j - 1];
                drag_obj[j - 1] = drag_obj[j];
                drag_obj[j] = temp;
                temp = drag_pair[j - 1];
                drag_pair[j - 1] = drag_pair[j];
                drag_pair[j] = temp;
                temp = Distractors[j - 1];
                Distractors[j - 1] = Distractors[j];
                Distractors[j] = temp;
            } // end if
            ++j;
        } // end while
        --i;
    } // end while
} // end if
drag_obj.push(undefined);
targ_obj.push(undefined);
var c = 0;
while (c < state_num)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Labels.toLowerCase() == "false")
    {
        this["order" + (c + 1)]._visible = false;
        show_labels = false;
    }
    else
    {
        this["order" + (c + 1)].text = Statements[c];
        this["order" + (c + 1)].setTextFormat(ansTxt);
    } // end else if
    ++c;
} // end while
var x = Number(num_ans) + 1;
while (x <= max_ans)
{
    if (subClass == "o_img")
    {
        this[prefix + "_Drag" + x]._visible = false;
        this[prefix + "_Back" + x]._visible = false;
    }
    else
    {
        this[prefix + "_Drag" + x]._visible = false;
    } // end else if
    ++x;
} // end while
if (subClass == "o_img")
{
    Vpos = Vpos + ansArea._y;
    Hpos = Hpos + ansArea._x;
    targ_height = (total_height - Vspace * (state_num - 1)) / state_num;
    targ_perc = targ_height / this[prefix + "_Target1"]._height;
    if (targ_perc > perc_limit)
    {
        targ_perc = perc_limit;
        targ_height = perc_limit * this[prefix + "_Target1"]._height;
    } // end if
    var ts = 0;
    while (ts < state_num)
    {
        this[prefix + "_Target" + (ts + 1)]._height = this[prefix + "_Target" + (ts + 1)]._height * targ_perc;
        this[prefix + "_Target" + (ts + 1)]._width = this[prefix + "_Target" + (ts + 1)]._width * targ_perc;
        this[prefix + "_Target" + (ts + 1)]._y = Vpos + targ_height / 2;
        Vpos = Vpos + (targ_height + Vspace);
        ++ts;
    } // end while
    max_label_width = Math.round(ansArea._width / 2 - (this[prefix + "_Target1"]._width + Hspace * 3));
    var lw = 0;
    while (lw < state_num)
    {
        if (this["order" + (lw + 1)].textWidth > max_label_width)
        {
            this["order" + (lw + 1)]._width = max_label_width;
            label_width = max_label_width;
            this["order" + (lw + 1)].autoSize = "left";
            this["order" + (lw + 1)].wordWrap = true;
        }
        else
        {
            this["order" + (lw + 1)]._width = this["order" + (lw + 1)].textWidth + padding;
            if (this["order" + (lw + 1)]._width > label_width)
            {
                label_width = this["order" + (lw + 1)]._width;
            } // end if
        } // end else if
        ++lw;
    } // end while
    var pt = 0;
    while (pt < state_num)
    {
        if (show_labels)
        {
            this[prefix + "_Target" + (pt + 1)]._x = Hpos + (ansArea._width / 2 - (this[prefix + "_Target" + (pt + 1)]._width + label_width + Hspace)) / 2 + label_width + Hspace + this[prefix + "_Target" + (pt + 1)]._width / 2;
            this["order" + (pt + 1)]._x = this[prefix + "_Target" + (pt + 1)]._x - (this[prefix + "_Target" + (pt + 1)]._width / 2 + Hspace + this["order" + (pt + 1)]._width);
            this["order" + (pt + 1)]._y = this[prefix + "_Target" + (pt + 1)]._y + -this["order" + (pt + 1)]._height / 2;
        }
        else
        {
            this[prefix + "_Target" + (pt + 1)]._x = Hpos + (ansArea._width / 2 - this[prefix + "_Target" + (pt + 1)]._width) / 2 + this[prefix + "_Target" + (pt + 1)]._width / 2;
        } // end else if
        ++pt;
    } // end while
}
else
{
    var u = 0;
    while (u < state_num)
    {
        if (this["order" + (u + 1)].maxscroll <= max_title_lines)
        {
            this["order" + (u + 1)]._height = this["order" + (u + 1)]._height * this["order" + (u + 1)].maxscroll;
            this["order" + (u + 1)]._y = this[prefix + "_Target" + (u + 1)]._y + -this["order" + (u + 1)]._height / 2;
        }
        else
        {
            this["order" + (u + 1)]._height = this["order" + (u + 1)]._height * max_title_lines;
            this["order" + (u + 1)]._y = this[prefix + "_Target" + (u + 1)]._y + -this["order" + (u + 1)]._height / 2;
        } // end else if
        ++u;
    } // end while
} // end else if
var x = Number(state_num) + 1;
while (x <= max_ans)
{
    this["order" + x]._visible = false;
    if (subClass == "o_img")
    {
        this[prefix + "_Target" + x]._visible = false;
    }
    else
    {
        if (x == Number(state_num) + 1)
        {
            limit2._y = this[prefix + "_Target" + x]._y - this[prefix + "_Target" + x]._height / 2;
        } // end if
        this[prefix + "_Target" + x]._visible = false;
    } // end else if
    ++x;
} // end while
feedback_text = "Sorry, the correct order is ";
countThis();

// [Action in Frame 85]
stop ();

// [Action in Frame 86]
var subClass_ind = -1;
var s = 0;
while (s < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    subClass_ind = rootNode.childNodes[quest_order[qCount]].childNodes[s].childNodes[0].nodeValue.indexOf(quizMediaLoc);
    if (subClass_ind != -1)
    {
        subClass = "g_img";
        break;
    }
    else
    {
        subClass = "g_txt";
    } // end else if
    ++s;
} // end while
gotoAndPlay(subClass);

// [Action in Frame 87]
fade.play();

// [Action in Frame 88]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var targ_imgH = 0;
var targ_imgW = 0;
var percH = 0;
var percW = 0;
var answer = 0;
var Hpos = 0;
var Vpos = 0;
var group_ID = Array();
var drag_obj = Array();
var targ_obj = Array();
var group1 = Array();
var group2 = Array();
var wrong_ans = Array();
var col_just = "even";
var len_group1 = 0;
var len_group2 = 0;
var titleH = 0;
var max_title_lines = 2;
var tempID = "";
var mclListener = new Object();
gTitle1.setNewTextFormat(ansTxt);
gTitle2.setNewTextFormat(ansTxt);
assignQtext();
if (subClass == "g_img")
{
    prefix = "gi";
}
else
{
    prefix = "gt";
} // end else if
mclListener.onLoadError = function (target_mc, errorCode)
{
    trace ("ERROR!");
    switch (errorCode)
    {
        case "URLNotFound":
        {
            trace ("\t Unable to connect to URL: " + target_mc._url);
            break;
        } 
        case "LoadNeverCompleted":
        {
            trace ("\t Unable to complete download: " + target_mc);
            break;
        } 
    } // End of switch
};
mclListener.onLoadInit = function (target_mc)
{
    var _loc2 = 0;
    var _loc3 = 0;
    percW = targ_imgW / target_mc._width;
    percH = targ_imgH / target_mc._height;
    if (cropimage)
    {
        if (percW > percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
            _loc3 = target_mc._width / 2;
            _loc2 = targ_imgH / 2;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
            _loc3 = targ_imgW / 2;
            _loc2 = target_mc._height / 2;
        } // end else if
    }
    else
    {
        if (percW < percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
        } // end else if
        _loc3 = target_mc._width / 2;
        _loc2 = target_mc._height / 2;
    } // end else if
    target_mc._x = target_mc._x + (targ_imgW - target_mc._width) / 2;
    target_mc._y = target_mc._y + (targ_imgH - target_mc._height) / 2;
    target_mc._parent.drawImgOutline(_loc2, _loc3);
};
var image_mcl = new MovieClipLoader();
image_mcl.addListener(mclListener);
var g = 0;
while (g < ans_order.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].nodeName.toLowerCase() == "answer")
    {
        ++answer;
        Distractors[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].childNodes[0].nodeValue;
        drag_pair[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].attributes.GroupID;
        ansID.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].attributes.aID);
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].nodeName.toLowerCase() == "heading")
    {
        ++state_num;
        group_ID[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].attributes.GroupID;
        Statements[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].childNodes[0].nodeValue;
        ans_order.splice(g, 1);
        --g;
    } // end else if
    ++g;
} // end while
var i = group_ID.length - 1;
while (i >= 0)
{
    var j = 0;
    while (j <= i)
    {
        if (group_ID[j - 1] > group_ID[j])
        {
            temp = group_ID[j - 1];
            group_ID[j - 1] = group_ID[j];
            group_ID[j] = temp;
            temp = Statements[j - 1];
            Statements[j - 1] = Statements[j];
            Statements[j] = temp;
        } // end if
        ++j;
    } // end while
    --i;
} // end while
if (group_ID.length > max_group)
{
    group_ID.splice(max_group);
    Statements.splice(max_group);
} // end if
var s = 0;
while (s < drag_pair.length)
{
    switch (drag_pair[s])
    {
        case group_ID[0]:
        {
            group1.push(ans_order[s]);
            break;
        } 
        case group_ID[1]:
        {
            group2.push(ans_order[s]);
            break;
        } 
        default:
        {
            wrong_ans.push(ans_order[s]);
        } 
    } // End of switch
    ++s;
} // end while
var l = 0;
while (l < max_ans)
{
    targ_obj[l] = prefix + "_Target" + (l + 1);
    ++l;
} // end while
var rdp = 0;
while (rdp < drag_pair.length)
{
    if (drag_pair[rdp] != group_ID[0] && drag_pair[rdp] != group_ID[1])
    {
        drag_pair[rdp] = null;
    } // end if
    ++rdp;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Col != undefined)
{
    col_just = rootNode.childNodes[quest_order[qCount]].attributes.Col.toLowerCase();
} // end if
if (rootNode.childNodes[quest_order[qCount]].attributes.G1 != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.G1)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.G1) < max_ans / 2)
    {
        group1.splice(Number(rootNode.childNodes[quest_order[qCount]].attributes.G1));
    } // end if
} // end if
if (rootNode.childNodes[quest_order[qCount]].attributes.G2 != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.G2)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.G2) < max_ans / 2)
    {
        group2.splice(Number(rootNode.childNodes[quest_order[qCount]].attributes.G2));
    } // end if
} // end if
if (group1.length + group2.length > max_ans)
{
    if (group1.length > group2.length)
    {
        if (group2.length < max_ans / 2)
        {
            group1.splice(group1.length - group2.length - (group1.length + group2.length - max_ans));
        }
        else
        {
            if (group1.length > max_ans / 2)
            {
                group1.splice(max_ans / 2);
            } // end if
            if (group2.length > max_ans / 2)
            {
                group2.splice(max_ans / 2);
            } // end if
        } // end else if
    }
    else if (group1.length == group2.length)
    {
        if (group1.length > max_ans / 2)
        {
            group1.splice(max_ans / 2);
        } // end if
        if (group2.length > max_ans / 2)
        {
            group2.splice(max_ans / 2);
        } // end if
    }
    else if (group1.length < max_ans / 2)
    {
        group2.splice(group2.length - group1.length - (group1.length + group2.length - max_ans));
    }
    else
    {
        if (group1.length > max_ans / 2)
        {
            group1.splice(max_ans / 2);
        } // end if
        if (group2.length > max_ans / 2)
        {
            group2.splice(max_ans / 2);
        } // end else if
    } // end else if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.WrongA != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.WrongA)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.WrongA) < max_ans - (group1.length + group2.length))
    {
        if (Number(rootNode.childNodes[quest_order[qCount]].attributes.WrongA) > wrong_ans.length)
        {
            wrong_ans.splice(Number(rootNode.childNodes[quest_order[qCount]].attributes.WrongA));
        } // end if
    }
    else if (max_ans - (group1.length + group2.length) >= 0)
    {
        wrong_ans.splice(max_ans - (group1.length + group2.length));
    }
    else
    {
        wrong_ans.splice(0);
    } // end else if
}
else if (max_ans - (group1.length + group2.length) >= 0)
{
    wrong_ans.splice(max_ans - (group1.length + group2.length));
}
else
{
    wrong_ans.splice(0);
} // end else if
len_group1 = group1.length;
len_group2 = group2.length;
if (rootNode.childNodes[quest_order[qCount]].attributes.TargG1 != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG1)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG1) < group1.length)
    {
        len_group1 = Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG1);
    } // end if
} // end if
if (rootNode.childNodes[quest_order[qCount]].attributes.TargG2 != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG2)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG2) < group2.length)
    {
        len_group2 = Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG2);
    } // end if
} // end if
if (len_group1 > len_group2)
{
    if (col_just == "odd")
    {
        if (len_group1 < max_ans / 2)
        {
            var r = len_group1;
            while (r < max_ans / 2)
            {
                targ_obj[r] = null;
                ++r;
            } // end while
            var t = len_group2 + max_ans / 2;
            while (t < max_ans)
            {
                targ_obj[t] = null;
                ++t;
            } // end while
        }
        else
        {
            var v = len_group2 + max_ans / 2;
            while (v < max_ans)
            {
                targ_obj[v] = null;
                ++v;
            } // end while
        } // end else if
    }
    else if (len_group1 < max_ans / 2)
    {
        var r = len_group1;
        while (r < max_ans / 2)
        {
            targ_obj[r] = null;
            targ_obj[r + max_ans / 2] = null;
            ++r;
        } // end while
    } // end else if
}
else if (len_group1 < len_group2)
{
    if (col_just == "odd")
    {
        if (len_group2 < max_ans / 2)
        {
            var r = len_group1;
            while (r < max_ans / 2)
            {
                targ_obj[r] = null;
                ++r;
            } // end while
            var t = len_group2 + max_ans / 2;
            while (t < max_ans)
            {
                targ_obj[t] = null;
                ++t;
            } // end while
        }
        else
        {
            var u = len_group1;
            while (u < max_ans / 2)
            {
                targ_obj[u] = null;
                ++u;
            } // end while
        } // end else if
    }
    else if (len_group2 < max_ans / 2)
    {
        var r = len_group2;
        while (r < max_ans / 2)
        {
            targ_obj[r] = null;
            targ_obj[r + max_ans / 2] = null;
            ++r;
        } // end while
    } // end else if
}
else if (len_group2 < max_ans / 2)
{
    var r = len_group2;
    while (r < max_ans / 2)
    {
        targ_obj[r] = null;
        targ_obj[r + max_ans / 2] = null;
        ++r;
    } // end while
} // end else if
var stp = 0;
while (stp < targ_obj.length)
{
    if (targ_obj[stp] != null)
    {
        if (stp < max_ans / 2)
        {
            targ_pair[stp] = group_ID[0];
        }
        else
        {
            targ_pair[stp] = group_ID[1];
        } // end else if
    }
    else
    {
        targ_pair[stp] = null;
    } // end else if
    ++stp;
} // end while
var ao = 0;
while (ao < ans_order.length)
{
    answered = false;
    var g1 = 0;
    while (g1 < group1.length)
    {
        if (ans_order[ao] == group1[g1])
        {
            answered = true;
            break;
        } // end if
        ++g1;
    } // end while
    if (!answered)
    {
        var g2 = 0;
        while (g2 < group2.length)
        {
            if (ans_order[ao] == group2[g2])
            {
                answered = true;
                break;
            } // end if
            ++g2;
        } // end while
    } // end if
    if (!answered)
    {
        var wa = 0;
        while (wa < wrong_ans.length)
        {
            if (ans_order[ao] == wrong_ans[wa])
            {
                answered = true;
                break;
            } // end if
            ++wa;
        } // end while
    } // end if
    if (!answered)
    {
        drag_pair.splice(ao, 1);
        Distractors.splice(ao, 1);
        ansID.splice(ao, 1);
        ans_order.splice(ao, 1);
        --ao;
    } // end if
    ++ao;
} // end while
var f = 0;
while (f < ans_order.length)
{
    drag_obj[f] = prefix + "_Drag" + (f + 1);
    ++f;
} // end while
var c = 0;
while (c < state_num)
{
    titleH = this["gTitle" + (c + 1)].height;
    this["gTitle" + (c + 1)].text = Statements[c];
    if (this["gTitle" + (c + 1)].maxscroll <= max_title_lines)
    {
        this["gTitle" + (c + 1)]._height = this["gTitle" + (c + 1)]._height * this["gTitle" + (c + 1)].maxscroll;
        this["gTitle" + (c + 1)]._y = this["gTitle" + (c + 1)]._y - (this["gTitle" + (c + 1)]._height - titleH);
    }
    else
    {
        this["gTitle" + (c + 1)]._height = this["gTitle" + (c + 1)]._height * max_title_lines;
        this["gTitle" + (c + 1)]._y = this["gTitle" + (c + 1)]._y - (this["gTitle" + (c + 1)]._height - titleH);
    } // end else if
    ++c;
} // end while
var d = 0;
while (d < max_ans)
{
    if (subClass == "g_img")
    {
        targ_imgW = this[prefix + "_Drag" + (d + 1)].placeHold._width;
        targ_imgH = this[prefix + "_Drag" + (d + 1)].placeHold._height;
        image_mcl.loadClip(Distractors[d], this[prefix + "_Drag" + (d + 1)].placeHold.image);
        image_mcl.loadClip(Distractors[d], this[prefix + "_Back" + (d + 1)].placeHold.image);
        this[prefix + "_Back" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Drag" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Back" + (d + 1)].letter.setTextFormat(ddIbackL);
        this[prefix + "_Drag" + (d + 1)].letter.setTextFormat(ddIansL);
        this[prefix + "_Drag" + (d + 1)].letter._visible = false;
        if (!cropimage)
        {
            this[prefix + "_Back" + (d + 1)].letter._visible = false;
        } // end if
    }
    else
    {
        this[prefix + "_Drag" + (d + 1)].dragTxt.text = letters[d] + Distractors[d];
        this[prefix + "_Drag" + (d + 1)].dragTxt.setTextFormat(ddTxtAns);
    } // end else if
    ++d;
} // end while
var x = ans_order.length + 1;
while (x <= max_ans)
{
    if (subClass == "g_img")
    {
        this[prefix + "_Drag" + x]._visible = false;
        this[prefix + "_Back" + x]._visible = false;
    }
    else
    {
        this[prefix + "_Drag" + x]._visible = false;
    } // end else if
    ++x;
} // end while
if (len_group1 + len_group2 != max_ans)
{
    var x = 0;
    while (x <= max_ans)
    {
        if (targ_obj[x] == null)
        {
            this[prefix + "_Target" + (x + 1)]._visible = false;
        } // end if
        ++x;
    } // end while
} // end if
drag_obj.push(undefined);
targ_obj.push(undefined);
feedback_text = "Sorry, the correct groupings are ";
countThis();

// [Action in Frame 89]
stop ();

// [Action in Frame 90]
fade.play();

// [Action in Frame 91]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var targ_imgH = 0;
var targ_imgW = 0;
var percH = 0;
var percW = 0;
var answer = 0;
var Hpos = 0;
var Vpos = 0;
var group_ID = Array();
var drag_obj = Array();
var targ_obj = Array();
var group1 = Array();
var group2 = Array();
var wrong_ans = Array();
var col_just = "even";
var len_group1 = 0;
var len_group2 = 0;
var titleH = 0;
var max_title_lines = 2;
var tempID = "";
var mclListener = new Object();
gTitle1.setNewTextFormat(ansTxt);
gTitle2.setNewTextFormat(ansTxt);
assignQtext();
if (subClass == "g_img")
{
    prefix = "gi";
}
else
{
    prefix = "gt";
} // end else if
mclListener.onLoadError = function (target_mc, errorCode)
{
    trace ("ERROR!");
    switch (errorCode)
    {
        case "URLNotFound":
        {
            trace ("\t Unable to connect to URL: " + target_mc._url);
            break;
        } 
        case "LoadNeverCompleted":
        {
            trace ("\t Unable to complete download: " + target_mc);
            break;
        } 
    } // End of switch
};
mclListener.onLoadInit = function (target_mc)
{
    var _loc2 = 0;
    var _loc3 = 0;
    percW = targ_imgW / target_mc._width;
    percH = targ_imgH / target_mc._height;
    if (cropimage)
    {
        if (percW > percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
            _loc3 = target_mc._width / 2;
            _loc2 = targ_imgH / 2;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
            _loc3 = targ_imgW / 2;
            _loc2 = target_mc._height / 2;
        } // end else if
    }
    else
    {
        if (percW < percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
        } // end else if
        _loc3 = target_mc._width / 2;
        _loc2 = target_mc._height / 2;
    } // end else if
    target_mc._x = target_mc._x + (targ_imgW - target_mc._width) / 2;
    target_mc._y = target_mc._y + (targ_imgH - target_mc._height) / 2;
    target_mc._parent.drawImgOutline(_loc2, _loc3);
};
var image_mcl = new MovieClipLoader();
image_mcl.addListener(mclListener);
var g = 0;
while (g < ans_order.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].nodeName.toLowerCase() == "answer")
    {
        ++answer;
        Distractors[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].childNodes[0].nodeValue;
        drag_pair[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].attributes.GroupID;
        ansID.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].attributes.aID);
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].nodeName.toLowerCase() == "heading")
    {
        ++state_num;
        group_ID[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].attributes.GroupID;
        Statements[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[g] + 1].childNodes[0].nodeValue;
        ans_order.splice(g, 1);
        --g;
    } // end else if
    ++g;
} // end while
var i = group_ID.length - 1;
while (i >= 0)
{
    var j = 0;
    while (j <= i)
    {
        if (group_ID[j - 1] > group_ID[j])
        {
            temp = group_ID[j - 1];
            group_ID[j - 1] = group_ID[j];
            group_ID[j] = temp;
            temp = Statements[j - 1];
            Statements[j - 1] = Statements[j];
            Statements[j] = temp;
        } // end if
        ++j;
    } // end while
    --i;
} // end while
if (group_ID.length > max_group)
{
    group_ID.splice(max_group);
    Statements.splice(max_group);
} // end if
var s = 0;
while (s < drag_pair.length)
{
    switch (drag_pair[s])
    {
        case group_ID[0]:
        {
            group1.push(ans_order[s]);
            break;
        } 
        case group_ID[1]:
        {
            group2.push(ans_order[s]);
            break;
        } 
        default:
        {
            wrong_ans.push(ans_order[s]);
        } 
    } // End of switch
    ++s;
} // end while
var l = 0;
while (l < max_ans)
{
    targ_obj[l] = prefix + "_Target" + (l + 1);
    ++l;
} // end while
var rdp = 0;
while (rdp < drag_pair.length)
{
    if (drag_pair[rdp] != group_ID[0] && drag_pair[rdp] != group_ID[1])
    {
        drag_pair[rdp] = null;
    } // end if
    ++rdp;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Col != undefined)
{
    col_just = rootNode.childNodes[quest_order[qCount]].attributes.Col.toLowerCase();
} // end if
if (rootNode.childNodes[quest_order[qCount]].attributes.G1 != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.G1)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.G1) < max_ans / 2)
    {
        group1.splice(Number(rootNode.childNodes[quest_order[qCount]].attributes.G1));
    } // end if
} // end if
if (rootNode.childNodes[quest_order[qCount]].attributes.G2 != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.G2)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.G2) < max_ans / 2)
    {
        group2.splice(Number(rootNode.childNodes[quest_order[qCount]].attributes.G2));
    } // end if
} // end if
if (group1.length + group2.length > max_ans)
{
    if (group1.length > group2.length)
    {
        if (group2.length < max_ans / 2)
        {
            group1.splice(group1.length - group2.length - (group1.length + group2.length - max_ans));
        }
        else
        {
            if (group1.length > max_ans / 2)
            {
                group1.splice(max_ans / 2);
            } // end if
            if (group2.length > max_ans / 2)
            {
                group2.splice(max_ans / 2);
            } // end if
        } // end else if
    }
    else if (group1.length == group2.length)
    {
        if (group1.length > max_ans / 2)
        {
            group1.splice(max_ans / 2);
        } // end if
        if (group2.length > max_ans / 2)
        {
            group2.splice(max_ans / 2);
        } // end if
    }
    else if (group1.length < max_ans / 2)
    {
        group2.splice(group2.length - group1.length - (group1.length + group2.length - max_ans));
    }
    else
    {
        if (group1.length > max_ans / 2)
        {
            group1.splice(max_ans / 2);
        } // end if
        if (group2.length > max_ans / 2)
        {
            group2.splice(max_ans / 2);
        } // end else if
    } // end else if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.WrongA != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.WrongA)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.WrongA) < max_ans - (group1.length + group2.length))
    {
        if (Number(rootNode.childNodes[quest_order[qCount]].attributes.WrongA) > wrong_ans.length)
        {
            wrong_ans.splice(Number(rootNode.childNodes[quest_order[qCount]].attributes.WrongA));
        } // end if
    }
    else if (max_ans - (group1.length + group2.length) >= 0)
    {
        wrong_ans.splice(max_ans - (group1.length + group2.length));
    }
    else
    {
        wrong_ans.splice(0);
    } // end else if
}
else if (max_ans - (group1.length + group2.length) >= 0)
{
    wrong_ans.splice(max_ans - (group1.length + group2.length));
}
else
{
    wrong_ans.splice(0);
} // end else if
len_group1 = group1.length;
len_group2 = group2.length;
if (rootNode.childNodes[quest_order[qCount]].attributes.TargG1 != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG1)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG1) < group1.length)
    {
        len_group1 = Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG1);
    } // end if
} // end if
if (rootNode.childNodes[quest_order[qCount]].attributes.TargG2 != undefined && !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG2)))
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG2) < group2.length)
    {
        len_group2 = Number(rootNode.childNodes[quest_order[qCount]].attributes.TargG2);
    } // end if
} // end if
if (len_group1 > len_group2)
{
    if (col_just == "odd")
    {
        if (len_group1 < max_ans / 2)
        {
            var r = len_group1;
            while (r < max_ans / 2)
            {
                targ_obj[r] = null;
                ++r;
            } // end while
            var t = len_group2 + max_ans / 2;
            while (t < max_ans)
            {
                targ_obj[t] = null;
                ++t;
            } // end while
        }
        else
        {
            var v = len_group2 + max_ans / 2;
            while (v < max_ans)
            {
                targ_obj[v] = null;
                ++v;
            } // end while
        } // end else if
    }
    else if (len_group1 < max_ans / 2)
    {
        var r = len_group1;
        while (r < max_ans / 2)
        {
            targ_obj[r] = null;
            targ_obj[r + max_ans / 2] = null;
            ++r;
        } // end while
    } // end else if
}
else if (len_group1 < len_group2)
{
    if (col_just == "odd")
    {
        if (len_group2 < max_ans / 2)
        {
            var r = len_group1;
            while (r < max_ans / 2)
            {
                targ_obj[r] = null;
                ++r;
            } // end while
            var t = len_group2 + max_ans / 2;
            while (t < max_ans)
            {
                targ_obj[t] = null;
                ++t;
            } // end while
        }
        else
        {
            var u = len_group1;
            while (u < max_ans / 2)
            {
                targ_obj[u] = null;
                ++u;
            } // end while
        } // end else if
    }
    else if (len_group2 < max_ans / 2)
    {
        var r = len_group2;
        while (r < max_ans / 2)
        {
            targ_obj[r] = null;
            targ_obj[r + max_ans / 2] = null;
            ++r;
        } // end while
    } // end else if
}
else if (len_group2 < max_ans / 2)
{
    var r = len_group2;
    while (r < max_ans / 2)
    {
        targ_obj[r] = null;
        targ_obj[r + max_ans / 2] = null;
        ++r;
    } // end while
} // end else if
var stp = 0;
while (stp < targ_obj.length)
{
    if (targ_obj[stp] != null)
    {
        if (stp < max_ans / 2)
        {
            targ_pair[stp] = group_ID[0];
        }
        else
        {
            targ_pair[stp] = group_ID[1];
        } // end else if
    }
    else
    {
        targ_pair[stp] = null;
    } // end else if
    ++stp;
} // end while
var ao = 0;
while (ao < ans_order.length)
{
    answered = false;
    var g1 = 0;
    while (g1 < group1.length)
    {
        if (ans_order[ao] == group1[g1])
        {
            answered = true;
            break;
        } // end if
        ++g1;
    } // end while
    if (!answered)
    {
        var g2 = 0;
        while (g2 < group2.length)
        {
            if (ans_order[ao] == group2[g2])
            {
                answered = true;
                break;
            } // end if
            ++g2;
        } // end while
    } // end if
    if (!answered)
    {
        var wa = 0;
        while (wa < wrong_ans.length)
        {
            if (ans_order[ao] == wrong_ans[wa])
            {
                answered = true;
                break;
            } // end if
            ++wa;
        } // end while
    } // end if
    if (!answered)
    {
        drag_pair.splice(ao, 1);
        Distractors.splice(ao, 1);
        ansID.splice(ao, 1);
        ans_order.splice(ao, 1);
        --ao;
    } // end if
    ++ao;
} // end while
var f = 0;
while (f < ans_order.length)
{
    drag_obj[f] = prefix + "_Drag" + (f + 1);
    ++f;
} // end while
var c = 0;
while (c < state_num)
{
    titleH = this["gTitle" + (c + 1)].height;
    this["gTitle" + (c + 1)].text = Statements[c];
    if (this["gTitle" + (c + 1)].maxscroll <= max_title_lines)
    {
        this["gTitle" + (c + 1)]._height = this["gTitle" + (c + 1)]._height * this["gTitle" + (c + 1)].maxscroll;
        this["gTitle" + (c + 1)]._y = this["gTitle" + (c + 1)]._y - (this["gTitle" + (c + 1)]._height - titleH);
    }
    else
    {
        this["gTitle" + (c + 1)]._height = this["gTitle" + (c + 1)]._height * max_title_lines;
        this["gTitle" + (c + 1)]._y = this["gTitle" + (c + 1)]._y - (this["gTitle" + (c + 1)]._height - titleH);
    } // end else if
    ++c;
} // end while
var d = 0;
while (d < max_ans)
{
    if (subClass == "g_img")
    {
        targ_imgW = this[prefix + "_Drag" + (d + 1)].placeHold._width;
        targ_imgH = this[prefix + "_Drag" + (d + 1)].placeHold._height;
        image_mcl.loadClip(Distractors[d], this[prefix + "_Drag" + (d + 1)].placeHold.image);
        image_mcl.loadClip(Distractors[d], this[prefix + "_Back" + (d + 1)].placeHold.image);
        this[prefix + "_Back" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Drag" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Back" + (d + 1)].letter.setTextFormat(ddIbackL);
        this[prefix + "_Drag" + (d + 1)].letter.setTextFormat(ddIansL);
        this[prefix + "_Drag" + (d + 1)].letter._visible = false;
        if (!cropimage)
        {
            this[prefix + "_Back" + (d + 1)].letter._visible = false;
        } // end if
    }
    else
    {
        this[prefix + "_Drag" + (d + 1)].dragTxt.text = letters[d] + Distractors[d];
        this[prefix + "_Drag" + (d + 1)].dragTxt.setTextFormat(ddTxtAns);
    } // end else if
    ++d;
} // end while
var x = ans_order.length + 1;
while (x <= max_ans)
{
    if (subClass == "g_img")
    {
        this[prefix + "_Drag" + x]._visible = false;
        this[prefix + "_Back" + x]._visible = false;
    }
    else
    {
        this[prefix + "_Drag" + x]._visible = false;
    } // end else if
    ++x;
} // end while
if (len_group1 + len_group2 != max_ans)
{
    var x = 0;
    while (x <= max_ans)
    {
        if (targ_obj[x] == null)
        {
            this[prefix + "_Target" + (x + 1)]._visible = false;
        } // end if
        ++x;
    } // end while
} // end if
drag_obj.push(undefined);
targ_obj.push(undefined);
feedback_text = "Sorry, the correct groupings are ";
countThis();

// [Action in Frame 92]
stop ();

// [Action in Frame 93]
var subClass_ind = -1;
var s = 0;
while (s < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    subClass_ind = rootNode.childNodes[quest_order[qCount]].childNodes[s].childNodes[0].nodeValue.indexOf(quizMediaLoc);
    if (subClass_ind != -1)
    {
        subClass = "m_img";
        break;
    }
    else
    {
        subClass = "m_txt";
    } // end else if
    ++s;
} // end while
gotoAndPlay(subClass);

// [Action in Frame 94]
fade.play();

// [Action in Frame 95]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var answered = false;
var targ_imgH = 0;
var targ_imgW = 0;
var percH = 0;
var percW = 0;
var answer = 0;
var Hpos = 0;
var Vpos = 0;
var drag_obj = Array();
var targ_obj = Array();
var open_targ_pos = Array();
var open_drag_pos = Array();
var corr_targ_pos = Array();
var corr_drag_pos = Array();
var targ_key = Array();
var drag_key = Array();
var corr_key = Array();
var right_txt = "";
var wrong_txt = "";
var temp_ans = 0;
var corr_outObound = Array();
var outObound_count = 0;
var corr_ans = 0;
var mclListener = new Object();
assignQtext();
mclListener.onLoadError = function (target_mc, errorCode)
{
    trace ("ERROR!");
    switch (errorCode)
    {
        case "URLNotFound":
        {
            trace ("\t Unable to connect to URL: " + target_mc._url);
            break;
        } 
        case "LoadNeverCompleted":
        {
            trace ("\t Unable to complete download: " + target_mc);
            break;
        } 
    } // End of switch
};
mclListener.onLoadInit = function (target_mc)
{
    percW = targ_imgW / target_mc._width;
    percH = targ_imgH / target_mc._height;
    if (cropimage)
    {
        if (percW > percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
            outW = target_mc._width / 2;
            outH = targ_imgH / 2;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
            outW = targ_imgW / 2;
            outH = target_mc._height / 2;
        } // end else if
    }
    else
    {
        if (percW < percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
        } // end else if
        outW = target_mc._width / 2;
        outH = target_mc._height / 2;
    } // end else if
    target_mc._x = target_mc._x + (targ_imgW - target_mc._width) / 2;
    target_mc._y = target_mc._y + (targ_imgH - target_mc._height) / 2;
    target_mc._parent.drawImgOutline(outH, outW);
};
var image_mcl = new MovieClipLoader();
image_mcl.addListener(mclListener);
if (subClass == "m_img")
{
    prefix = "mi";
}
else
{
    prefix = "mt";
} // end else if
var m = 0;
while (m < ans_order.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].nodeName.toLowerCase() == "answer")
    {
        ++answer;
        Distractors[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].childNodes[0].nodeValue;
        if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.PairID == undefined)
        {
            drag_pair[answer - 1] = null;
        }
        else
        {
            drag_pair[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.PairID;
        } // end else if
        ansID.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.aID);
    }
    else
    {
        ++state_num;
        if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.PairID == undefined)
        {
            targ_pair[state_num - 1] = null;
        }
        else
        {
            targ_pair[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.PairID;
        } // end else if
        Statements[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].childNodes[0].nodeValue;
        stateID.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.sID);
    } // end else if
    ++m;
} // end while
if (drag_pair.length >= targ_pair.length)
{
    limit = drag_pair.length;
}
else
{
    limit = targ_pair.length;
} // end else if
answer = 1;
if (rootNode.childNodes[quest_order[qCount]].attributes.Targ != undefined)
{
    state_num = rootNode.childNodes[quest_order[qCount]].attributes.Targ;
}
else
{
    state_num = targ_pair.length;
} // end else if
if (state_num > num_ans)
{
    var q = 0;
    while (q < drag_pair.length)
    {
        answered = false;
        var r = 0;
        while (r < targ_pair.length)
        {
            if (drag_pair[q] != null || targ_pair[r] != null || (drag_pair[q] != undefined || targ_pair[r] != undefined))
            {
                if (drag_pair[q] == targ_pair[r])
                {
                    corr_drag_pos.push(q);
                    if (q > num_ans - 1)
                    {
                        corr_outObound.push(q);
                    } // end if
                    answered = true;
                    break;
                } // end if
            } // end if
            ++r;
        } // end while
        if (!answered)
        {
            if (q < num_ans)
            {
                open_drag_pos.push(q);
            } // end if
        } // end if
        ++q;
    } // end while
    var cp = 0;
    while (cp < open_drag_pos.length)
    {
        if (corr_outObound.length > 0)
        {
            rand_num = Math.round(Math.random() * (open_drag_pos.length - 1));
            right_txt = drag_pair[corr_outObound[outObound_count]];
            wrong_txt = drag_pair[open_drag_pos[rand_num]];
            drag_pair.splice(open_drag_pos[rand_num], 1, right_txt);
            drag_pair.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = Distractors[corr_outObound[outObound_count]];
            wrong_txt = Distractors[open_drag_pos[rand_num]];
            Distractors.splice(open_drag_pos[rand_num], 1, right_txt);
            Distractors.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = ansID[corr_outObound[outObound_count]];
            wrong_txt = ansID[open_drag_pos[rand_num]];
            ansID.splice(open_drag_pos[rand_num], 1, right_txt);
            ansID.splice(corr_outObound[outObound_count], 1, wrong_txt);
            open_drag_pos.splice(rand_num, 1);
            corr_outObound.splice(outObound_count, 1);
            --cp;
        } // end if
        ++temp_ans;
        if (temp_ans > corr_drag_pos.length - 1)
        {
            break;
        } // end if
        ++cp;
    } // end while
    Distractors.splice(num_ans);
    ansID.splice(num_ans);
    drag_pair.splice(num_ans);
    temp_ans = 0;
    corr_outObound.splice(0, corr_outObound.length);
    outObound_count = 0;
    var q = 0;
    while (q < targ_pair.length)
    {
        answered = false;
        var r = 0;
        while (r < drag_pair.length)
        {
            if (drag_pair[r] != null || targ_pair[q] != null || (drag_pair[r] != undefined || targ_pair[q] != undefined))
            {
                if (drag_pair[r] == targ_pair[q])
                {
                    corr_targ_pos.push(q);
                    if (q > state_num - 1)
                    {
                        corr_outObound.push(q);
                    } // end if
                    ++corr_ans;
                    answered = true;
                    break;
                } // end if
            } // end if
            ++r;
        } // end while
        if (!answered)
        {
            if (q < state_num)
            {
                open_targ_pos.push(q);
            } // end if
        } // end if
        ++q;
    } // end while
    var cp = 0;
    while (cp < open_targ_pos.length)
    {
        if (corr_outObound.length > 0)
        {
            rand_num = Math.round(Math.random() * (open_targ_pos.length - 1));
            right_txt = targ_pair[corr_outObound[outObound_count]];
            wrong_txt = targ_pair[open_targ_pos[rand_num]];
            targ_pair.splice(open_targ_pos[rand_num], 1, right_txt);
            targ_pair.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = Statements[corr_outObound[outObound_count]];
            wrong_txt = Statements[open_targ_pos[rand_num]];
            Statements.splice(open_targ_pos[rand_num], 1, right_txt);
            Statements.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = stateID[corr_outObound[outObound_count]];
            wrong_txt = stateID[open_targ_pos[rand_num]];
            stateID.splice(open_targ_pos[rand_num], 1, right_txt);
            stateID.splice(corr_outObound[outObound_count], 1, wrong_txt);
            open_targ_pos.splice(rand_num, 1);
            corr_outObound.splice(outObound_count, 1);
            --cp;
        } // end if
        ++temp_ans;
        if (temp_ans > corr_targ_pos.length - 1)
        {
            break;
        } // end if
        ++cp;
    } // end while
    Statements.splice(state_num);
    stateID.splice(state_num);
    targ_pair.splice(state_num);
}
else
{
    var q = 0;
    while (q < targ_pair.length)
    {
        answered = false;
        var r = 0;
        while (r < drag_pair.length)
        {
            if (drag_pair[r] != null || targ_pair[q] != null || (drag_pair[r] != undefined || targ_pair[q] != undefined))
            {
                if (drag_pair[r] == targ_pair[q])
                {
                    corr_targ_pos.push(q);
                    if (q > state_num - 1)
                    {
                        corr_outObound.push(q);
                    } // end if
                    answered = true;
                    break;
                } // end if
            } // end if
            ++r;
        } // end while
        if (!answered)
        {
            if (q < state_num)
            {
                open_targ_pos.push(q);
            } // end if
        } // end if
        ++q;
    } // end while
    var cp = 0;
    while (cp < open_targ_pos.length)
    {
        if (corr_outObound.length > 0)
        {
            rand_num = Math.round(Math.random() * (open_targ_pos.length - 1));
            right_txt = targ_pair[corr_outObound[outObound_count]];
            wrong_txt = targ_pair[open_targ_pos[rand_num]];
            targ_pair.splice(open_targ_pos[rand_num], 1, right_txt);
            targ_pair.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = Statements[corr_outObound[outObound_count]];
            wrong_txt = Statements[open_targ_pos[rand_num]];
            Statements.splice(open_targ_pos[rand_num], 1, right_txt);
            Statements.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = stateID[corr_outObound[outObound_count]];
            wrong_txt = stateID[open_targ_pos[rand_num]];
            stateID.splice(open_targ_pos[rand_num], 1, right_txt);
            stateID.splice(corr_outObound[outObound_count], 1, wrong_txt);
            open_targ_pos.splice(rand_num, 1);
            corr_outObound.splice(outObound_count, 1);
            --cp;
        } // end if
        ++temp_ans;
        if (temp_ans > corr_targ_pos.length - 1)
        {
            break;
        } // end if
        ++cp;
    } // end while
    Statements.splice(state_num);
    stateID.splice(state_num);
    targ_pair.splice(state_num);
    temp_ans = 0;
    corr_outObound.splice(0, corr_outObound.length);
    outObound_count = 0;
    var q = 0;
    while (q < drag_pair.length)
    {
        answered = false;
        var r = 0;
        while (r < targ_pair.length)
        {
            if (drag_pair[q] != null || targ_pair[r] != null || (drag_pair[q] != undefined || targ_pair[r] != undefined))
            {
                if (drag_pair[q] == targ_pair[r])
                {
                    corr_drag_pos.push(q);
                    if (q > num_ans - 1)
                    {
                        corr_outObound.push(q);
                    } // end if
                    ++corr_ans;
                    answered = true;
                    break;
                } // end if
            } // end if
            ++r;
        } // end while
        if (!answered)
        {
            if (q < num_ans)
            {
                open_drag_pos.push(q);
            } // end if
        } // end if
        ++q;
    } // end while
    var cp = 0;
    while (cp < open_drag_pos.length)
    {
        if (corr_outObound.length > 0)
        {
            rand_num = Math.round(Math.random() * (open_drag_pos.length - 1));
            right_txt = drag_pair[corr_outObound[outObound_count]];
            wrong_txt = drag_pair[open_drag_pos[rand_num]];
            drag_pair.splice(open_drag_pos[rand_num], 1, right_txt);
            drag_pair.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = Distractors[corr_outObound[outObound_count]];
            wrong_txt = Distractors[open_drag_pos[rand_num]];
            Distractors.splice(open_drag_pos[rand_num], 1, right_txt);
            Distractors.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = ansID[corr_outObound[outObound_count]];
            wrong_txt = ansID[open_drag_pos[rand_num]];
            ansID.splice(open_drag_pos[rand_num], 1, right_txt);
            ansID.splice(corr_outObound[outObound_count], 1, wrong_txt);
            open_drag_pos.splice(rand_num, 1);
            corr_outObound.splice(outObound_count, 1);
            --cp;
        } // end if
        ++temp_ans;
        if (temp_ans > corr_drag_pos.length - 1)
        {
            break;
        } // end if
        ++cp;
    } // end while
    Distractors.splice(num_ans);
    ansID.splice(num_ans);
    drag_pair.splice(num_ans);
} // end else if
var a = 0;
while (a < num_ans)
{
    drag_obj[a] = prefix + "_Drag" + (a + 1);
    ++a;
} // end while
var s = 0;
while (s < state_num)
{
    targ_obj[s] = prefix + "_Target" + (s + 1);
    ++s;
} // end while
var st = 0;
while (st < Statements.length)
{
    var sp = 0;
    while (sp < Distractors.length)
    {
        if (drag_pair[sp] != null || targ_pair[st] != null)
        {
            if (drag_pair[sp] == targ_pair[st])
            {
                drag_key.push(String.fromCharCode(sp + 65));
                targ_key.push(st + 1);
                corr_key.push(String(st + 1) + "." + String.fromCharCode(sp + 65));
                break;
            } // end if
        } // end if
        ++sp;
    } // end while
    ++st;
} // end while
var c = 0;
while (c < state_num)
{
    this["statement" + (c + 1)].text = c + 1 + ". " + Statements[c];
    this["statement" + (c + 1)].setTextFormat(ansTxt);
    ++c;
} // end while
var d = 0;
while (d < num_ans)
{
    if (subClass == "m_img")
    {
        targ_imgW = this[prefix + "_Drag" + (d + 1)].placeHold._width;
        targ_imgH = this[prefix + "_Drag" + (d + 1)].placeHold._height;
        image_mcl.loadClip(Distractors[d], this[prefix + "_Drag" + (d + 1)].placeHold.image);
        image_mcl.loadClip(Distractors[d], this[prefix + "_Back" + (d + 1)].placeHold.image);
        this[prefix + "_Back" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Drag" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Back" + (d + 1)].letter.setTextFormat(ddIbackL);
        this[prefix + "_Drag" + (d + 1)].letter.setTextFormat(ddIansL);
        this[prefix + "_Drag" + (d + 1)].letter._visible = false;
        if (!cropimage)
        {
            this[prefix + "_Back" + (d + 1)].letter._visible = false;
        } // end if
    }
    else
    {
        this[prefix + "_Drag" + (d + 1)].dragTxt.text = letters[d] + Distractors[d];
        this[prefix + "_Drag" + (d + 1)].dragTxt.setTextFormat(ddTxtAns);
    } // end else if
    ++d;
} // end while
var x = Number(num_ans) + 1;
while (x <= max_ans)
{
    if (subClass == "m_img")
    {
        this[prefix + "_Drag" + x]._visible = false;
        this[prefix + "_Back" + x]._visible = false;
    }
    else
    {
        this[prefix + "_Drag" + x]._visible = false;
    } // end else if
    ++x;
} // end while
var x = Number(state_num) + 1;
while (x <= max_ans)
{
    this["statement" + x]._visible = false;
    if (subClass == "m_img")
    {
        this[prefix + "_Target" + x]._visible = false;
    }
    else
    {
        this[prefix + "_Target" + x]._visible = false;
    } // end else if
    ++x;
} // end while
if (corr_key.length > 1)
{
    feedback_text = "Sorry, the correct matching pairs are ";
}
else
{
    feedback_text = "Sorry, the correct matching pair is ";
} // end else if
countThis();

// [Action in Frame 96]
stop ();

// [Action in Frame 97]
fade.play();

// [Action in Frame 98]
function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var answered = false;
var targ_imgH = 0;
var targ_imgW = 0;
var percH = 0;
var percW = 0;
var answer = 0;
var Hpos = 0;
var Vpos = 0;
var drag_obj = Array();
var targ_obj = Array();
var open_targ_pos = Array();
var open_drag_pos = Array();
var corr_targ_pos = Array();
var corr_drag_pos = Array();
var targ_key = Array();
var drag_key = Array();
var corr_key = Array();
var right_txt = "";
var wrong_txt = "";
var temp_ans = 0;
var corr_outObound = Array();
var outObound_count = 0;
var corr_ans = 0;
var mclListener = new Object();
assignQtext();
mclListener.onLoadError = function (target_mc, errorCode)
{
    trace ("ERROR!");
    switch (errorCode)
    {
        case "URLNotFound":
        {
            trace ("\t Unable to connect to URL: " + target_mc._url);
            break;
        } 
        case "LoadNeverCompleted":
        {
            trace ("\t Unable to complete download: " + target_mc);
            break;
        } 
    } // End of switch
};
mclListener.onLoadInit = function (target_mc)
{
    percW = targ_imgW / target_mc._width;
    percH = targ_imgH / target_mc._height;
    if (cropimage)
    {
        if (percW > percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
            outW = target_mc._width / 2;
            outH = targ_imgH / 2;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
            outW = targ_imgW / 2;
            outH = target_mc._height / 2;
        } // end else if
    }
    else
    {
        if (percW < percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
        } // end else if
        outW = target_mc._width / 2;
        outH = target_mc._height / 2;
    } // end else if
    target_mc._x = target_mc._x + (targ_imgW - target_mc._width) / 2;
    target_mc._y = target_mc._y + (targ_imgH - target_mc._height) / 2;
    target_mc._parent.drawImgOutline(outH, outW);
};
var image_mcl = new MovieClipLoader();
image_mcl.addListener(mclListener);
if (subClass == "m_img")
{
    prefix = "mi";
}
else
{
    prefix = "mt";
} // end else if
var m = 0;
while (m < ans_order.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].nodeName.toLowerCase() == "answer")
    {
        ++answer;
        Distractors[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].childNodes[0].nodeValue;
        if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.PairID == undefined)
        {
            drag_pair[answer - 1] = null;
        }
        else
        {
            drag_pair[answer - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.PairID;
        } // end else if
        ansID.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.aID);
    }
    else
    {
        ++state_num;
        if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.PairID == undefined)
        {
            targ_pair[state_num - 1] = null;
        }
        else
        {
            targ_pair[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.PairID;
        } // end else if
        Statements[state_num - 1] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].childNodes[0].nodeValue;
        stateID.push(rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.sID);
    } // end else if
    ++m;
} // end while
if (drag_pair.length >= targ_pair.length)
{
    limit = drag_pair.length;
}
else
{
    limit = targ_pair.length;
} // end else if
answer = 1;
if (rootNode.childNodes[quest_order[qCount]].attributes.Targ != undefined)
{
    state_num = rootNode.childNodes[quest_order[qCount]].attributes.Targ;
}
else
{
    state_num = targ_pair.length;
} // end else if
if (state_num > num_ans)
{
    var q = 0;
    while (q < drag_pair.length)
    {
        answered = false;
        var r = 0;
        while (r < targ_pair.length)
        {
            if (drag_pair[q] != null || targ_pair[r] != null || (drag_pair[q] != undefined || targ_pair[r] != undefined))
            {
                if (drag_pair[q] == targ_pair[r])
                {
                    corr_drag_pos.push(q);
                    if (q > num_ans - 1)
                    {
                        corr_outObound.push(q);
                    } // end if
                    answered = true;
                    break;
                } // end if
            } // end if
            ++r;
        } // end while
        if (!answered)
        {
            if (q < num_ans)
            {
                open_drag_pos.push(q);
            } // end if
        } // end if
        ++q;
    } // end while
    var cp = 0;
    while (cp < open_drag_pos.length)
    {
        if (corr_outObound.length > 0)
        {
            rand_num = Math.round(Math.random() * (open_drag_pos.length - 1));
            right_txt = drag_pair[corr_outObound[outObound_count]];
            wrong_txt = drag_pair[open_drag_pos[rand_num]];
            drag_pair.splice(open_drag_pos[rand_num], 1, right_txt);
            drag_pair.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = Distractors[corr_outObound[outObound_count]];
            wrong_txt = Distractors[open_drag_pos[rand_num]];
            Distractors.splice(open_drag_pos[rand_num], 1, right_txt);
            Distractors.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = ansID[corr_outObound[outObound_count]];
            wrong_txt = ansID[open_drag_pos[rand_num]];
            ansID.splice(open_drag_pos[rand_num], 1, right_txt);
            ansID.splice(corr_outObound[outObound_count], 1, wrong_txt);
            open_drag_pos.splice(rand_num, 1);
            corr_outObound.splice(outObound_count, 1);
            --cp;
        } // end if
        ++temp_ans;
        if (temp_ans > corr_drag_pos.length - 1)
        {
            break;
        } // end if
        ++cp;
    } // end while
    Distractors.splice(num_ans);
    ansID.splice(num_ans);
    drag_pair.splice(num_ans);
    temp_ans = 0;
    corr_outObound.splice(0, corr_outObound.length);
    outObound_count = 0;
    var q = 0;
    while (q < targ_pair.length)
    {
        answered = false;
        var r = 0;
        while (r < drag_pair.length)
        {
            if (drag_pair[r] != null || targ_pair[q] != null || (drag_pair[r] != undefined || targ_pair[q] != undefined))
            {
                if (drag_pair[r] == targ_pair[q])
                {
                    corr_targ_pos.push(q);
                    if (q > state_num - 1)
                    {
                        corr_outObound.push(q);
                    } // end if
                    ++corr_ans;
                    answered = true;
                    break;
                } // end if
            } // end if
            ++r;
        } // end while
        if (!answered)
        {
            if (q < state_num)
            {
                open_targ_pos.push(q);
            } // end if
        } // end if
        ++q;
    } // end while
    var cp = 0;
    while (cp < open_targ_pos.length)
    {
        if (corr_outObound.length > 0)
        {
            rand_num = Math.round(Math.random() * (open_targ_pos.length - 1));
            right_txt = targ_pair[corr_outObound[outObound_count]];
            wrong_txt = targ_pair[open_targ_pos[rand_num]];
            targ_pair.splice(open_targ_pos[rand_num], 1, right_txt);
            targ_pair.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = Statements[corr_outObound[outObound_count]];
            wrong_txt = Statements[open_targ_pos[rand_num]];
            Statements.splice(open_targ_pos[rand_num], 1, right_txt);
            Statements.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = stateID[corr_outObound[outObound_count]];
            wrong_txt = stateID[open_targ_pos[rand_num]];
            stateID.splice(open_targ_pos[rand_num], 1, right_txt);
            stateID.splice(corr_outObound[outObound_count], 1, wrong_txt);
            open_targ_pos.splice(rand_num, 1);
            corr_outObound.splice(outObound_count, 1);
            --cp;
        } // end if
        ++temp_ans;
        if (temp_ans > corr_targ_pos.length - 1)
        {
            break;
        } // end if
        ++cp;
    } // end while
    Statements.splice(state_num);
    stateID.splice(state_num);
    targ_pair.splice(state_num);
}
else
{
    var q = 0;
    while (q < targ_pair.length)
    {
        answered = false;
        var r = 0;
        while (r < drag_pair.length)
        {
            if (drag_pair[r] != null || targ_pair[q] != null || (drag_pair[r] != undefined || targ_pair[q] != undefined))
            {
                if (drag_pair[r] == targ_pair[q])
                {
                    corr_targ_pos.push(q);
                    if (q > state_num - 1)
                    {
                        corr_outObound.push(q);
                    } // end if
                    answered = true;
                    break;
                } // end if
            } // end if
            ++r;
        } // end while
        if (!answered)
        {
            if (q < state_num)
            {
                open_targ_pos.push(q);
            } // end if
        } // end if
        ++q;
    } // end while
    var cp = 0;
    while (cp < open_targ_pos.length)
    {
        if (corr_outObound.length > 0)
        {
            rand_num = Math.round(Math.random() * (open_targ_pos.length - 1));
            right_txt = targ_pair[corr_outObound[outObound_count]];
            wrong_txt = targ_pair[open_targ_pos[rand_num]];
            targ_pair.splice(open_targ_pos[rand_num], 1, right_txt);
            targ_pair.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = Statements[corr_outObound[outObound_count]];
            wrong_txt = Statements[open_targ_pos[rand_num]];
            Statements.splice(open_targ_pos[rand_num], 1, right_txt);
            Statements.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = stateID[corr_outObound[outObound_count]];
            wrong_txt = stateID[open_targ_pos[rand_num]];
            stateID.splice(open_targ_pos[rand_num], 1, right_txt);
            stateID.splice(corr_outObound[outObound_count], 1, wrong_txt);
            open_targ_pos.splice(rand_num, 1);
            corr_outObound.splice(outObound_count, 1);
            --cp;
        } // end if
        ++temp_ans;
        if (temp_ans > corr_targ_pos.length - 1)
        {
            break;
        } // end if
        ++cp;
    } // end while
    Statements.splice(state_num);
    stateID.splice(state_num);
    targ_pair.splice(state_num);
    temp_ans = 0;
    corr_outObound.splice(0, corr_outObound.length);
    outObound_count = 0;
    var q = 0;
    while (q < drag_pair.length)
    {
        answered = false;
        var r = 0;
        while (r < targ_pair.length)
        {
            if (drag_pair[q] != null || targ_pair[r] != null || (drag_pair[q] != undefined || targ_pair[r] != undefined))
            {
                if (drag_pair[q] == targ_pair[r])
                {
                    corr_drag_pos.push(q);
                    if (q > num_ans - 1)
                    {
                        corr_outObound.push(q);
                    } // end if
                    ++corr_ans;
                    answered = true;
                    break;
                } // end if
            } // end if
            ++r;
        } // end while
        if (!answered)
        {
            if (q < num_ans)
            {
                open_drag_pos.push(q);
            } // end if
        } // end if
        ++q;
    } // end while
    var cp = 0;
    while (cp < open_drag_pos.length)
    {
        if (corr_outObound.length > 0)
        {
            rand_num = Math.round(Math.random() * (open_drag_pos.length - 1));
            right_txt = drag_pair[corr_outObound[outObound_count]];
            wrong_txt = drag_pair[open_drag_pos[rand_num]];
            drag_pair.splice(open_drag_pos[rand_num], 1, right_txt);
            drag_pair.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = Distractors[corr_outObound[outObound_count]];
            wrong_txt = Distractors[open_drag_pos[rand_num]];
            Distractors.splice(open_drag_pos[rand_num], 1, right_txt);
            Distractors.splice(corr_outObound[outObound_count], 1, wrong_txt);
            right_txt = ansID[corr_outObound[outObound_count]];
            wrong_txt = ansID[open_drag_pos[rand_num]];
            ansID.splice(open_drag_pos[rand_num], 1, right_txt);
            ansID.splice(corr_outObound[outObound_count], 1, wrong_txt);
            open_drag_pos.splice(rand_num, 1);
            corr_outObound.splice(outObound_count, 1);
            --cp;
        } // end if
        ++temp_ans;
        if (temp_ans > corr_drag_pos.length - 1)
        {
            break;
        } // end if
        ++cp;
    } // end while
    Distractors.splice(num_ans);
    ansID.splice(num_ans);
    drag_pair.splice(num_ans);
} // end else if
var a = 0;
while (a < num_ans)
{
    drag_obj[a] = prefix + "_Drag" + (a + 1);
    ++a;
} // end while
var s = 0;
while (s < state_num)
{
    targ_obj[s] = prefix + "_Target" + (s + 1);
    ++s;
} // end while
var st = 0;
while (st < Statements.length)
{
    var sp = 0;
    while (sp < Distractors.length)
    {
        if (drag_pair[sp] != null || targ_pair[st] != null)
        {
            if (drag_pair[sp] == targ_pair[st])
            {
                drag_key.push(String.fromCharCode(sp + 65));
                targ_key.push(st + 1);
                corr_key.push(String(st + 1) + "." + String.fromCharCode(sp + 65));
                break;
            } // end if
        } // end if
        ++sp;
    } // end while
    ++st;
} // end while
var c = 0;
while (c < state_num)
{
    this["statement" + (c + 1)].text = c + 1 + ". " + Statements[c];
    this["statement" + (c + 1)].setTextFormat(ansTxt);
    ++c;
} // end while
var d = 0;
while (d < num_ans)
{
    if (subClass == "m_img")
    {
        targ_imgW = this[prefix + "_Drag" + (d + 1)].placeHold._width;
        targ_imgH = this[prefix + "_Drag" + (d + 1)].placeHold._height;
        image_mcl.loadClip(Distractors[d], this[prefix + "_Drag" + (d + 1)].placeHold.image);
        image_mcl.loadClip(Distractors[d], this[prefix + "_Back" + (d + 1)].placeHold.image);
        this[prefix + "_Back" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Drag" + (d + 1)].letter.text = letters[d];
        this[prefix + "_Back" + (d + 1)].letter.setTextFormat(ddIbackL);
        this[prefix + "_Drag" + (d + 1)].letter.setTextFormat(ddIansL);
        this[prefix + "_Drag" + (d + 1)].letter._visible = false;
        if (!cropimage)
        {
            this[prefix + "_Back" + (d + 1)].letter._visible = false;
        } // end if
    }
    else
    {
        this[prefix + "_Drag" + (d + 1)].dragTxt.text = letters[d] + Distractors[d];
        this[prefix + "_Drag" + (d + 1)].dragTxt.setTextFormat(ddTxtAns);
    } // end else if
    ++d;
} // end while
var x = Number(num_ans) + 1;
while (x <= max_ans)
{
    if (subClass == "m_img")
    {
        this[prefix + "_Drag" + x]._visible = false;
        this[prefix + "_Back" + x]._visible = false;
    }
    else
    {
        this[prefix + "_Drag" + x]._visible = false;
    } // end else if
    ++x;
} // end while
var x = Number(state_num) + 1;
while (x <= max_ans)
{
    this["statement" + x]._visible = false;
    if (subClass == "m_img")
    {
        this[prefix + "_Target" + x]._visible = false;
    }
    else
    {
        this[prefix + "_Target" + x]._visible = false;
    } // end else if
    ++x;
} // end while
if (corr_key.length > 1)
{
    feedback_text = "Sorry, the correct matching pairs are ";
}
else
{
    feedback_text = "Sorry, the correct matching pair is ";
} // end else if
countThis();

// [Action in Frame 99]
stop ();

// [Action in Frame 100]
fade.play();

// [Action in Frame 101]
HotSpot8._accProps = new Object();
HotSpot8._accProps.name = "Hot Spot 6";
HotSpot8._accProps.description = "Hot spot number 6.";
HotSpot8._accProps.forceSimple = true;

HotSpot7._accProps = new Object();
HotSpot7._accProps.name = "Hot Spot 6";
HotSpot7._accProps.description = "Hot spot number 6.";
HotSpot7._accProps.forceSimple = true;

HotSpot6._accProps = new Object();
HotSpot6._accProps.name = "Hot Spot 6";
HotSpot6._accProps.description = "Hot spot number 6.";
HotSpot6._accProps.forceSimple = true;

HotSpot5._accProps = new Object();
HotSpot5._accProps.name = "Hot Spot 5";
HotSpot5._accProps.description = "Hot spot number 5.";
HotSpot5._accProps.forceSimple = true;

HotSpot4._accProps = new Object();
HotSpot4._accProps.name = "Hot Spot 4";
HotSpot4._accProps.description = "Hot spot number 1.";
HotSpot4._accProps.forceSimple = true;

HotSpot3._accProps = new Object();
HotSpot3._accProps.name = "Hot Spot 3";
HotSpot3._accProps.description = "Hot spot number 3.";
HotSpot3._accProps.forceSimple = true;

HotSpot2._accProps = new Object();
HotSpot2._accProps.name = "Hot Spot 2";
HotSpot2._accProps.description = "Hot spot number 2.";
HotSpot2._accProps.forceSimple = true;

HotSpot1._accProps = new Object();
HotSpot1._accProps.name = "Hot Spot 1";
HotSpot1._accProps.description = "Hot spot number 1.";
HotSpot1._accProps.forceSimple = true;

function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var targ_imgH = 0;
var targ_imgW = 0;
var percH = 0;
var percW = 0;
var answer = num_ans;
var Hpos = 0;
var Vpos = 0;
var corr_ans = 0;
var hs_info = "";
var image_name = rootNode.childNodes[quest_order[qCount]].attributes.Img;
var mclListener = new Object();
assignQtext();
mclListener.onLoadError = function (target_mc, errorCode)
{
    trace ("ERROR!");
    switch (errorCode)
    {
        case "URLNotFound":
        {
            trace ("\t Unable to connect to URL: " + target_mc._url);
            break;
        } 
        case "LoadNeverCompleted":
        {
            trace ("\t Unable to complete download: " + target_mc);
            break;
        } 
    } // End of switch
};
mclListener.onLoadInit = function (target_mc)
{
    percW = targ_imgW / target_mc._width;
    percH = targ_imgH / target_mc._height;
    if (cropimage)
    {
        if (percW > percH)
        {
            target_mc._width = target_mc._width * percW;
            target_mc._height = target_mc._height * percW;
        }
        else
        {
            target_mc._width = target_mc._width * percH;
            target_mc._height = target_mc._height * percH;
        } // end else if
    }
    else if (percW < percH)
    {
        target_mc._width = target_mc._width * percW;
        target_mc._height = target_mc._height * percW;
    }
    else
    {
        target_mc._width = target_mc._width * percH;
        target_mc._height = target_mc._height * percH;
    } // end else if
    target_mc._x = target_mc._x + (targ_imgW - target_mc._width) / 2;
};
var image_mcl = new MovieClipLoader();
image_mcl.addListener(mclListener);
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "true")
{
    cropimage = true;
}
else
{
    cropimage = false;
} // end else if
targ_imgW = hs_back._width;
targ_imgH = hs_back._height;
image_mcl.loadClip(image_name, hs_back.image);
var m = 0;
while (m < num_ans)
{
    hs_info = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].childNodes[0].nodeValue;
    Distractors[m] = hs_info.split("|");
    this["HotSpot" + (m + 1)]._x = Number(Distractors[m][0]) + hs_back._x;
    this["HotSpot" + (m + 1)]._y = Number(Distractors[m][1]) + hs_back._y;
    this["HotSpot" + (m + 1)]._height = Number(Distractors[m][2]);
    this["HotSpot" + (m + 1)]._width = Number(Distractors[m][3]);
    ansID[m] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.aID;
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[m] + 1].attributes.Correct == "Yes")
    {
        _global.correctletter = letters[m];
        CResponse[m] = true;
        ++corr_ans;
    }
    else
    {
        CResponse[m] = false;
    } // end else if
    ++m;
} // end while
var x = Number(num_ans) + 1;
while (x <= max_ans)
{
    this["HotSpot" + x]._visible = false;
    ++x;
} // end while
if (corr_ans == 1)
{
    feedback_text = "Sorry, the correct answer is highlighted in green.";
}
else
{
    feedback_text = "Sorry, the correct answers are highlighted in green.";
} // end else if
countThis();
stop ();

// [Action in Frame 102]
fade.play();

// [Action in Frame 103]
HotObject6._accProps = new Object();
HotObject6._accProps.name = "Hot Object 6";
HotObject6._accProps.description = "Hot Object number 6.";
HotObject6._accProps.forceSimple = true;

HotObject5._accProps = new Object();
HotObject5._accProps.name = "Hot Object 5";
HotObject5._accProps.description = "Hot Object number 5.";
HotObject5._accProps.forceSimple = true;

HotObject4._accProps = new Object();
HotObject4._accProps.name = "Hot Object 4";
HotObject4._accProps.description = "Hot Object number 4.";
HotObject4._accProps.forceSimple = true;

HotObject3._accProps = new Object();
HotObject3._accProps.name = "Hot Object 3";
HotObject3._accProps.description = "Hot Object number 3.";
HotObject3._accProps.forceSimple = true;

HotObject2._accProps = new Object();
HotObject2._accProps.name = "Hot Object 2";
HotObject2._accProps.description = "Hot Object number 2.";
HotObject2._accProps.forceSimple = true;

HotObject1._accProps = new Object();
HotObject1._accProps.name = "Hot Object 1";
HotObject1._accProps.description = "Hot Object number 1.";
HotObject1._accProps.forceSimple = true;

function QEnd()
{
    gotoAndPlay("results");
} // End of the function
function gen_draw_Outline(targ_img)
{
    targ_img.createEmptyMovieClip("outline", this.getNextHighestDepth());
    targ_img.outline.lineStyle(_root.Graphic_arr.qLines.LineT, _root.Graphic_arr.qLines.LineC, _root.Graphic_arr.qLines.LineA);
    targ_img.outline.moveTo(targ_img.image._x, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y + targ_img.image._height);
    targ_img.outline.lineTo(targ_img.image._x + targ_img.image._width, targ_img.image._y);
    targ_img.outline.lineTo(targ_img.image._x, targ_img.image._y);
} // End of the function
function drawOutline()
{
    for (var _loc2 = 0; _loc2 < max_ans; ++_loc2)
    {
        if (visibility[_loc2])
        {
            gen_draw_Outline(this["HotObject" + (_loc2 + 1)]);
        } // end if
    } // end of for
} // End of the function
function assignQtext()
{
    questID = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.qID;
    Quest = rootNode.childNodes[quest_order[qCount]].childNodes[0].childNodes[0].nodeValue;
} // End of the function
var Distractors = Array();
var Statements = Array();
var CResponse = Array();
var ans_order = Array();
var possible_ans = Array();
var ans_spots = Array();
var mcq_info = Array();
var sort_order = Array();
var visibility = [false, false, false, false, false, false, false, false];
var randomize = false;
var qType = rootNode.childNodes[quest_order[qCount]].nodeName;
var Quest = "";
var cropimage = true;
var resizeimage = true;
var partialC = false;
var ansLimit = false;
var weight = 1;
var corr_ans = 0;
var state_num = 0;
var feedback_text = "";
var Hspace = 20;
var Vspace = 20;
var answer = num_ans;
var targ_pair = Array();
var drag_pair = Array();
var prefix = "";
var questID = "";
var ansID = Array();
var stateID = Array();
var limit = 0;
var letterColor = new Color(16777215);
Template_Question.setNewTextFormat(questTxt);
Template_Feedback.setNewTextFormat(questStat);
stat_txt.setNewTextFormat(questStat);
Template_ControlButton.color = qbuttons.color;
if (rootNode.childNodes[quest_order[qCount]].attributes.CropImage.toLowerCase() == "false")
{
    cropimage = false;
} // end if
if (qCount + 1 == totalQuestions)
{
    Q_Component.ButtonLabels3 = "Show Results";
} // end if
section = rootNode.childNodes[quest_order[qCount]].childNodes[0].attributes.Section;
if (section != "0")
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString() + " - Section " + section;
}
else
{
    stat_txt.text = (qCount + 1).toString() + "/" + totalQuestions.toString();
} // end else if
num_ans = 0;
var t = 1;
while (t < rootNode.childNodes[quest_order[qCount]].childNodes.length)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[t].nodeName.toLowerCase() == "answer")
    {
        if (qType.toLowerCase() == "mchoice")
        {
            mcq_info[num_ans] = new Array();
            mcq_info[num_ans][0] = rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.aID;
            if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Correct.toLowerCase() == "yes")
            {
                mcq_info[num_ans][1] = true;
                ++corr_ans;
            }
            else
            {
                mcq_info[num_ans][1] = false;
            } // end else if
            var temp_aText = rootNode.childNodes[quest_order[qCount]].childNodes[t].childNodes[0].nodeValue;
            if (temp_aText.toLowerCase().indexOf("of the above") != -1)
            {
                mcq_info[num_ans][2] = 2;
            }
            else if (rootNode.childNodes[quest_order[qCount]].childNodes[t].attributes.Ref.toLowerCase() == "true")
            {
                mcq_info[num_ans][2] = 1;
                mcq_info[num_ans][3] = new Array();
                var start_index = 0;
                while (temp_aText.indexOf("~~", start_index) >= 0)
                {
                    mcq_info[num_ans][3].push(temp_aText.substring(temp_aText.indexOf("~~", start_index) + 2, temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2)));
                    start_index = temp_aText.indexOf("~~", temp_aText.indexOf("~~", start_index) + 2) + 2;
                } // end while
                if (mcq_info[num_ans][1])
                {
                    corr_ans = corr_ans + mcq_info[num_ans][3].length;
                } // end if
            }
            else
            {
                mcq_info[num_ans][2] = 0;
            } // end else if
        } // end else if
        ++num_ans;
    }
    else
    {
        ++num_ans;
    } // end else if
    ++t;
} // end while
if (rootNode.childNodes[quest_order[qCount]].attributes.Ans != undefined)
{
    if (Number(rootNode.childNodes[quest_order[qCount]].attributes.Ans) < num_ans)
    {
        num_ans = rootNode.childNodes[quest_order[qCount]].attributes.Ans;
    } // end if
} // end if
if (corr_ans > num_ans)
{
    num_ans = corr_ans;
} // end if
corr_ans = 0;
if (num_ans > max_ans)
{
    num_ans = max_ans;
} // end if
if (rootNode.attributes.Partial.toLowerCase() == "yes" || rootNode.attributes.Partial.toLowerCase() == "true")
{
    partialC = true;
}
else
{
    partialC = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Partial != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.Partial.toLowerCase() == "true")
    {
        partialC = true;
    }
    else
    {
        partialC = false;
    } // end if
} // end else if
if (rootNode.attributes.AnsLimit.toLowerCase() == "yes" || rootNode.attributes.AnsLimit.toLowerCase() == "true")
{
    ansLimit = true;
}
else
{
    ansLimit = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit != undefined)
{
    if (rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "yes" || rootNode.childNodes[quest_order[qCount]].attributes.AnsLimit.toLowerCase() == "true")
    {
        ansLimit = true;
    }
    else
    {
        ansLimit = false;
    } // end if
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Weight != undefined || !isNaN(Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight)))
{
    weight = Number(rootNode.childNodes[quest_order[qCount]].attributes.Weight);
} // end if
if (rootNode.attributes.Feedback.toLowerCase() == "no" || rootNode.attributes.Feedback.toLowerCase() == "false")
{
    Q_Component.Feedback = false;
}
else
{
    Feedback = true;
} // end else if
if (rootNode.attributes.Track.toLowerCase() == "yes" || rootNode.attributes.Track.toLowerCase() == "true")
{
    Q_Component.Tracking = true;
}
else
{
    Q_Component.Tracking = false;
} // end else if
if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else if (rootNode.childNodes[quest_order[qCount]].attributes.Random.toLowerCase() == "none")
{
    randomize = false;
}
else if (rootNode.attributes.Random.toLowerCase() == "both" || rootNode.attributes.Random.toLowerCase() == "ans")
{
    randomize = true;
}
else
{
    randomize = false;
} // end else if
if (randomize)
{
    var i = 0;
    while (i < rootNode.childNodes[quest_order[qCount]].childNodes.length - 1)
    {
        possible_ans[i] = i;
        if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
        {
            ans_spots[i] = i;
        }
        else if (i < num_ans)
        {
            ans_spots[i] = i;
        } // end else if
        ++i;
    } // end while
    var j = possible_ans.length - 1;
    while (j >= 0)
    {
        if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct.toLowerCase() == "yes")
        {
            if (qType.toLowerCase() == "mchoice")
            {
                switch (mcq_info[j][2])
                {
                    case 0:
                    {
                        rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                    case 1:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        var k = 0;
                        while (k < mcq_info[j][3].length)
                        {
                            var m = 0;
                            while (m < possible_ans.length)
                            {
                                if (mcq_info[j][3][k] == mcq_info[possible_ans[m]][0])
                                {
                                    rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                                    ans_order[ans_spots[rand_num]] = possible_ans[m];
                                    sort_order[ans_spots[rand_num]] = Math.round(Math.random() * (ans_spots.length * 10));
                                    possible_ans.splice(m, 1);
                                    ans_spots.splice(rand_num, 1);
                                    break;
                                } // end if
                                ++m;
                            } // end while
                            ++k;
                        } // end while
                        break;
                    } 
                    case 2:
                    {
                        rand_num = ans_spots.length - 1;
                        ans_order[ans_spots[rand_num]] = j;
                        var h = 0;
                        while (h < possible_ans.length)
                        {
                            if (possible_ans[h] == j)
                            {
                                possible_ans.splice(h, 1);
                                break;
                            } // end if
                            ++h;
                        } // end while
                        sort_order[ans_spots[rand_num]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                        ans_spots.splice(rand_num, 1);
                        break;
                    } 
                } // End of switch
            }
            else
            {
                rand_num = Math.round(Math.random() * (ans_spots.length - 1));
                ans_order[ans_spots[rand_num]] = possible_ans[j];
                possible_ans.splice(j, 1);
                ans_spots.splice(rand_num, 1);
            } // end else if
            ++corr_ans;
        }
        else if (rootNode.childNodes[quest_order[qCount]].childNodes[j + 1].attributes.Correct == "Yes")
        {
            rand_num = Math.round(Math.random() * (ans_spots.length - 1));
            ans_order[ans_spots[rand_num]] = possible_ans[j];
            possible_ans.splice(j, 1);
            ans_spots.splice(rand_num, 1);
            ++corr_ans;
        } // end else if
        --j;
    } // end while
    var k = ans_spots.length - 1;
    while (k >= 0)
    {
        rand_num = Math.round(Math.random() * (possible_ans.length - 1));
        if (qType.toLowerCase() == "mchoice")
        {
            switch (mcq_info[possible_ans[rand_num]][2])
            {
                case 0:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
                case 1:
                {
                    var its_there = false;
                    var num_there = 0;
                    var n = 0;
                    while (n < mcq_info[possible_ans[rand_num]][3].length)
                    {
                        its_there = false;
                        var m = 0;
                        while (m < ans_order.length)
                        {
                            if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[ans_order[m]][0])
                            {
                                its_there = true;
                                ++num_there;
                                break;
                            } // end if
                            ++m;
                        } // end while
                        if (!its_there)
                        {
                            if (k >= 0)
                            {
                                var p = 0;
                                while (p < possible_ans.length)
                                {
                                    if (mcq_info[possible_ans[rand_num]][3][n] == mcq_info[possible_ans[p]][0])
                                    {
                                        ans_order[ans_spots[k]] = possible_ans[p];
                                        sort_order[ans_spots[k]] = Math.round(Math.random() * (ans_spots.length * 10));
                                        possible_ans.splice(p, 1);
                                        if (p < rand_num)
                                        {
                                            --rand_num;
                                        } // end if
                                        --k;
                                        ++num_there;
                                        break;
                                    } // end if
                                    ++p;
                                } // end while
                            } // end if
                        } // end if
                        ++n;
                    } // end while
                    if (k >= 0)
                    {
                        ans_order[ans_spots[k]] = possible_ans[rand_num];
                        sort_order[ans_spots[k]] = 100 + Math.round(Math.random() * (ans_spots.length * 10));
                        possible_ans.splice(rand_num, 1);
                    } // end if
                    break;
                } 
                case 2:
                {
                    ans_order[ans_spots[k]] = possible_ans[rand_num];
                    sort_order[ans_spots[k]] = 200 + Math.round(Math.random() * (ans_spots.length * 10));
                    possible_ans.splice(rand_num, 1);
                    break;
                } 
            } // End of switch
        }
        else
        {
            ans_order[ans_spots[k]] = possible_ans[rand_num];
            possible_ans.splice(rand_num, 1);
        } // end else if
        --k;
    } // end while
    if (qType.toLowerCase() == "mchoice")
    {
        var i = sort_order.length - 1;
        while (i >= 0)
        {
            var j = 0;
            while (j <= i)
            {
                if (sort_order[j - 1] > sort_order[j])
                {
                    temp = sort_order[j - 1];
                    sort_order[j - 1] = sort_order[j];
                    sort_order[j] = temp;
                    temp = ans_order[j - 1];
                    ans_order[j - 1] = ans_order[j];
                    ans_order[j] = temp;
                } // end if
                ++j;
            } // end while
            --i;
        } // end while
    } // end if
}
else
{
    if (qType.toLowerCase() == "match" || qType.toLowerCase() == "group" || qType.toLowerCase() == "order")
    {
        limit = rootNode.childNodes[quest_order[qCount]].childNodes.length;
    }
    else
    {
        limit = num_ans;
    } // end else if
    var l = 0;
    while (l < limit)
    {
        ans_order[l] = l;
        ++l;
    } // end while
} // end else if
var space_num = 0;
var targ_imgH = 0;
var targ_imgW = 0;
var percH = 0;
var percW = 0;
var answer = num_ans;
var Hpos = 0;
var Vpos = 0;
var corr_ans = 0;
assignQtext();
var h = 1;
while (h <= max_ans)
{
    this["HotObject" + h]._visible = false;
    ++h;
} // end while
if (num_ans > 2)
{
    space_num = Math.ceil(num_ans / 2);
    targ_imgH = (ansArea._height - 3 * Vspace) / 2;
}
else
{
    space_num = 2;
    targ_imgH = ansArea._height - 2 * Vspace;
} // end else if
targ_imgW = (ansArea._width - (space_num + 1) * Hspace) / space_num;
var mclListener = new Object();
mclListener.onLoadError = function (target_mc, errorCode)
{
    trace ("ERROR!");
    switch (errorCode)
    {
        case "URLNotFound":
        {
            trace ("\t Unable to connect to URL: " + target_mc._url);
            break;
        } 
        case "LoadNeverCompleted":
        {
            trace ("\t Unable to complete download: " + target_mc);
            break;
        } 
    } // End of switch
};
mclListener.onLoadInit = function (target_mc)
{
    percW = targ_imgW / target_mc._width;
    percH = targ_imgH / target_mc._height;
    if (percW < percH)
    {
        target_mc._width = target_mc._width * percW;
        target_mc._height = target_mc._height * percW;
    }
    else
    {
        target_mc._width = target_mc._width * percH;
        target_mc._height = target_mc._height * percH;
    } // end else if
    --answer;
    if (answer <= 0)
    {
        var v = 0;
        while (v < num_ans)
        {
            if (num_ans > 2)
            {
                if (v < Math.ceil(num_ans / 2))
                {
                    Hpos = v;
                    Vpos = 0;
                }
                else
                {
                    Hpos = v - Math.ceil(num_ans / 2);
                    Vpos = 1;
                } // end else if
            }
            else
            {
                Hpos = v;
                Vpos = 0;
            } // end else if
            with (_root["HotObject" + (v + 1)])
            {
                image._x = Hspace * (Hpos + 1) + targ_imgW * Hpos + (targ_imgW - image._width) / 2;
                image._y = Vspace * (Vpos + 1) + targ_imgH * Vpos + (targ_imgH - image._height) / 2;
                _visible = true;
            } // End of with
            ++v;
        } // end while
        drawOutline();
    } // end if
};
var image_mcl = new MovieClipLoader();
image_mcl.addListener(mclListener);
var a = 0;
while (a < num_ans)
{
    if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct == "Yes")
    {
        Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        CResponse[a] = true;
        ++corr_ans;
        visibility[a] = true;
        ansID[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.aID;
    }
    else if (rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.Correct == "No")
    {
        Distractors[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].childNodes[0].nodeValue;
        CResponse[a] = false;
        visibility[a] = true;
        ansID[a] = rootNode.childNodes[quest_order[qCount]].childNodes[ans_order[a] + 1].attributes.aID;
    }
    else
    {
        CResponse[a] = false;
        Distractors[a] = "";
        visibility[a] = false;
    } // end else if
    ++a;
} // end while
testText.text = testText.text + ("Distractors = " + Distractors + "\n");
var f = 0;
while (f < max_ans)
{
    image_mcl.loadClip(Distractors[f], this["HotObject" + (f + 1)].image);
    ++f;
} // end while
if (corr_ans == 1)
{
    feedback_text = "Sorry, the correct answer is highlighted in green.";
}
else
{
    feedback_text = "Sorry, the correct answers are highlighted in green.";
} // end else if
countThis();
stop ();

// [Action in Frame 104]
updateAfterEvent();
gotoAndPlay("Quiz_rep");

// [Action in Frame 105]
if (_global.trackObj.data[curr_outline][curr_subj][curr_topic] == 0)
{
    show_out_bullet(curr_subj, curr_topic, curr_outline);
    _global.trackObj.data[curr_outline][curr_subj][curr_topic] = 1;
    sec_comp = check_sec_complete(curr_subj);
    if (curr_outline == "outline")
    {
        if (sec_comp)
        {
            _global.trackObj.data.toc[curr_subj] = 1;
            show_toc_bullet(curr_subj);
        } // end if
    } // end if
    if (sec_comp && checkMark.toLowerCase().substr(0, 1) == "y")
    {
        _global.trackObj.data[curr_outline][curr_subj][0] = 2;
        out_obj["w_" + curr_outline]["out" + curr_subj + "-0"].oDot.outDot_mc.removeMovieClip();
        out_obj["w_" + curr_outline]["out" + curr_subj + "-0"].oDot.drawOutDot(outDotProp[0], outDotProp[1], "m");
        store_outline();
    } // end if
} // end if
qItemTrack.text = "Item " + curr_item + " of " + total_items;
qItemTrack.setTextFormat(clipProg);
details._visible = false;
details.setMask(details_mask);
if (show_detail)
{
    detail_result._visible = true;
    detail_result.label = "Show Detailed Results";
    detail_result.color = qbuttons.color;
} // end if
if (show_courseRet.substring(0, 1).toLowerCase() == "y")
{
    course_return._visible = true;
    course_return.label = courseRet_txt;
    course_return.color = qbuttons.color;
} // end if
if (rootNode.attributes.SectionID != undefined)
{
    _root.sectID = rootNode.attributes.SectionID;
} // end if
if (_root.lms == "TRUE")
{
    var sumData = _root.quizSec + "|" + points_pos + "|" + _global.total_correct + "|" + _root.sectID;
    _root.resend_data.push(sumData);
    getURL("FSCommand:append", sumData);
    fscommand("send");
} // end if
if (weighted)
{
    correctAns.text = "Total Points:";
    totalPos.text = "# of Points Possible:";
}
else
{
    correctAns.text = "Total Correct:";
    totalPos.text = "# of Questions:";
} // end else if
quizRes.setTextFormat(questTxt);
correctAns.setTextFormat(ansTxt);
totalPos.setTextFormat(ansTxt);
totalScr.setTextFormat(ansTxt);
correctAns_num.setTextFormat(ansTxt);
totalPos_num.setTextFormat(ansTxt);
totalScr_num.setTextFormat(ansTxt);
fade.play();
updateAfterEvent();
stop ();

// [Action in Frame 106]
stop ();
