<g:if test="${post.mainImage}">
  <g:img uri="/attachment/show?name=${post.name}&file=${post.mainImage}" class="img-rounded img-responsive"/>
</g:if>
<g:elseif test="${post?.product?.mainImage}">
  <g:img uri="/attachment/show?name=${post.product.name}&file=${post.product.mainImage}" class="img-rounded img-responsive" />
</g:elseif>