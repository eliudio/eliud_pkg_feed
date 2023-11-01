
class PostHelper {
  static String getLikeKey(String? postId, String? postCommentId, String? memberId) {
    if ((postId == null) && (postCommentId == null) && (memberId == null)) return '';
    if ((postId == null) && (postCommentId == null)) return memberId!;
    if ((postId == null) && (memberId == null)) return postCommentId!;
    if ((postCommentId == null) && (memberId == null)) return postId!;
    if (postId == null) return postCommentId! + '-' + memberId!;
    if (postCommentId == null) return postId + '-' + memberId!;
    if (memberId == null) return postId + '-' + postCommentId;
    return postId + '-' + postCommentId + '-' + memberId;
  }
}
