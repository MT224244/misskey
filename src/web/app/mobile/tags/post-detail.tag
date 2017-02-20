<mk-post-detail>
	<div class="fetching" if={ fetching }>
		<mk-ellipsis-icon></mk-ellipsis-icon>
	</div>
	<div class="main" if={ !fetching }>
		<button class="read-more" if={ p.reply_to && p.reply_to.reply_to_id && context == null } onclick={ loadContext } disabled={ loadingContext }>
			<i class="fa fa-ellipsis-v" if={ !loadingContext }></i>
			<i class="fa fa-spinner fa-pulse" if={ loadingContext }></i>
		</button>
		<div class="context">
			<virtual each={ post in context }>
				<mk-post-preview post={ post }></mk-post-preview>
			</virtual>
		</div>
		<div class="reply-to" if={ p.reply_to }>
			<mk-post-preview post={ p.reply_to }></mk-post-preview>
		</div>
		<div class="repost" if={ isRepost }>
			<p>
				<a class="avatar-anchor" href={ CONFIG.url + '/' + post.user.username }>
					<img class="avatar" src={ post.user.avatar_url + '?thumbnail&size=32' } alt="avatar"/></a>
					<i class="fa fa-retweet"></i><a class="name" href={ CONFIG.url + '/' + post.user.username }>
					{ post.user.name }
				</a>
				がRepost
			</p>
		</div>
		<article>
			<header>
				<a class="avatar-anchor" href={ CONFIG.url + '/' + p.user.username }>
					<img class="avatar" src={ p.user.avatar_url + '?thumbnail&size=64' } alt="avatar"/>
				</a>
				<div>
					<a class="name" href={ CONFIG.url + '/' + p.user.username }>{ p.user.name }</a>
					<span class="username">@{ p.user.username }</span>
				</div>
			</header>
			<div class="body">
				<div class="text" ref="text"></div>
				<div class="media" if={ p.media }>
					<virtual each={ file in p.media }><img src={ file.url + '?thumbnail&size=512' } alt={ file.name } title={ file.name }/></virtual>
				</div>
				<mk-poll if={ p.poll } post={ p }></mk-poll>
			</div><a class="time" href={ url }>
				<mk-time time={ p.created_at } mode="detail"></mk-time></a>
			<footer>
				<button onclick={ reply } title="返信"><i class="fa fa-reply"></i>
					<p class="count" if={ p.replies_count > 0 }>{ p.replies_count }</p>
				</button>
				<button onclick={ repost } title="Repost"><i class="fa fa-retweet"></i>
					<p class="count" if={ p.repost_count > 0 }>{ p.repost_count }</p>
				</button>
				<button class={ liked: p.is_liked } onclick={ like } title="善哉"><i class="fa fa-thumbs-o-up"></i>
					<p class="count" if={ p.likes_count > 0 }>{ p.likes_count }</p>
				</button>
				<button onclick={ NotImplementedException }><i class="fa fa-ellipsis-h"></i></button>
			</footer>
			<div class="reposts-and-likes">
				<div class="reposts" if={ reposts && reposts.length > 0 }>
					<header><a>{ p.repost_count }</a>
						<p>Repost</p>
					</header>
					<ol class="users">
						<li class="user" each={ reposts }>
							<a class="avatar-anchor" href={ CONFIG.url + '/' + user.username } title={ user.name }>
							<img class="avatar" src={ user.avatar_url + '?thumbnail&size=32' } alt=""/></a>
						</li>
					</ol>
				</div>
				<div class="likes" if={ likes && likes.length > 0 }>
					<header><a>{ p.likes_count }</a>
						<p>いいね</p>
					</header>
					<ol class="users">
						<li class="user" each={ likes }>
							<a class="avatar-anchor" href={ CONFIG.url + '/' + username } title={ name }>
							<img class="avatar" src={ avatar_url + '?thumbnail&size=32' } alt=""/></a>
						</li>
					</ol>
				</div>
			</div>
		</article>
		<div class="replies">
			<virtual each={ post in replies }>
				<mk-post-detail-sub post={ post }></mk-post-detail-sub>
			</virtual>
		</div>
	</div>
	<style>
		:scope
			display block
			margin 0
			padding 0

			> .fetching
				padding 64px 0

			> .main

				> .read-more
					display block
					margin 0
					padding 10px 0
					width 100%
					font-size 1em
					text-align center
					color #999
					cursor pointer
					background #fafafa
					outline none
					border none
					border-bottom solid 1px #eef0f2
					border-radius 6px 6px 0 0
					box-shadow none

					&:hover
						background #f6f6f6

					&:active
						background #f0f0f0

					&:disabled
						color #ccc

				> .context
					> *
						border-bottom 1px solid #eef0f2

				> .repost
					color #9dbb00
					background linear-gradient(to bottom, #edfde2 0%, #fff 100%)

					> p
						margin 0
						padding 16px 32px

						.avatar-anchor
							display inline-block

							.avatar
								vertical-align bottom
								min-width 28px
								min-height 28px
								max-width 28px
								max-height 28px
								margin 0 8px 0 0
								border-radius 6px

						i
							margin-right 4px

						.name
							font-weight bold

					& + article
						padding-top 8px

				> .reply-to
					border-bottom 1px solid #eef0f2

				> article
					padding 14px 16px 9px 16px

					@media (min-width 500px)
						padding 28px 32px 18px 32px

					&:after
						content ""
						display block
						clear both

					&:hover
						> .main > footer > button
							color #888

					> header
						display flex
						line-height 1.1

						> .avatar-anchor
							display block
							padding 0 .5em 0 0

							> .avatar
								display block
								width 54px
								height 54px
								margin 0
								border-radius 8px
								vertical-align bottom

								@media (min-width 500px)
									width 60px
									height 60px

						> div

							> .name
								display inline-block
								margin .4em 0
								color #777
								font-size 16px
								font-weight bold
								text-align left
								text-decoration none

								&:hover
									text-decoration underline

							> .username
								display block
								text-align left
								margin 0
								color #ccc

					> .body
						padding 8px 0

						> .text
							cursor default
							display block
							margin 0
							padding 0
							overflow-wrap break-word
							font-size 16px
							color #717171

							@media (min-width 500px)
								font-size 24px

							> mk-url-preview
								margin-top 8px

						> .media
							> img
								display block
								max-width 100%

					> .time
						font-size 16px
						color #c0c0c0

					> footer
						font-size 1.2em

						> button
							margin 0 28px 0 0
							padding 8px
							background transparent
							border none
							box-shadow none
							font-size 1em
							color #ddd
							cursor pointer

							&:hover
								color #666

							> .count
								display inline
								margin 0 0 0 8px
								color #999

							&.liked
								color $theme-color

					> .reposts-and-likes
						display flex
						justify-content center
						padding 0
						margin 16px 0

						&:empty
							display none

						> .reposts
						> .likes
							display flex
							flex 1 1
							padding 0
							border-top solid 1px #F2EFEE

							> header
								flex 1 1 80px
								max-width 80px
								padding 8px 5px 0px 10px

								> a
									display block
									font-size 1.5em
									line-height 1.4em

								> p
									display block
									margin 0
									font-size 0.7em
									line-height 1em
									font-weight normal
									color #a0a2a5

							> .users
								display block
								flex 1 1
								margin 0
								padding 10px 10px 10px 5px
								list-style none

								> .user
									display block
									float left
									margin 4px
									padding 0

									> .avatar-anchor
										display:block

										> .avatar
											vertical-align bottom
											width 24px
											height 24px
											border-radius 4px

						> .reposts + .likes
							margin-left 16px

				> .replies
					> *
						border-top 1px solid #eef0f2

	</style>
	<script>
		this.mixin('api');
		this.mixin('text');
		this.mixin('get-post-summary');
		this.mixin('open-post-form');

		this.fetching = true
		this.loading-context = false
		this.content = null
		this.post = null

		this.on('mount', () => {
			this.api 'posts/show' do
				post_id: this.opts.post
			.then (post) =>
				this.post = post
				this.is-repost = @post.repost?
				this.p = if @is-repost then @post.repost else @post
				this.summary = @get-post-summary @p
				this.trigger('loaded');
				this.fetching = false
				this.update();

				if @p.text?
					tokens = @analyze @p.text
					this.refs.text.innerHTML = @compile tokens

					this.refs.text.children.for-each (e) =>
						if e.tag-name == 'MK-URL' 
							riot.mount e

					// URLをプレビュー
					tokens
						.filter (t) -> t.type == 'link' 
						.map (t) =>
							this.preview = this.refs.text.appendChild document.createElement 'mk-url-preview' 
							riot.mount @preview, do
								url: t.content

				// Get likes
				this.api 'posts/likes' do
					post_id: @p.id
					limit: 8
				.then (likes) =>
					this.likes = likes
					this.update();

				// Get reposts
				this.api 'posts/reposts' do
					post_id: @p.id
					limit: 8
				.then (reposts) =>
					this.reposts = reposts
					this.update();

				// Get replies
				this.api 'posts/replies' do
					post_id: @p.id
					limit: 8
				.then (replies) =>
					this.replies = replies
					this.update();

		this.reply = () => {
			@open-post-form do
				reply: @p

		this.repost = () => {
			text = window.prompt '「' + @summary + '」をRepost'
			if text?
				this.api 'posts/create' do
					repost_id: @p.id
					text: if text == '' then undefined else text

		this.like = () => {
			if @p.is_liked
				this.api 'posts/likes/delete' do
					post_id: @p.id
				.then =>
					@p.is_liked = false
					this.update();
			else
				this.api 'posts/likes/create' do
					post_id: @p.id
				.then =>
					@p.is_liked = true
					this.update();

		this.load-context = () => {
			this.loading-context = true

			// Get context
			this.api 'posts/context' do
				post_id: @p.reply_to_id
			.then (context) =>
				this.context = context.reverse!
				this.loading-context = false
				this.update();
	</script>
</mk-post-detail>
