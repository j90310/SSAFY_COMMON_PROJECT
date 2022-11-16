class Report {
  int reportSeq;
  int reportedUserSeq;
  int reportingUserSeq;
  String reportContent;
  String crimeName;

  Report(
      {required this.reportSeq,
        required this.reportedUserSeq,
        required this.reportingUserSeq,
        required this.reportContent,
        required this.crimeName});
  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        reportSeq: json['reportSeq'],
        reportedUserSeq: json['reportedUserSeq'],
        reportingUserSeq: json['reportingUserSeq'],
        reportContent: json['reportContent'],
        crimeName: json['crimeName']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportSeq'] = this.reportSeq;
    data['reportedUserSeq'] = this.reportedUserSeq;
    data['reportingUserSeq'] = this.reportingUserSeq;
    data['reportContent'] = this.reportContent;
    data['crimeName'] = this.crimeName;
    return data;
  }
}
