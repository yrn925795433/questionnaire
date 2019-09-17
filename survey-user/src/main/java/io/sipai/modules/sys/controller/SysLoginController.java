

package io.sipai.modules.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import io.sipai.common.utils.R;
import io.sipai.modules.sys.entity.SysUserEntity;
import io.sipai.modules.sys.service.SysUserService;
import io.sipai.modules.sys.shiro.ShiroUtils;
import io.sipai.modules.user.entity.TestsEntity;
import io.sipai.modules.user.service.AnswersService;
import io.sipai.modules.user.service.TestsService;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Date;

/**
 * 登录相关
 */
@Controller
public class SysLoginController {
	@Autowired
	private Producer producer;
	@Autowired
	private SysUserService userService;
	@Autowired
	private AnswersService answersService;
	@Autowired
	private TestsService testsService;
	
	@RequestMapping("captcha.jpg")
	public void captcha(HttpServletResponse response)throws IOException {
        response.setHeader("Cache-Control", "no-store, no-cache");
        response.setContentType("image/jpeg");

        //生成文字验证码
        String text = producer.createText();
        //生成图片验证码
        BufferedImage image = producer.createImage(text);
        //保存到shiro session
        ShiroUtils.setSessionAttribute(Constants.KAPTCHA_SESSION_KEY, text);
        
        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(image, "jpg", out);
	}
	
	/**
	 * 登录
	 */
	@ResponseBody
	@RequestMapping(value = "/sys/login")
	public R login(@RequestBody SysUserEntity user) {

		if(user.getType() ==1 ) {
			try {
				Subject subject = ShiroUtils.getSubject();
				UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(),user.getPassword());
				subject.login(token);
			} catch (UnknownAccountException e) {
				return R.error(e.getMessage());
			} catch (IncorrectCredentialsException e) {
				return R.error("账号或密码不正确");
			} catch (LockedAccountException e) {
				return R.error("账号已被锁定,请联系管理员");
			} catch (AuthenticationException e) {
				return R.error("账户验证失败");
			}
		}else {
			user.setStatus(1);
			userService.saveUser(user);
			SysUserEntity useranswerEntity = userService.getOne(new QueryWrapper<SysUserEntity>().eq("username",user.getUsername()).orderBy(true,false,"create_time"));
			//生成该用户的题目
			TestsEntity testEntity =new TestsEntity();
			testEntity.setUserId(useranswerEntity.getUserId());
			testEntity.setTestStatus(0L);
			testsService.save(testEntity);
			TestsEntity ne=testsService.getOne(new QueryWrapper<TestsEntity>().orderBy(true,false,"test_time"));
			answersService.insertAnswers(ne.getTestsId());

		}

		return R.ok();
	}
	/**
	 * 用户注册
	 */
	@ResponseBody
	@RequestMapping(value ="/sys/register")
	public R register(@RequestBody SysUserEntity user){
		userService.saveUser(user);
		return R.ok();
	}

	/**
	 * 退出
	 */
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout() {
		ShiroUtils.logout();
		return "redirect:login.html";
	}
	
}
