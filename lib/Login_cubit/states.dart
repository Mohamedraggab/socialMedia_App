abstract class AppState {}
class InitAppState extends AppState {}
class ChangeIndexAppState extends AppState {}


class LoginAppState extends AppState {}
class LoginSuccessAppState extends AppState {}
class LoginErrorAppState extends AppState {}


class RegisterAppState extends AppState {}
class RegisterSuccessAppState extends AppState {}
class RegisterErrorAppState extends AppState {}


class CreateUserAppState extends AppState {}
class CreateUserSuccessAppState extends AppState {}
class CreateUserErrorAppState extends AppState {}


class GetUserAppState extends AppState {}
class GetUserSuccessAppState extends AppState {
  final String uId ;
  GetUserSuccessAppState(this.uId);
}
class GetUserErrorAppState extends AppState {}


class ChangeIndexLayoutState extends AppState {}


class GetImageLayoutState extends AppState {}
class GetImageSuccessLayoutState extends AppState {}
class GetImageErrorLayoutState extends AppState {}


class GetCoverLayoutState extends AppState {}
class GetCoverSuccessLayoutState extends AppState {}
class GetCoverErrorLayoutState extends AppState {}


class UploadImageLayoutState extends AppState {}
class UploadImageSuccessLayoutState extends AppState {}
class UploadImageErrorLayoutState extends AppState {}


class UploadCoverLayoutState extends AppState {}
class UploadCoverSuccessLayoutState extends AppState {}
class UploadCoverErrorLayoutState extends AppState {}


class UpdateUserLayoutState extends AppState {}
class UpdateUserSuccessLayoutState extends AppState {}
class UpdateUserErrorLayoutState extends AppState {}

class UpdateUserProfileLayoutState extends AppState {}
class UpdateUserProfileSuccessLayoutState extends AppState {}
class UpdateUserProfileErrorLayoutState extends AppState {}



class UpdateUserCoverLayoutState extends AppState {}
class UpdateUserCoverSuccessLayoutState extends AppState {}
class UpdateUserCoverErrorLayoutState extends AppState {}



////////////post///////

class UploadPostImageLayoutState extends AppState {}
class UploadPostImageSuccessLayoutState extends AppState {}
class UploadPostImageErrorLayoutState extends AppState {}




class CreatePostAppState extends AppState {}
class CreatePostSuccessAppState extends AppState {}
class CreatePostErrorAppState extends AppState {}




class CreatePostImageAppState extends AppState {}
class CreatePostImageSuccessAppState extends AppState {}
class CreatePostImageErrorAppState extends AppState {}



class RemovePostImageAppState extends AppState {}



class GetPostsLayoutState extends AppState {}
class GetPostsSuccessLayoutState extends AppState {}
class GetPostsErrorLayoutState extends AppState {}


class LikePostsLayoutState extends AppState {}
class LikePostsSuccessLayoutState extends AppState {}
class LikePostsErrorLayoutState extends AppState {}


class CommentPostsLayoutState extends AppState {}
class CommentPostsSuccessLayoutState extends AppState {}
class CommentPostsErrorLayoutState extends AppState {}



class CommentGetLayoutState extends AppState {}
class CommentGetSuccessLayoutState extends AppState {}
class CommentGetErrorLayoutState extends AppState {}




class GetAllUsersState extends AppState {}
class GetAllUsersSuccessState extends AppState {}
class GetAllUsersErrorState extends AppState {}


class SendMessageState extends AppState {}
class SendMessageSuccessState extends AppState {}
class SendMessageErrorState extends AppState {}


class GetMessageState extends AppState {}
class GetMessageSuccessState extends AppState {}



class SearchAppState extends AppState {}

class SearchSuccessAppState extends AppState {}

