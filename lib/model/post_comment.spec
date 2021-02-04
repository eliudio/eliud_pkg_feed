{
  "id": "PostComment",
  "packageName": "eliud_pkg_feed",
  "isAppModel": true,
  "generate": {
    "generateComponent": true,
    "generateRepository": true,
    "generateCache": true,
	"hasPersistentRepository": true,
    "generateFirestoreRepository": true,
    "generateRepositorySingleton": true,
    "generateModel": true,
    "generateEntity": true,
    "generateForm": true,
    "generateList": true,
    "generateDropDownButton": true,
    "generateInternalComponent": true,
    "generateEmbeddedComponent": false,
    "isExtension": false,
    "isDocumentCollection": true
  },
  "fields": [
    {
      "fieldName": "documentID",
      "displayName": "Document ID",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "postId",
      "displayName": "Document ID of the post",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "postCommentId",
      "displayName": "Document ID of the comment (in case of a comment on comment)",
      "fieldType": "String",
      "iconName": "vpn_key",
      "group": "general"
    },
    {
      "fieldName": "memberId",
      "displayName": "Member",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "timestamp",
      "displayName": "Timestamp",
      "fieldType": "ServerTimestamp",
      "group": "general"
    },
    {
      "fieldName": "appId",
      "displayName": "App Identifier",
      "remark": "This is the identifier of the app to which this feed belongs",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "comment",
      "displayName": "Comment",
      "fieldType": "String",
      "group": "general"
    },
    {
      "fieldName": "likes",
      "displayName": "Likes",
      "fieldType": "int",
      "group": "general"
    },
    {
      "fieldName": "dislikes",
      "displayName": "Dislikes",
      "fieldType": "int",
      "group": "general"
    }
  ],
  "groups": [
    {
        "group": "general",
        "description": "General"
    },
    {
        "group": "member",
        "description": "Member"
    }
 ],
  "listFields": {
    "title": "timestamp.toString()",
    "subTitle": "documentID"
  },
  "depends": ["eliud_core", "eliud_pkg_membership"]
}