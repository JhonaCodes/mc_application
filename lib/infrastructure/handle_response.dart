import 'dart:developer';

class HandleResponse{
  Map<dynamic, dynamic> response;
  HandleResponse(this.response);

  factory HandleResponse.fromError(error, trackTrace){
    log("HandleResponse.handleResponse.error = $error");
    log("HandleResponse.handleResponse.trackTrace = $trackTrace");
    return HandleResponse({
      "error": "$error",
      "trackTrace": "$trackTrace",
    });
  }

}