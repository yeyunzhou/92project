<template>
    <div class="">
           <el-row>
        <el-col :span="5">
          <el-button type="primary" @click="selectdata" >交易明细</el-button>
        </el-col>
      </el-row>
 <el-table
      :data="pageInfo"
      ref="singleTable"
      style="width: 100%">
      <el-table-column
        prop="hid"
        label="编号"
        width="150">
      </el-table-column>
      <el-table-column
        prop="timeString"
        label="建筑年份"
        width="150">
      </el-table-column>
    <el-table-column
        prop="checkTimeString"
        label="入住时间"
        width="150">
      </el-table-column>
       <el-table-column
       prop='houseString'
       width="150"
        label="位置">
      </el-table-column>
       <el-table-column
        prop="structure"
        width="150"
        label="户型">
      </el-table-column>
       <el-table-column
        prop="area"
        width="150"
        label="面积">
      </el-table-column>
       <el-table-column
        prop="price"
        width="150"
        label="单价">
      </el-table-column>
       <el-table-column
        prop="endTimeString"
        width="150"
        label="费用到期时间">
      </el-table-column>
       <el-table-column
      label="操作"
      width="200">
      <template slot-scope="scope" >
        <el-button @click="updated(scope.row)"   type="text" size="small">续费</el-button>
      </template>
    </el-table-column>
    </el-table>

<el-dialog
  title="物业费交易记录"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible"
  width="90%"
 >
 <el-table
      :data="Detail.list"
      ref="singleTable2"
      style="width: 100%">
      <el-table-column
        prop="did"
        label="编号"
        width="180">
      </el-table-column>
      <el-table-column
        prop="houser.houseString"
        label="房屋"
        width="180">
      </el-table-column>
      <el-table-column
        prop="price"
        label="金额">
      </el-table-column>
       <el-table-column
        prop="beginTimeString"  
        label="开始时间">
      </el-table-column>
        <el-table-column
        prop="endString"
        label="结束时间">
      </el-table-column>
        <el-table-column
        prop="employee.ename"
        label="收费人">
      </el-table-column>
       <el-table-column
        prop="way"
        label="缴费方式">
      </el-table-column>
      
    </el-table>
    
    <el-row>
      <el-col :span="5">
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :page-sizes="[6, 10, 15]"
      :page-size="Detail.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="Detail.total">
    </el-pagination>

      </el-col>
    </el-row>
</el-dialog>


<el-dialog
  title="支付宝支付"
  center
  :close-on-click-modal="false"
  :visible.sync="dialogVisible2"
  width="50%"
 >
 <div id="main">
		<div id="tabhead" class="tab-head">
			<h2 id="tab1" class="selected" name="tab">付 款</h2>
		</div>
			<div id="body1" class="show" name="divcontent">
				<dl class="content">
					<dt>商户订单号 ：</dt>
					<dd>
						<el-input id="WIDout_trade_no" name="WIDout_trade_no"  readonly="readonly" v-model="orders.id" ></el-input>
					</dd>
					<hr class="one_line">
					<dt>订单数量 ：</dt>
					
						
<div class="gw_num">

    <em class="jian" @click="jian">-</em>

    <input type="text"  class="num"  v-model="orders.sum"/>

    <em class="add" @click="jia">+</em>

</div>
					<hr class="one_line">
					<dt>付款金额 ：</dt>
					<dd>
						<el-input id="WIDtotal_amount" name="WIDtotal_amount"  readonly="readonly"  v-model="orders.prices" >
            </el-input>
					</dd>
					<hr class="one_line">
					<dt>商品描述：</dt>
					<dd>
						<input id="WIDbody" name="WIDbody" value="交物业费用" readonly="readonly"  />
					</dd>
					<hr class="one_line">
					<dt></dt>
					<dd id="btn-dd">
						<span class="new-btn-login-sp">
			<el-button class="new-btn-login" type="submit"
								style="text-align: center;" @click="payment">付款</el-button> 
              		<!-- <a  @click="payment" href="http://localhost:9090/alipay/toPay/200">付款</a>
            
            -->
						</span><br>
             <span class="note-hfelp">如果您点击“付款”按钮，即表示您同意该次的执行操作。</span>
					</dd>
				</dl>
			</div>
	  
		
		<div id="foot">
			<ul class="foot-ul">
				<li>支付宝版权所有 2015-2018 ALIPAY.COM</li>
			</ul>
		</div>
	</div>
</el-dialog>




    
    </div>
</template>

<script>
import axios from "axios";
export default {
    name: "",
    data() {
        return {
    dialogVisible:false,
    dialogVisible2:false,
     pageInfo:null,
     list:null,
     Detail:null,
       orders:{
           price:'',
            id:'',
            sum:1,
            hid:null,
            prices:null,

          },
        }
    },
    components: {},
    methods: {
        findByid(page=1,pageSize=6){
             let url="House/findBypid";
            axios.post(url).then((response)=>{
               this.pageInfo=response.data;
               console.log( this.pageInfo);
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });
            

        },

        findByid2(page=1,pageSize=6){
             let url="Detail/finBypid";
              let params= new URLSearchParams();
            params.append("page",page);
            params.append("pageSize",pageSize);
            axios.post(url,params).then((response)=>{
               this.Detail=response.data;
               console.log( this.Detail);
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });
            

        },

         updated(row) {
          this.orders.id  =new Date().getTime();
          this.orders.price=row.price*row.area;
          this.orders.prices=row.price*row.area;
           this.orders.hid=row.hid;
           this.orders.sum=1;
          this.dialogVisible2=true;

        },


        selectdata(){
            this.dialogVisible=true;
             this.findByid2();
        },

         handleCurrentChange(page){
          this.findByid2(page,this.Detail.pageSize);

        },
        handleSizeChange(pageSize){
           this.findByid2(this.Detail.page,pageSize);
        },

          jia(){
          if(this.orders.sum>9){
            this.orders.sum=10;

          }else{
              this.orders.sum++;
               this.orders.prices=this.orders.sum*this.orders.price
             
          }

        },
        jian(){

          if(this.orders.sum<=1){
            this.orders.sum=1;

          }else{
              this.orders.sum--;
              this.orders.prices=this.orders.sum*this.orders.price
             
          }

        },
         payment(){
            let url="Transactions/save";
              let params= new URLSearchParams();
            params.append("id",this.orders.hid);
            params.append("price",this.orders.prices);
            params.append("type",2);
            params.append("sum",this.orders.sum);
            axios.post(url,params).then((response)=>{
                console.log(response.data);
                if(response.data>0){
                 window.location.href ="http://localhost:9090/alipay/toPay/"+this.orders.prices;
                }
               
            }).catch((ex)=>{
                //出现异常
                console.log(ex);
            });

         }
    },
    mounted(  ) {
         this.findByid();
         this.findByid2();
         
      // this.TransactionsfindByid();
    
  }
}
</script>

<style  scoped>


* {
	margin: 0;
	padding: 0;
}

ul, ol {
	list-style: none;
}

body {
	font-family: "Helvetica Neue", Helvetica, Arial, "Lucida Grande",
		sans-serif;
}

.tab-head {
	margin-left: 120px;
	margin-bottom: 10px;
}

.tab-content {
	clear: left;
	display: none;
}

h2 {
	border-bottom: solid #02aaf1 2px;
	width: 200px;
	height: 25px;
	margin: 0;
	float: left;
	text-align: center;
	font-size: 16px;
}

.selected {
	color: #FFFFFF;
	background-color: #02aaf1;
}

.show {
	clear: left;
	display: block;
}

.hidden {
	display: none;
}

.new-btn-login-sp {
	padding: 1px;
	display: inline-block;
	width: 75%;
}

.new-btn-login {
	background-color: #02aaf1;
	color: #FFFFFF;
	font-weight: bold;
	border: none;
	width: 100%;
	height: 30px;
	border-radius: 5px;
	font-size: 16px;
}

#main {
	width: 100%;
	margin: 0 auto;
	font-size: 14px;
}

.red-star {
	color: #f00;
	width: 10px;
	display: inline-block;
}

.null-star {
	color: #fff;
}

.content {
	margin-top: 5px;
}

.content dt {
	width: 100px;
	display: inline-block;
	float: left;
	margin-left: 20px;
	color: #666;
	font-size: 13px;
	margin-top: 8px;
}

.content dd {
	margin-left: 120px;
	margin-bottom: 5px;
}

.content dd input {
	width: 85%;
	height: 28px;
	border: 0;
	-webkit-border-radius: 0;
	-webkit-appearance: none;
}

#foot {
	margin-top: 10px;
	position: absolute;
	bottom: 15px;
	width: 100%;
}

.foot-ul {
	width: 100%;
}

.foot-ul li {
	width: 100%;
	text-align: center;
	color: #666;
}

.note-help {
	color: #999999;
	font-size: 12px;
	line-height: 130%;
	margin-top: 5px;
	width: 100%;
	display: block;
}

#btn-dd {
	margin: 20px;
	text-align: center;
}

.foot-ul {
	width: 100%;
}

.one_line {
	display: block;
	height: 1px;
	border: 0;
	border-top: 1px solid #eeeeee;
	width: 100%;
	margin-left: 20px;
}

.am-header {
	display: -webkit-box;
	display: -ms-flexbox;
	display: box;
	width: 100%;
	position: relative;
	padding: 7px 0;
	-webkit-box-sizing: border-box;
	-ms-box-sizing: border-box;
	box-sizing: border-box;
	background: #1D222D;
	height: 50px;
	text-align: center;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	box-pack: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	box-align: center;
}

.am-header h1 {
	-webkit-box-flex: 1;
	-ms-flex: 1;
	box-flex: 1;
	line-height: 18px;
	text-align: center;
	font-size: 18px;
	font-weight: 300;
	color: #fff;
}

.gw_num{

            border: 1px solid #dbdbdb;

            width: 110px;line-height: 35px;

            overflow: hidden;

        }

        .gw_num em{display: block;

            height: 35px;

            width: 31px;

            float: left;

            color: #7A7979;

            border-right: 1px solid #dbdbdb;

            text-align: center;

            cursor: pointer;

            font-style:normal;

        }

        .gw_num .num{display: block;

            float: left;

            text-align: center;

            width: 42px;

            font-style: normal;

            font-size: 14px;

            line-height: 35px;

            border: 0;

        }

        .gw_num em.add{

            float: right;

            border-right: 0;

            border-left: 1px solid #dbdbdb;

        }
</style>
