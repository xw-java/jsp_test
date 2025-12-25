<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="dataBean" class="com.design.project_design.Record_Bean" scope="session"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>商品列表</title>
</head>
<body>
<div class="container">
    <jsp:setProperty name="dataBean" property="pageSize" param="pageSize"/>
    <jsp:setProperty name="dataBean" property="currentPage" param="currentPage"/>

    <div class="card">
        <h2 class="card-title">📱 商品展示</h2>

        <% String[][] table = dataBean.getTableRecord();
            if (table == null || table.length == 0) {
                out.print("<div style='text-align:center; padding:30px; color:#999;'>暂无数据，请先选择分类或搜索</div>");
            } else {
        %>

        <div class="goods-grid">
            <%
                int totalRecord = table.length;
                int pageSize = dataBean.getPageSize();
                int totalPages = dataBean.getTotalPages();
                if (totalRecord % pageSize == 0) totalPages = totalRecord / pageSize;
                else totalPages = totalRecord / pageSize + 1;

                dataBean.setPageSize(pageSize);
                dataBean.setTotalPages(totalPages);

                if (totalPages >= 1) {
                    if (dataBean.getCurrentPage() < 1) dataBean.setCurrentPage(dataBean.getTotalPages());
                    if (dataBean.getCurrentPage() > dataBean.getTotalPages()) dataBean.setCurrentPage(1);
                }

                int index = (dataBean.getCurrentPage() - 1) * pageSize;

                for (int i = index; i < pageSize + index; i++) {
                    if (i >= totalRecord) break;
                    String id = table[i][0];
                    String name = table[i][1];
                    String made = table[i][2];
                    String price = table[i][3];
                    String pic = "default.png";
                    // 防止旧代码只查了4列导致数组越界
                    if(table[i].length > 4 && table[i][4] != null) pic = table[i][4];
            %>
            <div class="product-card">
                <div class="product-img">
                    <img src="image/<%=pic%>" onerror="this.src='image/default.png'" alt="<%=name%>">
                </div>
                <div class="product-body">
                    <div class="product-title" title="<%=name%>"><%=name%></div>
                    <div class="product-meta">制造商：<%=made%></div>
                    <div class="product-price">¥ <%=price%></div>
                    <div class="product-actions">
                        <a href="showDetail.jsp?mobileID=<%=id%>" class="btn btn-outline" style="flex:1; font-size:12px;">详情</a>
                        <a href="putGoodsServlet?mobileID=<%=id%>" class="btn btn-primary" style="flex:1; font-size:12px;">加购</a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <div style="margin-top: 40px; display: flex; justify-content: center; align-items: center; gap: 10px;">
            <form action="" method="post"><input type="hidden" name="currentPage" value="<%= dataBean.getCurrentPage()-1 %>"><input type="submit" value="上一页" class="btn btn-outline" <%=dataBean.getCurrentPage()<=1?"disabled":""%>></form>
            <span>第 <%=dataBean.getCurrentPage()%> / <%=totalPages%> 页</span>
            <form action="" method="post"><input type="hidden" name="currentPage" value="<%= dataBean.getCurrentPage()+1 %>"><input type="submit" value="下一页" class="btn btn-outline" <%=dataBean.getCurrentPage()>=totalPages?"disabled":""%>></form>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
