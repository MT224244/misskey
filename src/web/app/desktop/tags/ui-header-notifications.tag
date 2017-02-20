<mk-ui-header-notifications>
	<button class="header" data-active={ isOpen } onclick={ toggle }><i class="fa fa-bell-o"></i></button>
	<div class="notifications" if={ isOpen }>
		<mk-notifications></mk-notifications>
	</div>
	<style>
		:scope
			display block
			float left

			> .header
				display block
				margin 0
				padding 0
				width 32px
				color #9eaba8
				border none
				background transparent
				cursor pointer

				*
					pointer-events none

				&:hover
					color darken(#9eaba8, 20%)

				&:active
					color darken(#9eaba8, 30%)

				&[data-active='true']
					color darken(#9eaba8, 20%)

				> i
					font-size 1.2em
					line-height 48px

			> .notifications
				display block
				position absolute
				top 56px
				right -72px
				width 300px
				background #fff
				border-radius 4px
				box-shadow 0 1px 4px rgba(0, 0, 0, 0.25)

				&:before
					content ""
					pointer-events none
					display block
					position absolute
					top -28px
					right 74px
					border-top solid 14px transparent
					border-right solid 14px transparent
					border-bottom solid 14px rgba(0, 0, 0, 0.1)
					border-left solid 14px transparent

				&:after
					content ""
					pointer-events none
					display block
					position absolute
					top -27px
					right 74px
					border-top solid 14px transparent
					border-right solid 14px transparent
					border-bottom solid 14px #fff
					border-left solid 14px transparent

				> mk-notifications
					max-height 350px
					font-size 1rem
					overflow auto

	</style>
	<script>
		this.is-open = false

		this.toggle = () => {
			if @is-open
				@close!
			else
				@open!

		this.open = () => {
			this.is-open = true
			this.update();
			all = document.query-selector-all 'body *'
			Array.prototype.for-each.call all, (el) =>
				el.addEventListener 'mousedown' @mousedown

		this.close = () => {
			this.is-open = false
			this.update();
			all = document.query-selector-all 'body *'
			Array.prototype.for-each.call all, (el) =>
				el.removeEventListener 'mousedown' @mousedown

		this.mousedown = (e) => {
			e.preventDefault();
			if (!contains this.root, e.target) and (this.root != e.target)
				@close!
			return false

		function contains(parent, child)
			node = child.parentNode
			while node?
				if node == parent
					return true
				node = node.parentNode
			return false
	</script>
</mk-ui-header-notifications>
